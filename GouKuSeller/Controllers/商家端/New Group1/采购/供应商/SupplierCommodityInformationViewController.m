//
//  SupplierCommodityInformationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierCommodityInformationViewController.h"
#import "PurchaseHandler.h"
#import "StoreEntity.h"
#import "SelectUnitView.h"
#import "SupplierShopViewController.h"
#import "SupplierInformationViewController.h"

@interface SupplierCommodityInformationViewController ()

@property (nonatomic ,strong)UIScrollView   *scrollView;
@property (nonatomic ,strong)UIImageView    *img_pic;
@property (nonatomic ,strong)UIImageView    *img_supplierPic;
@property (nonatomic ,strong)UILabel        *lab_commodityName;
@property (nonatomic ,strong)UILabel        *lab_price;
@property (nonatomic ,strong)UILabel        *lab_stock;
@property (nonatomic ,strong)UILabel        *lab_supplierName;
@property (nonatomic ,strong)UILabel        *lab_shopNum;
@property (nonatomic ,strong)UILabel        *lab_orderNum;
@property (nonatomic ,strong)UILabel        *lab_startingPrice;
@property (nonatomic ,strong)UILabel        *lab_commodityStatus;
@property (nonatomic ,strong)UIButton       *btn_enter;
@property (nonatomic ,strong)UIButton       *btn_supplier;
@property (nonatomic ,strong)UIButton       *btn_shoppingCart;
@property (nonatomic ,strong)UIButton       *btn_addShoppingCart;
@property (nonatomic ,strong)UIView         *v1;
@property (nonatomic ,strong)UIView         *v2;
@property (nonatomic ,strong)UIView         *v_bottom;
@property (nonatomic,strong)SelectUnitView  *selectUnitView;


@property (nonatomic ,strong)StoreEntity    *storeEntity;

@end

@implementation SupplierCommodityInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
}

- (void)onCreate{
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    
    self.img_pic = [[UIImageView alloc]init];
    [self.scrollView addSubview:self.img_pic];
    [self.img_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.height.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.img_pic sd_setImageWithURL:[NSURL URLWithString:self.supplierCommodityEndity.pictures] placeholderImage:[UIImage imageNamed:@"headPic"]];
    
    self.v1 = [[UIView alloc]init];
    [self.scrollView addSubview:self.v1];
    [self.v1 setBackgroundColor:[UIColor whiteColor]];
    
    self.lab_commodityName = [[UILabel alloc]init];
    [self.v1 addSubview:self.lab_commodityName];
    [self.lab_commodityName setTextColor:[UIColor blackColor]];
    [self.lab_commodityName setFont:[UIFont boldSystemFontOfSize:16]];
    self.lab_commodityName.numberOfLines = 0;
    [self.lab_commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(8.3);
        make.right.mas_equalTo(SCREEN_WIDTH - 20);
    }];
    self.lab_commodityName.numberOfLines = 0;
    [self.lab_commodityName setText:self.supplierCommodityEndity.name];
    
    self.lab_price = [[UILabel alloc]init];
    [self.v1 addSubview:self.lab_price];
    [self.lab_price setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [self.lab_price setFont:[UIFont boldSystemFontOfSize:24]];
    [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_commodityName);
        make.top.equalTo(self.lab_commodityName.mas_bottom).offset(10);
        make.height.mas_equalTo(27);
    }];
    [self.lab_price setText:[NSString stringWithFormat:@"￥%.2f",self.supplierCommodityEndity.price]];
    
    self.lab_stock = [[UILabel alloc]init];
    [self.v1 addSubview:self.lab_stock];
    [self.lab_stock setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [self.lab_stock setFont:[UIFont systemFontOfSize:12]];
    [self.lab_stock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lab_commodityName);
        make.top.equalTo(self.lab_price.mas_bottom).offset(6);
        make.height.mas_equalTo(17);
    }];
    [self.lab_stock setText:[NSString stringWithFormat:@"库存%@%@",self.supplierCommodityEndity.stock,self.supplierCommodityEndity.unit]];
    
    [self.v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.img_pic.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.lab_stock.mas_bottom).offset(9);
    }];
    
    self.v2 = [[UIView alloc]init];
    [self.scrollView addSubview:self.v2];
    [self.v2 setBackgroundColor:[UIColor whiteColor]];
    [self.v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.v1.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(100);
    }];
    
    self.img_supplierPic = [[UIImageView alloc]init];
    [self.v2 addSubview:self.img_supplierPic];
    self.img_supplierPic.layer.cornerRadius = 12;
    self.img_supplierPic.layer.masksToBounds = YES;
    [self.img_supplierPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(13.7);
        make.width.height.mas_equalTo(24);
    }];
    
    
    self.lab_supplierName = [[UILabel alloc]init];
    [self.v2 addSubview:self.lab_supplierName];
    [self.lab_supplierName setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.lab_supplierName setFont:[UIFont systemFontOfSize:14]];
    [self.lab_supplierName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img_supplierPic.mas_right).offset(7);
        make.top.mas_equalTo(15.3);
        make.right.equalTo(self.v2.mas_right).offset(-84);
        make.height.mas_equalTo(20);
    }];
    
    
    self.btn_enter = [[UIButton alloc]init];
    [self.v2 addSubview:self.btn_enter];
    [self.btn_enter setTitle:@"进店逛逛" forState:UIControlStateNormal];
    self.btn_enter.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.btn_enter setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    self.btn_enter.layer.borderWidth = 0.5f;
    self.btn_enter.layer.borderColor = [[UIColor colorWithHexString:@"#C2C2C2"] CGColor];
    self.btn_enter.layer.cornerRadius = 2;
    self.btn_enter.layer.masksToBounds = YES;
    [self.btn_enter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 74);
        make.top.mas_equalTo(12.7);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(26);
    }];
    [self.btn_enter addTarget:self action:@selector(gotoShopAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.lab_shopNum = [[UILabel alloc]init];
    [self.v2 addSubview:self.lab_shopNum];
    [self.lab_shopNum setTextAlignment:NSTextAlignmentCenter];
    [self.lab_shopNum setTextColor:[UIColor blackColor]];
    [self.lab_shopNum setFont:[UIFont boldSystemFontOfSize:14]];
    [self.lab_shopNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(51);
        make.width.mas_equalTo(SCREEN_WIDTH / 3);
        make.height.mas_equalTo(17);
    }];
    
    
    UILabel *shopNum = [[UILabel alloc]init];
    [self.v2 addSubview:shopNum];
    [shopNum setTextAlignment:NSTextAlignmentCenter];
    [shopNum setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [shopNum setFont:[UIFont systemFontOfSize:14]];
    [shopNum setText:@"进货门店"];
    [shopNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.lab_shopNum.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH / 3);
        make.height.mas_equalTo(17);
    }];
    
    self.lab_orderNum = [[UILabel alloc]init];
    [self.v2 addSubview:self.lab_orderNum];
    [self.lab_orderNum setTextAlignment:NSTextAlignmentCenter];
    [self.lab_orderNum setTextColor:[UIColor blackColor]];
    [self.lab_orderNum setFont:[UIFont boldSystemFontOfSize:14]];
    [self.lab_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 3);
        make.top.mas_equalTo(51);
        make.width.mas_equalTo(SCREEN_WIDTH / 3);
        make.height.mas_equalTo(17);
    }];
    
    
    UILabel *orderNum = [[UILabel alloc]init];
    [self.v2 addSubview:orderNum];
    [orderNum setTextAlignment:NSTextAlignmentCenter];
    [orderNum setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [orderNum setFont:[UIFont systemFontOfSize:14]];
    [orderNum setText:@"交易订单"];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 3);
        make.top.equalTo(self.lab_orderNum.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH / 3);
        make.height.mas_equalTo(17);
    }];
    
    self.lab_startingPrice = [[UILabel alloc]init];
    [self.v2 addSubview:self.lab_startingPrice];
    [self.lab_startingPrice setTextAlignment:NSTextAlignmentCenter];
    [self.lab_startingPrice setTextColor:[UIColor blackColor]];
    [self.lab_startingPrice setFont:[UIFont boldSystemFontOfSize:14]];
    [self.lab_startingPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 3 * 2);
        make.top.mas_equalTo(51);
        make.width.mas_equalTo(SCREEN_WIDTH / 3);
        make.height.mas_equalTo(17);
    }];
    
    
    UILabel *startingPrice = [[UILabel alloc]init];
    [self.v2 addSubview:startingPrice];
    [startingPrice setTextAlignment:NSTextAlignmentCenter];
    [startingPrice setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    [startingPrice setFont:[UIFont systemFontOfSize:14]];
    [startingPrice setText:@"起送金额"];
    [startingPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 3 * 2);
        make.top.equalTo(self.lab_startingPrice.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH / 3);
        make.height.mas_equalTo(17);
    }];
    
    UIImageView * img_shu1 = [[UIImageView alloc]init];
    [self.v2 addSubview:img_shu1];
    [img_shu1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    [img_shu1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 3);
        make.top.mas_equalTo(57);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(28);
    }];
    
    UIImageView * img_shu2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 2, 239, 0.5, 28)];
    [self.v2 addSubview:img_shu2];
    [img_shu2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    [img_shu2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 3 * 2);
        make.top.mas_equalTo(57);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(28);
    }];
    
    self.lab_commodityStatus = [[UILabel alloc]init];
    [self.scrollView addSubview:self.lab_commodityStatus];
    [self.lab_commodityStatus setBackgroundColor:[UIColor colorWithHexString:@"#FAEDEA"]];
    [self.lab_commodityStatus setTextAlignment:NSTextAlignmentCenter];
    [self.lab_commodityStatus setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [self.lab_commodityStatus setFont:[UIFont systemFontOfSize:14]];
    [self.lab_commodityStatus setText:@"商品库存不足，无法购买"];
    [self.lab_commodityStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.v2.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(32);
    }];
    
    
    
    
    
    self.v_bottom = [[UIView alloc]init];
    [self.view addSubview:self.v_bottom];
    [self.v_bottom setBackgroundColor:[UIColor whiteColor]];
    [self.v_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(SCREEN_HEIGHT - SafeAreaBottomHeight - 46);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(46);
    }];
    
    self.btn_supplier = [[UIButton alloc]init];
    [self.v_bottom addSubview:self.btn_supplier];
    [self.btn_supplier mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(SCREEN_WIDTH / 4);
        make.height.mas_equalTo(41);
    }];
    [self.btn_supplier setTitle:@"供应商" forState:UIControlStateNormal];
    [self.btn_supplier setTitleColor:[UIColor colorWithHexString:@"#979797"] forState:UIControlStateNormal];
    self.btn_supplier.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.btn_supplier setImage:[UIImage imageNamed:@"gongyingshang"] forState:UIControlStateNormal];
    [self.btn_supplier setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_supplier.imageView.frame.size.height + 5 ,-self.btn_supplier.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self.btn_supplier setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_supplier.imageView.frame.size.height, 0.0,0.0, -self.btn_supplier.titleLabel.bounds.size.width)];//图片距离右边框
    [self.btn_supplier addTarget:self action:@selector(gotoShopInformationAction) forControlEvents:UIControlEventTouchUpInside];
    //
    self.btn_shoppingCart = [[UIButton alloc]init];
    [self.v_bottom addSubview:self.btn_shoppingCart];
    [self.btn_shoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(SCREEN_WIDTH / 4);
        make.width.mas_equalTo(SCREEN_WIDTH / 4);
        make.height.mas_equalTo(41);
    }];
    [self.btn_shoppingCart setTitle:@"购物车" forState:UIControlStateNormal];
    [self.btn_shoppingCart setTitleColor:[UIColor colorWithHexString:@"#979797"] forState:UIControlStateNormal];
    self.btn_shoppingCart.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.btn_shoppingCart setImage:[UIImage imageNamed:@"shoppingcartgrey"] forState:UIControlStateNormal];
    [self.btn_shoppingCart setTitleEdgeInsets:UIEdgeInsetsMake(self.btn_shoppingCart.imageView.frame.size.height + 5 ,-self.btn_shoppingCart.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self.btn_shoppingCart setImageEdgeInsets:UIEdgeInsetsMake(-self.btn_shoppingCart.imageView.frame.size.height, 0.0,0.0, -self.btn_shoppingCart.titleLabel.bounds.size.width)];//图片距离右边框
    [self.btn_shoppingCart addTarget:self action:@selector(gotoShopCartAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_addShoppingCart = [[UIButton alloc]init];
    [self.v_bottom addSubview:self.btn_addShoppingCart];
    [self.btn_addShoppingCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.btn_addShoppingCart setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    [self.btn_addShoppingCart setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.btn_addShoppingCart addTarget:self action:@selector(addShopCartAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_addShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 2);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH / 2);
        make.height.mas_equalTo(46);
    }];
    
    if ([self.supplierCommodityEndity.stock intValue] > 0) {
        [self.lab_commodityStatus setHidden:YES];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(SafeAreaTopHeight);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 46);
            make.bottom.equalTo(self.v2.mas_bottom).offset(12);
        }];
    }else{
        self.btn_addShoppingCart.enabled = NO;
        [self.btn_addShoppingCart setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
        [self.btn_addShoppingCart setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [self.lab_commodityStatus setHidden:NO];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(SafeAreaTopHeight);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 46);
            make.bottom.equalTo(self.lab_commodityStatus.mas_bottom);
        }];
    }
    
    [self loadData];
    
    self.selectUnitView = [[SelectUnitView alloc]init];
    [self.selectUnitView setHidden:YES];
    [self.selectUnitView.btn_confirm addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self.selectUnitView];
    [self.selectUnitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
}

- (void)addShopCartAction{
    [self.selectUnitView contentViewWithSupplierCommodityEndity:self.supplierCommodityEndity];
    [self.selectUnitView setHidden:NO];
}

- (void)confirmAction{
    if ([self.selectUnitView.tf_count.text intValue] > [self.supplierCommodityEndity.stock intValue]) {
        [MBProgressHUD showErrorMessage:@"库存不足"];
        self.selectUnitView.tf_count.text = self.supplierCommodityEndity.stock;
    }else{
        NSDictionary *dic = [self.selectUnitView.supplierCommodityEndity.saleUnits objectAtIndex:self.selectUnitView.selectIndex];
        [PurchaseHandler addCommodityToShoppingCarWithSkuId:self.selectUnitView.supplierCommodityEndity.skuId skuUnitId:[dic objectForKey:@"id"] count:[NSNumber numberWithInt:[self.selectUnitView.tf_count.text intValue]] prepare:^{
            [MBProgressHUD showActivityMessageInView:nil];
        } success:^(id obj) {
            [MBProgressHUD hideHUD];
            [self.selectUnitView setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
    
}


- (void)loadData{
    [PurchaseHandler selectSupplierDetailWithShopId:self.shopId prepare:^{
        
    } success:^(id obj) {
        self.storeEntity = (StoreEntity *)obj;
        [self.img_supplierPic sd_setImageWithURL:[NSURL URLWithString:self.storeEntity.logo] placeholderImage:[UIImage imageNamed:@"headPic"]];
        [self.lab_supplierName setText:self.storeEntity.name];
        [self.lab_shopNum setText:[NSString stringWithFormat:@"%ld家",self.storeEntity.shopNum]];
        [self.lab_orderNum setText:[NSString stringWithFormat:@"%ld笔",self.storeEntity.orderNum]];
        [self.lab_startingPrice setText:[NSString stringWithFormat:@"%.2f元",self.storeEntity.takeOffPrice]];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)gotoShopCartAction{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GoToShopCart" object:nil userInfo:nil];
}

- (void)gotoShopAction{
    SupplierShopViewController *vc = [[SupplierShopViewController alloc]init];
    vc.storeEntity = self.storeEntity;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoShopInformationAction{
    SupplierInformationViewController *vc = [[SupplierInformationViewController alloc]init];
    vc.storeEntity = self.storeEntity;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
