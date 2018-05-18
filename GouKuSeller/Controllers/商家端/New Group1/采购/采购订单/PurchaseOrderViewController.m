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
    
    self.tb_purchaseOrder = [[BaseTableView alloc]initWithFrame:CGRectMake(0,v_header.bottom, SCREEN_WIDTH,self.view.height - v_header.bottom - SafeAreaBottomHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_purchaseOrder.delegate = self;
    self.tb_purchaseOrder.dataSource = self;
    self.tb_purchaseOrder.tableFooterView = [UIView new];
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
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 52;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
    [v_header setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    
    UIImageView *iv_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 22, 22)];
    [iv_avatar.layer setCornerRadius:11];
    [iv_avatar.layer setMasksToBounds:YES];
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
    
    return v_header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PurchaseOrderCell";
    PurchaseOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PurchaseOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
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
