//
//  AddSupplierCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddSupplierCommodityViewController.h"
#import "NewCommodityView.h"
#import "SelectCommodityCategoryViewController.h"
#import "CommodityStandardViewController.h"
#import "ShopClassificationViewController.h"
#import "CommodityHandler.h"
#import "CommodityFromCodeEntity.h"
#import "LoginStorage.h"
#import "EditPriceViewController.h"

@interface AddSupplierCommodityViewController ()<UINavigationControllerDelegate,UITextFieldDelegate,TextViewClickReturnDelegate,TextFieldClickReturnDelegate>

@property (nonatomic ,strong)NewCommodityView   *v_commodityView;
@property (nonatomic ,assign)int    int_categoryId;
@property (nonatomic ,strong)CommodityFromCodeEntity *entity;
@property (nonatomic ,strong)NSNumber      *shopCId;
@property (nonatomic ,assign)int            shopStock;
@property (nonatomic ,assign)double         Cprice;   //商品价格
@property (nonatomic ,assign)double         Xprice;   // 进货价
@property (nonatomic ,strong)NSDictionary  *dic_price;

@property (nonatomic ,strong)SupplierCommodityEndity *scEntity;

@end

@implementation AddSupplierCommodityViewController

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
    
    self.v_commodityView = [[NewCommodityView alloc]init];
    [self.view addSubview:self.v_commodityView];
    [self.v_commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClassification)];
    [self.v_commodityView.v_shopClassification addGestureRecognizer:singleTap];
    

    self.v_commodityView.v_price.tf_detail.delegate = self;
    self.v_commodityView.v_stock.tf_detail.delegate = self;
    self.v_commodityView.v_jinhuoPrice.tf_detail.delegate = self;
    [self.v_commodityView.v_price.tf_detail setPlaceholder:@"设置价格"];
    
    [self.v_commodityView.btn_priceEdit setHidden:NO];
    [self.v_commodityView.btn_priceEdit addTarget:self action:@selector(tgr_editPriceAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.comeFrom isEqualToString:@"新建商品"]) {
        self.scEntity = [[SupplierCommodityEndity alloc]init];
        [self.v_commodityView.lab_catagoryTitle setText:self.entityInformation.categoryName];
        [self.v_commodityView.v_commodityName.tf_detail setText:self.entityInformation.name];
        [self.v_commodityView.img_commodityImgTitle sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,self.entityInformation.pictures]] placeholderImage:[UIImage imageNamed:@"headPic"]];
        if (self.entityInformation.detail.length > 0) {
            [self.v_commodityView.v_commodityDescribe.tf_detail setText:self.entityInformation.detail];
        }else{
            [self.v_commodityView.v_commodityDescribe.tf_detail setText:@"-"];
        }

        [self.v_commodityView.v_barcode.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.barcode]];
        self.Cprice = [self.entityInformation.price doubleValue];
        self.Xprice = [self.entityInformation.xprice doubleValue];
        self.shopStock = [self.entityInformation.stock intValue];
    }else{
        [self loadSupplierCommodityData];
    }
}

- (void)loadSupplierCommodityData{
    [CommodityHandler getSupplierCommodityInformationWithSkuId:self.skuId prepare:^{
        
    } success:^(id obj) {
        self.scEntity = (SupplierCommodityEndity *)obj;
        [self.v_commodityView.lab_catagoryTitle setText:self.scEntity.categoryName];
        [self.v_commodityView.v_commodityName.tf_detail setText:self.scEntity.name];
        [self.v_commodityView.img_commodityImgTitle sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,self.scEntity.pictures]] placeholderImage:[UIImage imageNamed:@"headPic"]];
        if (self.scEntity.detail.length > 0) {
            [self.v_commodityView.v_commodityDescribe.tf_detail setText:self.scEntity.detail];
        }else{
            [self.v_commodityView.v_commodityDescribe.tf_detail setText:@"-"];
        }
        [self.v_commodityView.v_shopClassification.tf_detail setText:self.scEntity.firstCategoryName];
        
        [self.v_commodityView.v_stock.tf_detail setText:self.scEntity.stock];
        [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"%.2f",self.scEntity.xprice]];
        [self.v_commodityView.v_barcode.tf_detail setText:[NSString stringWithFormat:@"%@",self.scEntity.barcode]];

        NSString *str_price = @"";
        for (int i = 0; i < self.scEntity.saleUnits.count; i++) {
            NSDictionary *dic = [self.scEntity.saleUnits objectAtIndex:i];
            if (i == 0) {
                str_price = [NSString stringWithFormat:@"%@¥%@",[dic objectForKey:@"unitName"],[dic objectForKey:@"price"]];
                
            }else{
                str_price = [str_price stringByAppendingString:[NSString stringWithFormat:@"; %@¥%@",[dic objectForKey:@"unitName"],[dic objectForKey:@"price"]]];
            }
        }
        if (self.scEntity.defaultUsing == YES) {
            NSString *morenPrice = [NSString stringWithFormat:@"件¥%.2f",self.scEntity.defaultPrice];
            str_price = [NSString stringWithFormat:@"%@；%@",morenPrice,str_price];
        }
        [self.v_commodityView.v_price.tf_detail setText:str_price];
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

//店内分类  手势点击方法
- (void)shopClassification{
    ShopClassificationViewController *vc = [[ShopClassificationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackShop = ^(ShopClassificationEntity *shopClassificationEntity) {
        [self.v_commodityView.v_shopClassification.tf_detail setText:shopClassificationEntity.name];
        [self.v_commodityView.v_shopClassification.tf_detail setTextColor:[UIColor blackColor]];
        self.shopCId = [NSNumber numberWithInt:(int)shopClassificationEntity._id];
        self.scEntity.firstCategoryId = [NSNumber numberWithInt:(int)shopClassificationEntity._id];
        
    };
}

//商品编辑价格点击方法
- (void)tgr_editPriceAction{
//    self.scEntity = [[SupplierCommodityEndity alloc]init];
    EditPriceViewController *vc = [[EditPriceViewController alloc]init];
    vc.defaultUnit = self.scEntity.defaultUsing;
    if ([self.comeFrom isEqualToString:@"新建商品"]) {
        vc.defaultPrice = [self.entityInformation.price doubleValue];
    }
    if ([self.comeFrom isEqualToString:@"编辑商品"]) {
        vc.defaultPrice = self.scEntity.defaultPrice;
    }
    vc.arr_data = [NSMutableArray arrayWithArray:self.scEntity.saleUnits];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackAddSupplierCommodity = ^(NSDictionary *dic) {
        self.scEntity.defaultUsing = [[dic objectForKey:@"using"] boolValue];
        self.scEntity.defaultPrice = [[dic objectForKey:@"price"] doubleValue];
        self.scEntity.saleUnits = [dic objectForKey:@"saleUnits"];
        self.dic_price = dic;
        NSString *str_price = @"";
        for (int i = 0; i < self.scEntity.saleUnits.count; i++) {
            NSDictionary *dic = [self.scEntity.saleUnits objectAtIndex:i];
            if (i == 0) {
                str_price = [NSString stringWithFormat:@"%@¥%.2f",[dic objectForKey:@"unitName"],[[dic objectForKey:@"price"] doubleValue]];
                
            }else{
                str_price = [str_price stringByAppendingString:[NSString stringWithFormat:@"; %@¥%.2f",[dic objectForKey:@"unitName"],[[dic objectForKey:@"price"] doubleValue]]];
            }
        }
        if (self.scEntity.defaultUsing == YES) {
            NSString *morenPrice = [NSString stringWithFormat:@"件¥%.2f",self.scEntity.defaultPrice];
            str_price = [NSString stringWithFormat:@"%@；%@",morenPrice,str_price];
        }
        [self.v_commodityView.v_price.tf_detail setText:str_price];
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
            [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"%.2f",[textField.text floatValue]]];
            [self.v_commodityView.v_jinhuoPrice.tf_detail setTextColor:[UIColor blackColor]];
        }else{
            [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"%.2f",self.Xprice]];
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
        }else{
            [CommodityHandler updateSupplierCommodityWithSkuId:self.scEntity.skuId wareItemId:self.scEntity.wareItemId firstCategoryId:self.scEntity.firstCategoryId stock:[self.v_commodityView.v_stock.tf_detail.text intValue] xprice:self.v_commodityView.v_jinhuoPrice.tf_detail.text musing:self.scEntity.defaultUsing price:[NSString stringWithFormat:@"%.2f",self.scEntity.defaultPrice] saleUnits:self.scEntity.saleUnits deleteUnitIds:[self.dic_price objectForKey:@"deleteUnitIds"] hitType:self.hitType prepare:^{
                
            } success:^(id obj) {
                SupplierCommodityEndity *entity = (SupplierCommodityEndity *)obj;
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
        }
        if ([self.v_commodityView.v_price.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写价格"];
            return;
        }
        if ([self.v_commodityView.v_stock.tf_detail.text isEqualToString:@""]) {
            [MBProgressHUD showInfoMessage:@"请填写库存"];
            return;
        }
        //网络请求
        [CommodityHandler addSupplierCommodityWithWareItemId:[NSNumber numberWithLong:self.entityInformation._id] firstCategoryId:self.shopCId stock:self.shopStock xprice:[NSString stringWithFormat:@"%.2f",self.Xprice] musing:[self.dic_price objectForKey:@"using"] price:[self.dic_price objectForKey:@"price"] saleUnits:[self.dic_price objectForKey:@"saleUnits"] prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                [MBProgressHUD showSuccessMessage:@"新增商品成功"];
                [self performSelector:@selector(addCommodityFinishAction) withObject:nil afterDelay:1];
            }else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            
        }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
