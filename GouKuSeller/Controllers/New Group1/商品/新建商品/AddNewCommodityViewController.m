//
//  AddNewCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddNewCommodityViewController.h"
#import "NewCommodityView.h"
#import "SelectCommodityCategoryViewController.h"
#import "CommodityStandardViewController.h"
#import "ShopClassificationViewController.h"
#import "CommodityHandler.h"
#import "CommodityFromCodeEntity.h"
#import "LoginStorage.h"

@interface AddNewCommodityViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,TextViewClickReturnDelegate,TextFieldClickReturnDelegate>{
    UIImagePickerController *ipc;
}

@property (nonatomic ,strong)NewCommodityView   *v_commodityView;
@property (nonatomic ,assign)int    int_categoryId;
@property (nonatomic ,strong)CommodityFromCodeEntity *entity;
@property (nonatomic ,strong)NSNumber      *shopCId;
@property (nonatomic ,assign)int            shopStock;
@property (nonatomic ,assign)double         Cprice;   //商品价格
@property (nonatomic ,assign)double         Xprice;   // 进货价

@end

@implementation AddNewCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.comeFrom;
    
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
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
//    [self.v_commodityView.btn_addCatagory addTarget:self action:@selector(btn_addCatagoryAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClassification)];
    [self.v_commodityView.v_shopClassification addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer* imgTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTitleAction)];
    [self.v_commodityView.img_commodityImgTitle addGestureRecognizer:imgTitle];
    self.v_commodityView.img_commodityImgTitle.userInteractionEnabled = YES;
    self.v_commodityView.v_price.tf_detail.delegate = self;
    self.v_commodityView.v_stock.tf_detail.delegate = self;
    self.v_commodityView.v_jinhuoPrice.tf_detail.delegate = self;
    
//    UITapGestureRecognizer* tgr_commoditySpecifications = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgr_commoditySpecificationsAction)];
//    [self.v_commodityView.v_commoditySpecifications addGestureRecognizer:tgr_commoditySpecifications];
//    if (self.entityInformation.name.length > 0) {
//        [self.v_commodityView.lab_catagoryTitle setText:self.entityInformation.categoryName];
//        [self.v_commodityView.v_commodityName.tf_detail setText:self.entityInformation.name];
//        [self.v_commodityView.img_commodityImgTitle sd_setImageWithURL:[NSURL URLWithString:self.entityInformation.pictures] placeholderImage:[UIImage imageNamed:@"headPic"]];
//        [self.v_commodityView.v_commodityDescribe.tf_detail setText:self.entityInformation.detail];
//        [self.v_commodityView.v_commoditySpecifications.tf_detail setText:self.entityInformation.standards];
//        [self.v_commodityView.v_barcode.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.barcode]];
//        [self.v_commodityView.v_commodityCode.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.itemId]];
//
//    }else{
//
//        //查询商品信息
//        [self loadData];
//    }
    [self.v_commodityView.lab_catagoryTitle setText:self.entityInformation.categoryName];
    [self.v_commodityView.v_commodityName.tf_detail setText:self.entityInformation.name];
    [self.v_commodityView.img_commodityImgTitle sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,self.entityInformation.pictures]] placeholderImage:[UIImage imageNamed:@"headPic"]];
    if (self.entityInformation.detail.length > 0) {
        [self.v_commodityView.v_commodityDescribe.tf_detail setText:self.entityInformation.detail];
    }else{
      [self.v_commodityView.v_commodityDescribe.tf_detail setText:@"-"];
    }
    [self.v_commodityView.v_commoditySpecifications.tf_detail setText:self.entityInformation.standards];
    [self.v_commodityView.v_barcode.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.barcode]];
    [self.v_commodityView.v_price.tf_detail setText:[NSString stringWithFormat:@"%.2f",[self.entityInformation.price doubleValue]]];
    if ([self.comeFrom isEqualToString:@"编辑商品"]) {
        self.shopCId = self.entityInformation.shopWareCategoryId;
        [self.v_commodityView.v_shopClassification.tf_detail setText:self.entityInformation.shopWareCategoryName];
        [self.v_commodityView.v_stock.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.stock]];
        [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"%.2f",[self.entityInformation.xprice doubleValue]]];
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

//商品规格点击方法
- (void)tgr_commoditySpecificationsAction{
    CommodityStandardViewController *vc = [[CommodityStandardViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//头像按钮点击方法
-(void)imgTitleAction{
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
    UIImage *image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.v_commodityView.img_commodityImgTitle setImage:image];
}

-(void)btn_addCatagoryAction{
    SelectCommodityCategoryViewController * vc = [[SelectCommodityCategoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackCategory = ^(CommodityCatagoryEntity *commodityCatagoryEntity) {
        
    };
}
#pragma UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.v_commodityView.v_price.tf_detail) {
        if (![textField.text isEqualToString:@""]) {
            self.Cprice = [textField.text doubleValue];
            [self.v_commodityView.v_price.tf_detail setText:[NSString stringWithFormat:@"¥%.2f",[textField.text floatValue]]];
            [self.v_commodityView.v_price.tf_detail setTextColor:[UIColor blackColor]];
            
            
        }
    }if (textField == self.v_commodityView.v_stock.tf_detail) {
        self.shopStock = [textField.text intValue];
        [self.v_commodityView.v_stock.tf_detail setTextColor:[UIColor blackColor]];
        
    }
    if (textField == self.v_commodityView.v_jinhuoPrice.tf_detail) {
        if (![textField.text isEqualToString:@""]) {
            self.Xprice = [textField.text doubleValue];
            [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"¥%.2f",[textField.text floatValue]]];
            [self.v_commodityView.v_jinhuoPrice.tf_detail setTextColor:[UIColor blackColor]];
            
            
        }
    }
}

- (void)leftBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction{
//    self.entityInformation.name = @"窦建斌";
//    if (self.changeEntity) {
//        self.changeEntity();
//    }
//    [self.navigationController popViewControllerAnimated:YES];
    if ([self.comeFrom isEqualToString:@"编辑商品"]) {
        //从编辑按钮进来   走更新接口
        if ([self.v_commodityView.v_shopClassification.tf_detail.text isEqualToString:@"未分类"]) {
            [MBProgressHUD showInfoMessage:@"请选择店内分类"];
            return;
        }
        if ([self.v_commodityView.v_price.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写价格"];
            return;

        }
        if ([self.v_commodityView.v_jinhuoPrice.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写进货价格"];
            return;
            
        }
        if ([self.v_commodityView.v_stock.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写库存"];
            return;
        }
        if (![self.v_commodityView.v_shopClassification.tf_detail.text isEqualToString:@"未分类"]  && ![self.v_commodityView.v_price.tf_detail.text isEqualToString:@""] && ![self.v_commodityView.v_stock.tf_detail.text isEqualToString:@""]) {
        }
        [CommodityHandler commodityEditWithCommodityId:[NSNumber numberWithInt:(int)self.entityInformation.skuId] price:[self.v_commodityView.v_price.tf_detail.text doubleValue] stock:self.v_commodityView.v_stock.tf_detail.text xprice:[self.v_commodityView.v_jinhuoPrice.tf_detail.text doubleValue] shopWareCategoryId:self.shopCId prepare:^{

        } success:^(id obj) {
            CommodityFromCodeEntity *entity = (CommodityFromCodeEntity *)obj;
            self.entityInformation = entity;
            if (self.changeEntity) {
                self.changeEntity();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }else{
        //从新建商品进来    走新建商品接口
        if ([self.v_commodityView.v_shopClassification.tf_detail.text isEqualToString:@"未分类"]) {
            [MBProgressHUD showInfoMessage:@"请选择店内分类"];
            return;
        }
        if ([self.v_commodityView.v_price.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写价格"];
            return;
            
        }
        if ([self.v_commodityView.v_jinhuoPrice.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写进货价格"];
            return;
            
        }
        if ([self.v_commodityView.v_stock.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写库存"];
            return;
        }
        if (![self.v_commodityView.v_shopClassification.tf_detail.text isEqualToString:@"未分类"]  && ![self.v_commodityView.v_price.tf_detail.text isEqualToString:@""] && ![self.v_commodityView.v_stock.tf_detail.text isEqualToString:@""]) {
        }
        //网络请求
        [CommodityHandler addCommodityWithShopId:[LoginStorage GetShopId] name:self.entityInformation.name itemId:self.entityInformation.itemId barcode:self.entityInformation.barcode shopWareCategoryId:self.shopCId wareCategoryId:self.entityInformation.categoryId price:self.Cprice stock:[NSNumber numberWithInt:self.shopStock] pictures:self.entityInformation.pictures standards:self.entityInformation.standards wid:self.entityInformation.wid xprice:self.Xprice prepare:^{
            
        } success:^(id obj) {
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSInteger statusCode,
                   id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
