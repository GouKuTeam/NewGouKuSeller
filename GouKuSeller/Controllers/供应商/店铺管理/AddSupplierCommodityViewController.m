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
    
    //    UITapGestureRecognizer* imgTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTitleAction)];
    //    [self.v_commodityView.img_commodityImgTitle addGestureRecognizer:imgTitle];
    //    self.v_commodityView.img_commodityImgTitle.userInteractionEnabled = YES;
    self.v_commodityView.v_price.tf_detail.delegate = self;
    self.v_commodityView.v_stock.tf_detail.delegate = self;
    self.v_commodityView.v_jinhuoPrice.tf_detail.delegate = self;
    
    //供应商身份点击价格
    
    UITapGestureRecognizer* tgr_editPrice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgr_editPriceAction)];
    self.v_commodityView.v_price.tf_detail.userInteractionEnabled = YES;
    [self.v_commodityView.v_price.tf_detail addGestureRecognizer:tgr_editPrice];
    
    
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
    if ([self.comeFrom isEqualToString:@"编辑商品"]) {
        self.shopCId = self.entityInformation.shopWareCategoryId;
        [self.v_commodityView.v_shopClassification.tf_detail setText:self.entityInformation.shopWareCategoryName];
        [self.v_commodityView.v_stock.tf_detail setText:[NSString stringWithFormat:@"%@",self.entityInformation.stock]];
        [self.v_commodityView.v_jinhuoPrice.tf_detail setText:[NSString stringWithFormat:@"%.2f",[self.entityInformation.xprice doubleValue]]];
        //供应商商品价格显示价格规格    待完成
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
    vc.goBackAddSupplierCommodity = ^(NSDictionary *dic) {
        NSArray *arr = [dic objectForKey:@"saleUnits"];
        NSString *str_price = @"";
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dic = [arr objectAtIndex:i];
            if (i == 0) {
                str_price = [NSString stringWithFormat:@"%@¥%@",[dic objectForKey:@"unitName"],[dic objectForKey:@"price"]];
                
            }else{
                str_price = [str_price stringByAppendingString:[NSString stringWithFormat:@"; %@¥%@",[dic objectForKey:@"unitName"],[dic objectForKey:@"price"]]];
            }
        }
        NSString *aaa = [dic objectForKey:@"price"];
        if (aaa.length > 0) {
            NSString *morenPrice = [NSString stringWithFormat:@"件¥%@",[dic objectForKey:@"price"]];
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
        }else{
            [CommodityHandler commodityEditWithCommodityId:[NSString stringWithFormat:@"%@",self.entityInformation.skuId] price:self.Cprice stock:self.v_commodityView.v_stock.tf_detail.text xprice:self.Xprice shopWareCategoryId:self.shopCId prepare:^{
                
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
