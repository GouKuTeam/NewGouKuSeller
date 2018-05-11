//
//  ShopManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopManagerViewController.h"
#import "MyTbHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ShopManagerView.h"
#import "MyHandler.h"
#import "SupplierCommodityViewController.h"
#import "DispatchingViewController.h"
#import "SettlementViewController.h"
#import "SupplierSettingViewController.h"
#import "InventoryViewController.h"

@interface ShopManagerViewController ()

@property (nonatomic ,strong)MyTbHeaderView      *tb_header;
@property (nonatomic ,strong)ShopManagerView     *v_shopManager;


@end

@implementation ShopManagerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    // Do any additional setup after loading the view.
}

- (void)onCreate{

    
    self.tb_header = [[MyTbHeaderView alloc]init];
    [self.view addSubview:self.tb_header];
    
    [self.tb_header.lab_name setText:[LoginStorage GetShopName]];
    [self.tb_header.imgHead sd_setImageWithURL:[NSURL URLWithString:[LoginStorage GetShopPic]]];
    
    UIButton *btn_set = [[UIButton alloc]init];
    [btn_set addTarget:self action:@selector(btnsetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tb_header addSubview:btn_set];
    [btn_set setImage:[UIImage imageNamed:@"setting_white"] forState:UIControlStateNormal];
    if (SafeAreaTopHeight == 88) {
        [self.tb_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130 + 44)];
        [btn_set setFrame:CGRectMake(SCREEN_WIDTH - 18 - 15, 12 + 44, 18, 18)];
    }else{
        [self.tb_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130 + 20)];
        [btn_set setFrame:CGRectMake(SCREEN_WIDTH - 18 - 15, 12 + 20, 18, 18)];
    }
    
    self.v_shopManager = [[ShopManagerView alloc]initWithFrame:CGRectMake(0, self.tb_header.bottom + 10, SCREEN_WIDTH, 380)];
    [self.view addSubview:self.v_shopManager];
    [self.v_shopManager.btn_commodity addTarget:self action:@selector(btn_commodityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_shopManager.btn_peisong addTarget:self action:@selector(btn_peisongAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_shopManager.btn_jiesuan addTarget:self action:@selector(btn_jiesuanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_shopManager.btn_pandian addTarget:self action:@selector(btn_pandianAction) forControlEvents:UIControlEventTouchUpInside];
    [self loadData];
    
}

- (void)loadData{
    [MyHandler getTodayMsgprepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSDictionary *)obj;
        NSLog(@"dic == %@",dic);
        [self.v_shopManager.lab_turnoverDetail setText:[NSString stringWithFormat:@"¥%.2f",[[dic objectForKey:@"sales"] floatValue]]];
        [self.v_shopManager.lab_orderDetail setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"orders"]]];
        [self.v_shopManager.lab_unitPriceDetail setText:[NSString stringWithFormat:@"¥%.2f",[[dic objectForKey:@"perTicketSales"] floatValue]]];
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)btn_commodityAction{
    [self.navigationController.navigationBar setHidden:NO];
    SupplierCommodityViewController *vc = [[SupplierCommodityViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn_peisongAction{
    [self.navigationController.navigationBar setHidden:NO];
    DispatchingViewController *vc = [[DispatchingViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn_jiesuanAction{
    [self.navigationController.navigationBar setHidden:NO];
    SettlementViewController *vc = [[SettlementViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnsetAction{
    [self.navigationController.navigationBar setHidden:NO];
    SupplierSettingViewController *vc = [[SupplierSettingViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn_pandianAction{
    InventoryViewController *vc = [[InventoryViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
