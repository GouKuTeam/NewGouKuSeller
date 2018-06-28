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
#import "EditPriceViewController.h"
#import "AddCustomCommodityView.h"

@interface AddNewCommodityViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,TextViewClickReturnDelegate,TextFieldClickReturnDelegate>{
    UIImagePickerController *ipc;
}

@property (nonatomic ,strong)AddCustomCommodityView   *v_commodityView;
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
    
    self.v_commodityView = [[AddCustomCommodityView alloc]init];
    [self.view addSubview:self.v_commodityView];
    [self.v_commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(SafeAreaTopHeight + 10);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];

    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClassification)];
    [self.v_commodityView.v_shopClassification addGestureRecognizer:singleTap];

//    self.v_commodityView.img_commodityImgTitle.userInteractionEnabled = YES;
//    UITapGestureRecognizer* imgTitleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTitleAction)];
//    [self.v_commodityView.img_commodityImgTitle addGestureRecognizer:imgTitleTap];

    self.v_commodityView.v_stock.tf_detail.delegate = self;
    self.v_commodityView.v_jinhuoPrice.tf_detail.delegate = self;
    
    
    [self.v_commodityView.v_commodityName.tf_detail setText:self.entityInformation.name];
    [self.v_commodityView.img_commodityImgTitle sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,self.entityInformation.pictures]] placeholderImage:[UIImage imageNamed:@"headPic"]];
    if (self.entityInformation.detail.length > 0) {
        [self.v_commodityView.v_commodityDescribe.tf_detail setText:self.entityInformation.detail];
    }else{
      [self.v_commodityView.v_commodityDescribe.tf_detail setText:@"-"];
    }

    [self.v_commodityView.v_barcode.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.barcode]];
    [self.v_commodityView.v_price.tf_detail setText:[NSString stringWithFormat:@"%.2f",[self.entityInformation.price doubleValue]]];
    self.Cprice = [self.entityInformation.price doubleValue];
    self.Xprice = [self.entityInformation.xprice doubleValue];
    self.shopStock = [self.entityInformation.stock intValue];
    if ([self.comeFrom isEqualToString:@"编辑商品"]) {
        self.shopCId = self.entityInformation.firstCategoryId;
        [self.v_commodityView.v_shopClassification.tf_detail setText:self.entityInformation.firstCategoryName];
        [self.v_commodityView.v_stock.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.stock]];
        [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"¥%.2f",[self.entityInformation.xprice doubleValue]]];
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

//商品编辑价格点击方法
- (void)tgr_editPriceAction{
    EditPriceViewController *vc = [[EditPriceViewController alloc]init];
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
        }else{
            [self.v_commodityView.v_price.tf_detail setText:[NSString stringWithFormat:@"¥%.2f",self.Cprice]];
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
        }else{
            [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"¥%.2f",self.Xprice]];
            [self.v_commodityView.v_jinhuoPrice.tf_detail setTextColor:[UIColor blackColor]];
        }
    }
}

- (void)leftBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction{
    [self.v_commodityView.v_price.tf_detail resignFirstResponder];
    [self.v_commodityView.v_stock.tf_detail resignFirstResponder];
    [self.v_commodityView.v_jinhuoPrice.tf_detail resignFirstResponder];
    if ([self.comeFrom isEqualToString:@"编辑商品"]) {
        //从编辑按钮进来   走更新接口
        if ([self.v_commodityView.v_shopClassification.tf_detail.text isEqualToString:@"请选择"]) {
            [MBProgressHUD showInfoMessage:@"请选择店内分类"];
            return;
        }else if ([self.v_commodityView.v_commodityName.tf_detail.text isEqualToString:@""]){
            [MBProgressHUD showInfoMessage:@"请填写商品名称"];
        }else{
            [CommodityHandler commodityEditWithSkuId:self.entityInformation.skuId name:self.v_commodityView.v_commodityName.tf_detail.text wareBarcode:self.entityInformation.barcode pictures:self.entityInformation.pictures stock:self.v_commodityView.v_stock.tf_detail.text description:self.v_commodityView.v_commodityDescribe.tf_detail.text xprice:[NSString stringWithFormat:@"%.2f",self.Xprice] firstCategoryId:self.shopCId prepare:^{
                
            } success:^(id obj) {
                CommodityFromCodeEntity *entity = (CommodityFromCodeEntity *)obj;
                [self.navigationController popViewControllerAnimated:YES];
                if (self.changeEntity) {
                    self.changeEntity(entity);
                }
            } failed:^(NSInteger statusCode, id json) {
                [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
            }];
        }
    }else{
        //从新建商品进来    走新建商品接口
        if ([self.v_commodityView.v_shopClassification.tf_detail.text isEqualToString:@"请选择"]) {
            [MBProgressHUD showInfoMessage:@"请选择店内分类"];
            return;
        }else{
            //网络请求
            [CommodityHandler addCommodityWithShopId:[LoginStorage GetShopId] name:self.entityInformation.name itemId:self.entityInformation.itemId barcode:self.entityInformation.barcode shopWareCategoryId:self.shopCId wareCategoryId:self.entityInformation.categoryId price:self.Cprice stock:[NSNumber numberWithInt:self.shopStock] pictures:self.entityInformation.pictures standards:self.entityInformation.standards wid:self.entityInformation.wid xprice:self.Xprice prepare:^{
                
            } success:^(id obj) {
                 [MBProgressHUD showSuccessMessage:@"新增商品成功"];
                 [self performSelector:@selector(addCommodityFinishAction) withObject:nil afterDelay:1];
            } failed:^(NSInteger statusCode,
                       id json) {
                [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
            }];
        }
    }
}

- (void)addCommodityFinishAction{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addshangpin" object:nil userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.addCommodityFinish) {
        self.addCommodityFinish();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
