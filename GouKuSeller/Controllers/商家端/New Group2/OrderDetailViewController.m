//
//  OrderDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderHandler.h"
#import "OrderDetailEntity.h"
#import "OrderInformationHeaderView.h"
#import "OrderInformationFooterView.h"
#import "ItemsEntity.h"
#import "CashierTableViewCell.h"
#import "DateUtils.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)OrderDetailEntity  *orderDetailEntity;
@property (nonatomic ,strong)OrderInformationFooterView    *tbfooter;
@property (nonatomic ,strong)UITableView        *tb_commodity;
@property (nonatomic ,strong)NSMutableArray     *arr_data;
@property (nonatomic ,strong)UILabel            *lb_status;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_data = [NSMutableArray array];
    }
    return self;
}

- (void)onCreate{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [v_header setBackgroundColor:[UIColor whiteColor]];
    
    self.lb_status = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 50)];
    [self.lb_status setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [self.lb_status setFont:[UIFont systemFontOfSize:16]];
    [v_header addSubview:self.lb_status];
    
    self.tbfooter = [[OrderInformationFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 103)];
    [self.tbfooter.btn_copy addTarget:self action:@selector(btn_copy) forControlEvents:UIControlEventTouchUpInside];
    
    self.tb_commodity = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_commodity];
    [self.tb_commodity setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    self.tb_commodity.delegate = self;
    self.tb_commodity.dataSource = self;
    self.tb_commodity.tableHeaderView = v_header;
    self.tb_commodity.tableFooterView = self.tbfooter;
    [self loadData];
}

- (void)loadData{
    [OrderHandler getOrderDetailsWithShopId:[LoginStorage GetShopId] orderId:self.orderId prepare:^{
        [MBProgressHUD showActivityMessageInView:nil];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        self.orderDetailEntity = (OrderDetailEntity *)obj;
        NSMutableArray *arr_heji = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            ItemsEntity  *entity = [[ItemsEntity alloc]init];
            if (i == 0) {
                entity.name = @"商品总额";
                entity.pricePreferential = self.orderDetailEntity.payTotal;
                entity.amount = 1;
            }else if (i == 1){
                entity.name = @"优惠金额";
                entity.pricePreferential = self.orderDetailEntity.payReduce;
                entity.amount = 1;
            }else if (i == 2){
                entity.name = @"实付金额";
                entity.pricePreferential = self.orderDetailEntity.payActual;
                entity.amount = 1;
            }
            [arr_heji addObject:entity];
        }
        [self.arr_data addObject:@{@"title":@"合计",@"data":arr_heji}];
        if (self.orderDetailEntity.status == 2) {
            [self.lb_status setText:@"交易成功"];
            ItemsEntity  *entity = [[ItemsEntity alloc]init];
            if (self.orderDetailEntity.payType == 1) {
                entity.name = @"微信支付";
            }else if (self.orderDetailEntity.payType == 2){
                entity.name = @"现金支付";
            }
            entity.pricePreferential = self.orderDetailEntity.payActual;
            entity.amount = 1;
            [self.arr_data addObject:@{@"title":@"支付方式",@"data":@[entity]}];
        }else if (self.orderDetailEntity.status == 1){
            [self.lb_status setText:@"待支付"];
        }
        [self.arr_data addObject:@{@"title":@"商品",@"data":self.orderDetailEntity.items}];
        self.tbfooter.lab_orderCode.text = [NSString stringWithFormat:@"订单编号: %@",self.orderDetailEntity.orderId];
        NSString *paytime = [DateUtils stringFromTimeInterval:self.orderDetailEntity.payDate formatter:@"yyyy-MM-dd HH:mm:ss"];
        if (self.orderDetailEntity.status == 2) {
            [self.tbfooter.lab_payTime setText:[NSString stringWithFormat:@"支付时间: %@",paytime]];
        }
        [self.tb_commodity reloadData];
        
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];

    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_section = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    [v_section setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, 20)];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [lb_title setFont:[UIFont systemFontOfSize:14]];
    [v_section addSubview:lb_title];
    NSDictionary *dic = [self.arr_data objectAtIndex:section];
    [lb_title setText:[dic objectForKey:@"title"]];
    return v_section;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.arr_data objectAtIndex:indexPath.section];
    ItemsEntity *entity = [[dic objectForKey:@"data"] objectAtIndex:indexPath.row];
    if ((entity.price - entity.pricePreferential) > 0 && indexPath.section == self.arr_data.count - 1) {
        return 65;
    }else{
        return 49;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = [self.arr_data objectAtIndex:section];
    return [[dic objectForKey:@"data"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"OrderListTableViewCell";
    CashierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CashierTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = [self.arr_data objectAtIndex:indexPath.section];
    ItemsEntity *entity = [[dic objectForKey:@"data"] objectAtIndex:indexPath.row];
    [cell contentWithItemEntity:entity];
    if (entity.pricePreferential > 0 && indexPath.section == self.arr_data.count - 1){
        [cell.lab_price_yuanjia setHidden:NO];
    }else{
        [cell.lab_price_yuanjia setHidden:YES];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)btn_copy{
    [MBProgressHUD showInfoMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.orderDetailEntity.orderId;
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
