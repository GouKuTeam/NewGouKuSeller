//
//  WorkbenchViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "WorkbenchViewController.h"
#import "SalesViewController.h"
#import "WorkBenchView.h"
#import "CommodityViewController.h"
#import "SettlementViewController.h"
#import "CashierViewController.h"
#import "MyHandler.h"
#import <AVFoundation/AVFoundation.h>
#import "PurchaseTabBarViewController.h"
#import "EditAddressViewController.h"
#import "InventoryViewController.h"
#import "SupplierOrderHandler.h"
#import "ShopOutOrderCountEntity.h"
#import "TabBarViewController.h"
#import "JWBluetoothManage.h"

@interface WorkbenchViewController (){
    JWBluetoothManage * manage;
}

@property (nonatomic ,strong)WorkBenchView        *v_workBench;
@property (nonatomic ,strong)UIScrollView         *v_scrollView;
@end

@implementation WorkbenchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    [self.view addSubview:statusView];
    [statusView setBackgroundColor:[UIColor colorWithHexString:COLOR_Main]];
    manage = [JWBluetoothManage sharedInstance];
}

- (void)onCreate{
    self.v_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20)];
    [self.view addSubview:self.v_scrollView];
    [self.v_scrollView setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    
    self.v_workBench = [[WorkBenchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.v_scrollView addSubview:self.v_workBench];
    [self.v_workBench.btn_active addTarget:self action:@selector(actiona) forControlEvents:UIControlEventTouchUpInside];
    [self.v_workBench.btn_commodity addTarget: self action:@selector(commodityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_workBench.btn_jiesuan addTarget:self action:@selector(jiesuanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_workBench.btn_shouyin addTarget:self action:@selector(shouyinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_workBench.btn_caigou addTarget:self action:@selector(caigouAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_workBench.btn_pandian addTarget:self action:@selector(pandianuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_workBench.btn_jingying addTarget:self action:@selector(jingyingAction) forControlEvents:UIControlEventTouchUpInside];
    if (SCREEN_HEIGHT <= 667) {
        self.v_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.v_workBench.bottom + 50);
    }
    [self loadData];
}

- (void)loadData{
    [MyHandler getTodayMsgprepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSDictionary *)obj;
        NSLog(@"dic == %@",dic);
        [self.v_workBench.lab_turnoverDetail setText:[NSString stringWithFormat:@"¥%.2f",[[dic objectForKey:@"sales"] floatValue]]];
        [self.v_workBench.lab_orderDetail setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"orders"]]];
        [self.v_workBench.lab_unitPriceDetail setText:[NSString stringWithFormat:@"¥%.2f",[[dic objectForKey:@"perTicketSales"] floatValue]]];
        [self.v_workBench.lab_xianjinDetail setText:[NSString stringWithFormat:@"¥%.2f",[[dic objectForKey:@"cashSales"] floatValue]]];
        [self.v_workBench.lab_goukuDetail setText:[NSString stringWithFormat:@"¥%.2f",[[dic objectForKey:@"goukuSales"] floatValue]]];
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)commodityAction{
    [MobClick event:@"shangpin"];
    CommodityViewController *vc = [[CommodityViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)actiona{
    [MobClick event:@"huodong"];
    SalesViewController *vc = [[SalesViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jiesuanAction{
    [MobClick event:@"jiesuan"];
    SettlementViewController *vc = [[SettlementViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shouyinAction{
    [MobClick event:@"shouyin"];
    CashierViewController *vc = [[CashierViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)caigouAction{
    [MobClick event:@"caigou"];
    PurchaseTabBarViewController *vc = [[PurchaseTabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)pandianuAction{
    [MobClick event:@"pandian"];
    InventoryViewController *vc = [[InventoryViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jingyingAction{
    EditAddressViewController *vc = [[EditAddressViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [MobClick beginLogPageView:@"gongzuotai"];
    [SupplierOrderHandler selectOutOrderCountPrepare:^{
        
    } success:^(id obj) {
        ShopOutOrderCountEntity *entity = (ShopOutOrderCountEntity *)obj;
        if (entity.allOrderCount > 0) {
            [(TabBarViewController *)self.tabBarController showBadgeOnItemIndex:1 withCount:entity.allOrderCount];
        }
        if (entity.allOrderCount == 0) {
            [(TabBarViewController *)self.tabBarController hideBadgeOnItemIndex:1];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
//            [ProgressShow alertView:self.view Message:@"连接成功" cb:nil];
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [MobClick endLogPageView:@"gongzuotai"];
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
