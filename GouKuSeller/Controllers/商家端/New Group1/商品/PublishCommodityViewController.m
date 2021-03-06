//
//  PublishCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PublishCommodityViewController.h"
#import "PublishCommodityView.h"
#import "ShopClassificationViewController.h"
#import "CommodityHandler.h"

@interface PublishCommodityViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic ,strong)PublishCommodityView   *v_commodityView;
@property (nonatomic ,strong)NSNumber      *shopCId;
@property (nonatomic ,assign)double         Cprice;   //商品价格
@property (nonatomic ,assign)double         Xprice;   // 进货价
@property (nonatomic ,assign)int            shopStock;
@property (nonatomic ,assign)int            commodityType;

@end

@implementation PublishCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    [btn_left setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btn_left;
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    if (self.publishCommodityFormType == PublishCommodityFormPublish) {
        self.title = @"发布商品";
    }else{
        self.title = @"编辑商品";
    }
    
    self.v_commodityView = [[PublishCommodityView alloc]init];
    [self.view addSubview:self.v_commodityView];
    [self.v_commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(SafeAreaTopHeight + 10);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClassification)];
    [self.v_commodityView.v_shopClassification addGestureRecognizer:singleTap];
    
    self.v_commodityView.v_stock.tf_detail.delegate = self;
    self.v_commodityView.v_jinhuoPrice.tf_detail.delegate = self;
    
    self.shopCId = self.entityInformation.firstCategoryId;
    self.Xprice = [self.entityInformation.xprice doubleValue];
    self.shopStock = [self.entityInformation.stock intValue];
    
    [self.v_commodityView.v_commodityName.tf_detail setText:self.entityInformation.name];
    [self.v_commodityView.img_commodityImgTitle sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,self.entityInformation.pictures]] placeholderImage:[UIImage imageNamed:@"headPic"]];
    if (self.entityInformation.detail.length > 0) {
        [self.v_commodityView.v_commodityDescribe.tf_detail setText:self.entityInformation.detail];
    }else{
        [self.v_commodityView.v_commodityDescribe.tf_detail setText:@"-"];
    }
    if (self.Xprice == 0) {
        [self.v_commodityView.v_jinhuoPrice.tf_detail setText:@""];
    }else{
        [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"¥%.2f",[self.entityInformation.xprice doubleValue]]];
    }
    [self.v_commodityView.v_shopClassification.tf_detail setText:self.entityInformation.firstCategoryName];
    [self.v_commodityView.v_stock.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.stock]];
    
    if (self.publishCommodityFormType == PublishCommodityFormPublish) {
        self.title = @"发布商品";
        [self.v_commodityView.v_price.tf_detail setText:@""];
    }else{
        self.title = @"编辑商品";
        [self.v_commodityView.v_price.tf_detail setText:[NSString stringWithFormat:@"%.2f",[self.entityInformation.price doubleValue]]];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
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
    return YES;
}

- (void)leftBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction{
    [self.v_commodityView.v_price.tf_detail resignFirstResponder];
    [self.v_commodityView.v_stock.tf_detail resignFirstResponder];
    [self.v_commodityView.v_jinhuoPrice.tf_detail resignFirstResponder];
    if ([self.v_commodityView.v_commodityName.tf_detail.text isEqualToString:@""]) {
        [MBProgressHUD showErrorMessage:@"请填写商品名称"];
        return;
    }
    if ([self.v_commodityView.v_price.tf_detail.text isEqualToString:@""]) {
        [MBProgressHUD showErrorMessage:@"请填写售价"];
        return;
    }
    if ([self.v_commodityView.v_price.tf_detail.text doubleValue] == 0) {
        [MBProgressHUD showErrorMessage:@"价格不能为0"];
        return;
    }
    if (self.publishCommodityFormType == PublishCommodityFormPublish) {
        [CommodityHandler commodityReleaseWithSkuId:self.entityInformation.skuId name:self.v_commodityView.v_commodityName.tf_detail.text firstCategoryId:self.shopCId description:self.v_commodityView.v_commodityDescribe.tf_detail.text stock:[NSNumber numberWithInt:self.shopStock] price:self.v_commodityView.v_price.tf_detail.text releaseType:self.publishCommodityToShopType prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            if ([[dic objectForKey:@"errCode"] intValue] == 0) {
                CommodityFromCodeEntity *entity = [CommodityFromCodeEntity parseCommodityFromCodeEntityWithJson:[dic objectForKey:@"data"]];
                [self.navigationController popViewControllerAnimated:YES];
                if (self.changeChildEntity) {
                    self.changeChildEntity(entity);
                }
            }else{
                [MBProgressHUD showErrorMessage:[dic objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
    if (self.publishCommodityFormType == PublishCommodityFormEdit) {
        [CommodityHandler wareSkuUpdateWithSkuId:self.entityInformation.skuId name:self.v_commodityView.v_commodityName.tf_detail.text firstCategoryId:self.shopCId description:self.v_commodityView.v_commodityDescribe.tf_detail.text stock:[NSNumber numberWithInt:self.shopStock] price:self.v_commodityView.v_price.tf_detail.text releaseType:self.publishCommodityToShopType prepare:^{
            
        } success:^(id obj) {
            CommodityFromCodeEntity *entity = (CommodityFromCodeEntity *)obj;
            [self.navigationController popViewControllerAnimated:YES];
            if (self.changeChildEntity) {
                self.changeChildEntity(entity);
            }
            
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
    
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
