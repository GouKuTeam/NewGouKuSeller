//
//  PurchaseOrderViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseOrderViewController.h"
#import "TabBarViewController.h"
#import "PurchaseOrderHeaderView.h"
#import "PurchaseOrderTableViewCell.h"
#import "ShoppingHandler.h"
#import "PurchaseOrderEntity.h"
#import "SearchPurchaseOrderViewController.h"
#import "CountDownManager.h"
#import "PurchaseOrderDetailViewController.h"
#import "PurchaseTabBarViewController.h"

@interface PurchaseOrderViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic,strong)BaseTableView    *tb_purchaseOrder;
@property (nonatomic,strong)NSMutableArray   *arr_data;
@property (nonatomic,assign)int               btnIndex;

@end

@implementation PurchaseOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHideLeftBtn = YES;
    // Do any additional setup after loading the view.
    self.title = @"采购订单";
    self.arr_data = [NSMutableArray array];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_white"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = btn_right;
    [kCountDownManager start];
    
}

- (void)onCreate{
    self.btnIndex = 999;
    self.navigationItem.leftBarButtonItem = nil;
    PurchaseOrderHeaderView *v_header = [[PurchaseOrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
    [self.view addSubview:v_header];
    v_header.selectItem = ^(int index) {
        if (index == 0) {
            self.btnIndex = 999;
            [self.tb_purchaseOrder requestDataSource];
        }
        if (index == 1) {
            self.btnIndex = 0;
            [self.tb_purchaseOrder requestDataSource];
        }
        if (index == 2) {
            self.btnIndex = 2;
            [self.tb_purchaseOrder requestDataSource];
        }
        if (index == 3) {
            self.btnIndex = 3;
            [self.tb_purchaseOrder requestDataSource];
        }
        if (index == 4) {
            self.btnIndex = 9;
            [self.tb_purchaseOrder requestDataSource];
        }
    };
    
    self.tb_purchaseOrder = [[BaseTableView alloc]initWithFrame:CGRectMake(0,v_header.bottom, SCREEN_WIDTH,self.view.height - v_header.bottom - SafeAreaBottomHeight - SafeAreaTopHeight - 49) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_purchaseOrder.delegate = self;
    self.tb_purchaseOrder.dataSource = self;
    self.tb_purchaseOrder.tableViewDelegate = self;
    self.tb_purchaseOrder.tableFooterView = [UIView new];
    self.tb_purchaseOrder.separatorColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_purchaseOrder.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_purchaseOrder];
    [self.tb_purchaseOrder requestDataSource];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [ShoppingHandler selectOrderListWithStatus:[NSNumber numberWithInt:self.btnIndex] keyWord:nil page:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_data removeAllObjects];
        }
        [self.arr_data addObjectsFromArray:(NSArray *)obj];
        [kCountDownManager reload];
        [self.tb_purchaseOrder reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_data.count == 0) {
            self.tb_purchaseOrder.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_purchaseOrder.frame withDefaultImage:nil withNoteTitle:@"暂无采购订单数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_Main] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;
    [ShoppingHandler getCountInShopCartprepare:^{
        
    } success:^(id obj) {
        if ([obj intValue] > 0) {
            [(PurchaseTabBarViewController *)self.tabBarController showBadgeOnItemIndex:1 withCount:[obj intValue]];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NocatifionPayCompleteAndRefreshDataAction) name:@"PayCompleteAndRefreshData" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:indexPath.section];
    if (entity.status == 0 || entity.status == 3) {
        return 173;
    }else{
        return 132;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 52;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
    [v_header setBackgroundColor:[UIColor whiteColor]];
    v_header.tag = section;
    v_header.userInteractionEnabled = YES;
    UITapGestureRecognizer *vHeaderTgp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vHeaderTgp:)];
    [v_header addGestureRecognizer:vHeaderTgp];
    
    UIView  *v_line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    [v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [v_header addSubview:v_line];
    
    UIImageView *iv_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 22, 22)];
    [iv_avatar.layer setCornerRadius:11];
    [iv_avatar.layer setMasksToBounds:YES];
    [iv_avatar setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    iv_avatar.contentMode = UIViewContentModeScaleAspectFill;
    [v_header addSubview:iv_avatar];
    
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(iv_avatar.right + 10, 10, SCREEN_WIDTH - iv_avatar.right - 80, 42)];
    [lb_title setFont:[UIFont systemFontOfSize:14]];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [v_header addSubview:lb_title];
    
    UILabel *lb_status = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 10, 60, 42)];
    [lb_status setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [lb_status setTextColor:[UIColor blackColor]];
    [lb_status setTextAlignment:NSTextAlignmentRight];
    [v_header addSubview:lb_status];
    
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    [iv_avatar sd_setImageWithURL:[NSURL URLWithString:entity.logo] placeholderImage:nil];
    [lb_title setText:entity.name];
    if (entity.status == 0) {//(0待付款1待接单2待发货3待收货8已完成9已取消)
        [lb_status setText:@"待付款"];
    }else if (entity.status == 1){
        [lb_status setText:@"待接单"];
    }else if (entity.status == 2){
        [lb_status setText:@"待发货"];
    }else if (entity.status == 3){
        [lb_status setText:@"待收货"];
    }else if (entity.status == 8){
        [lb_status setText:@"已完成"];
    }else if (entity.status == 9){
        [lb_status setText:@"已关闭"];
    }
    return v_header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PurchaseOrderCell";
    PurchaseOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PurchaseOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:indexPath.section];
    [cell contentCellWithPurchaseOrderEntity:entity];
    cell.countDownZero = ^(PurchaseOrderEntity *entity) {
        if (self.btnIndex == 999) {
            [self.tb_purchaseOrder reloadData];
        }else{
            [self.arr_data removeObject:entity];
        }
        [self.tb_purchaseOrder reloadData];
    };
    cell.btn_cancelOrder.tag = indexPath.section;
    cell.btn_payOrder.tag = indexPath.section;
    [cell.btn_cancelOrder addTarget:self action:@selector(cancelPurchaseOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_payOrder addTarget:self action:@selector(PayPurchaseOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:indexPath.section];
    PurchaseOrderDetailViewController *vc = [[PurchaseOrderDetailViewController alloc]init];
    vc.orderId = entity.orderId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.reloadStatus = ^(PurchaseOrderEntity *entity) {
        if (self.btnIndex == 999) {
            [self.arr_data replaceObjectAtIndex:indexPath.section withObject:entity];
        }else{
            [self.arr_data removeObjectAtIndex:indexPath.section];
        }
        [self.tb_purchaseOrder reloadData];
    };
}

- (void)cancelPurchaseOrderAction:(UIButton *)sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:sender.tag];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认取消订单?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ShoppingHandler cancelShopOrderDetailWithOrderId:entity.orderId prepare:^{
            
        } success:^(id obj) {
            if (self.btnIndex == 999) {
                entity.status = 9;
                [self.tb_purchaseOrder reloadData];
            }else{
                [self.arr_data removeObjectAtIndex:sender.tag];
                [self.tb_purchaseOrder reloadData];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:json];
        }];
       
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)PayPurchaseOrderAction:(UIButton *)sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:sender.tag];
    if (entity.status == 0) {
        PurchaseOrderDetailViewController *vc = [[PurchaseOrderDetailViewController alloc]init];
        vc.orderId = entity.orderId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (entity.status == 3) {
        //确认收货
        [ShoppingHandler confirmShopOrderDetailWithOrderId:entity.orderId prepare:^{
            
        } success:^(id obj) {
            if (self.btnIndex == 999) {
                entity.status = 8;
                [self.tb_purchaseOrder reloadData];
            }else{
                [self.arr_data removeObjectAtIndex:sender.tag];
                [self.tb_purchaseOrder reloadData];
            }
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }
}

- (void)searchAction{
    SearchPurchaseOrderViewController *vc = [[SearchPurchaseOrderViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (void)vHeaderTgp:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:v_sender.tag];
    PurchaseOrderDetailViewController *vc = [[PurchaseOrderDetailViewController alloc]init];
    vc.orderId = entity.orderId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.reloadStatus = ^(PurchaseOrderEntity *entity) {
        if (self.btnIndex == 999) {
            [self.arr_data replaceObjectAtIndex:v_sender.tag withObject:entity];
        }else{
            [self.arr_data removeObjectAtIndex:v_sender.tag];
        }
        [self.tb_purchaseOrder reloadData];
    };
}

- (void)NocatifionPayCompleteAndRefreshDataAction{
    self.btnIndex = 999;
    [self.tb_purchaseOrder requestDataSource];
}

- (void)leftBarAction:(id)sender{
    TabBarViewController *vc = [[TabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
