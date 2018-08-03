//
//  AddCustomCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/30.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddCustomCommodityViewController.h"
#import "AddCustomCommodityView.h"
#import "ShopClassificationViewController.h"
#import "CommodityHandler.h"
#import <AliyunOSSiOS/OSSService.h>
#import "CommodityFromCodeEntity.h"

@interface AddCustomCommodityViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>{
    UIImagePickerController *ipc;
}

@property (nonatomic ,strong)AddCustomCommodityView   *v_commodityView;
@property (nonatomic ,strong)NSNumber      *shopCId;
@property (nonatomic ,strong)UIImage       *imgCommodity;
@property (nonatomic ,strong)NSData        *imgData;
@property (strong, nonatomic) OSSClient *client;

@end

@implementation AddCustomCommodityViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建商品";
    
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    [btn_left setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btn_left;
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    
}

- (void)onCreate{
    ipc = [[UIImagePickerController alloc] init];
    //表示用户可编辑图片。
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    
    
    self.v_commodityView = [[AddCustomCommodityView alloc]init];
    [self.view addSubview:self.v_commodityView];
    [self.v_commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_equalTo(SafeAreaTopHeight + 10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - (SafeAreaTopHeight + 10));
    }];
    [self.v_commodityView.v_barcode.tf_detail setText:self.barcode];
    
    [self.v_commodityView.v_commodityName.tf_detail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.v_commodityView.v_commodityDescribe.tf_detail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClassification)];
    [self.v_commodityView.v_shopClassification addGestureRecognizer:singleTap];
    
    self.v_commodityView.img_commodityImgTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer* imgTitleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTitleAction)];
    [self.v_commodityView.img_commodityImgTitle addGestureRecognizer:imgTitleTap];
    [self.v_commodityView.v_shopClassification.tf_detail setText:@"未分类"];
    self.shopCId = [NSNumber numberWithInt:-1];
    
}


//头像按钮点击方法
-(void)imgTitleAction{
    [self.view endEditing:YES];
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addoneCAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    UIAlertAction *addtwoCAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheetController addAction:addoneCAction];
    [actionSheetController addAction:addtwoCAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.imgCommodity = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.v_commodityView.img_commodityImgTitle setImage:self.imgCommodity];
    
    if (UIImagePNGRepresentation(self.imgCommodity) == nil) {
        self.imgData = UIImageJPEGRepresentation(self.imgCommodity, 1);
    } else {
        self.imgData = UIImageJPEGRepresentation(self.imgCommodity, 0.001); //压缩图片，方便上传
    }
}

//店内分类  手势点击方法
- (void)shopClassification{
    ShopClassificationViewController *vc = [[ShopClassificationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackShop = ^(ShopClassificationEntity *shopClassificationEntity) {
        [self.v_commodityView.v_shopClassification.tf_detail setText:shopClassificationEntity.name];
        
        [self.v_commodityView.v_shopClassification.tf_detail setTextColor:[UIColor blackColor]];
        self.shopCId = [NSNumber numberWithInt:(int)shopClassificationEntity._id];
        
    };
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.v_commodityView.v_commodityName.tf_detail) {
        NSInteger kMaxLength = 30;
        NSString *toBeString = textField.text;
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (toBeString.length > kMaxLength) {
                    textField.text = [toBeString substringToIndex:kMaxLength];
                }
            }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
            }
        }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
    }if (textField == self.v_commodityView.v_commodityDescribe.tf_detail) {
        NSInteger kMaxLength = 250;
        NSString *toBeString = textField.text;
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (toBeString.length > kMaxLength) {
                    textField.text = [toBeString substringToIndex:kMaxLength];
                }
            }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
            }
        }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
    }
    
    
}

- (int)convertToInt:(NSString *)strtemp//判断中英混合的的字符串长度
{
    int strlength = 0;
    for (int i=0; i< [strtemp length]; i++) {
        int a = [strtemp characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) { //判断是否为中文
            strlength += 2;
        }
    }
    return strlength;
}

- (void)leftBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction{
    if ([self.v_commodityView.v_commodityName.tf_detail.text isEqualToString:@""]) {
        [MBProgressHUD showErrorMessage:@"请填写商品名称"];
        return;
    }
    if ([self.v_commodityView.v_price.tf_detail.text isEqualToString:@""]) {
        [MBProgressHUD showErrorMessage:@"请填写价格"];
        return;
    }
    
    //先拿配置信息  上传商品信息  同时在上传图片

    [CommodityHandler addCustomizeCommodityWithShopId:[LoginStorage GetShopId] name:self.v_commodityView.v_commodityName.tf_detail.text barcode:self.barcode description:self.v_commodityView.v_commodityDescribe.tf_detail.text shopWareCategoryId:self.shopCId  xprice:self.v_commodityView.v_jinhuoPrice.tf_detail.text stock:[NSNumber numberWithInt:[self.v_commodityView.v_stock.tf_detail.text intValue]] pictures:[NSString stringWithFormat:@"%@-%@",[LoginStorage GetShopId],self.barcode] prepare:^{
        
    } success:^(id obj) {
        CommodityFromCodeEntity *entity = [[CommodityFromCodeEntity alloc]init];
        entity.name = self.v_commodityView.v_commodityName.tf_detail.text;
        [self.navigationController popViewControllerAnimated:YES];
        if (self.addCustomCommodityComplete) {
            self.addCustomCommodityComplete(entity);
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    
    
    NSString *endpoint = @"http://oss-cn-zhangjiakou.aliyuncs.com";
    // 移动端建议使用STS方式初始化OSSClient。可以通过sample中STS使用说明了解更多(https://github.com/aliyun/aliyun-oss-ios-sdk/tree/master/DemoByOC)
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:[LoginStorage GetAccessKeyId] secretKeyId:[LoginStorage GetAccessKeySecret] securityToken:[LoginStorage GetSecurityToken]];
    _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    [self updateToALi:self.imgData];
    
}

- (void)updateToALi:(NSData *)data
{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    put.bucketName =@"gouku-ware";
    put.objectKey = [NSString stringWithFormat:@"%@-%@",[LoginStorage GetShopId],self.barcode];
    put.contentType = @"image/png";
    put.uploadingData = data; // 直接上传NSData
    
    put.uploadProgress = ^(int64_t bytesSent,int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    
    OSSTask * putTask = [_client putObject:put];
    
    // 上传阿里云
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
            
        } else {
            
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
