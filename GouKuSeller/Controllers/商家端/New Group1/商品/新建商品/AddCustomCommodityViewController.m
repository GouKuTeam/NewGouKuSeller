//
//  AddCustomCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/30.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddCustomCommodityViewController.h"
#import "NewCommodityView.h"
#import "ShopClassificationViewController.h"


@interface AddCustomCommodityViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>{
    UIImagePickerController *ipc;
}

@property (nonatomic ,strong)NewCommodityView   *v_commodityView;
@property (nonatomic ,strong)NSNumber      *shopCId;


@end

@implementation AddCustomCommodityViewController

//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = YES;
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建商品";
//    self.navigationController.navigationBar.translucent = NO;
    
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
    
    self.v_commodityView = [[NewCommodityView alloc]init];
    [self.view addSubview:self.v_commodityView];
    [self.v_commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(-88);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
    
    self.v_commodityView.v_price.tf_detail.delegate = self;
    self.v_commodityView.v_stock.tf_detail.delegate = self;
    self.v_commodityView.v_jinhuoPrice.tf_detail.delegate = self;
    
    self.v_commodityView.v_commodityName.tf_detail.NumberKeyboardType = 3;
    self.v_commodityView.v_commodityName.tf_detail.enabled = YES;
    self.v_commodityView.v_commodityDescribe.tf_detail.enabled = YES;
    self.v_commodityView.v_commodityName.tf_detail.placeholder = @"不超过30个字";
    self.v_commodityView.v_commodityDescribe.tf_detail.placeholder = @"不超过250个字";
    self.v_commodityView.v_price.tf_detail.placeholder = @"请填写";
    [self.v_commodityView.v_price.img_jiantou setHidden:YES];
    self.v_commodityView.v_barcode.tf_detail.text = self.barcode;
    self.v_commodityView.v_barcode.tf_detail.textColor = [UIColor colorWithHexString:@"#C3C3C3"];
    [self.v_commodityView.v_commodityName.tf_detail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.v_commodityView.v_commodityDescribe.tf_detail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClassification)];
    [self.v_commodityView.v_shopClassification addGestureRecognizer:singleTap];
    
    
    
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
