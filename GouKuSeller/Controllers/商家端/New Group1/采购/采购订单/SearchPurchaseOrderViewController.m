//
//  SearchPurchaseOrderViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/18.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchPurchaseOrderViewController.h"
#import "ShoppingHandler.h"
#import "PurchaseOrderEntity.h"
#import "PurchaseOrderTableViewCell.h"
#import "PurchaseOrderDetailViewController.h"

@interface SearchPurchaseOrderViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITextField            *tf_search;
@property (nonatomic,strong)BaseTableView           *tb_purchaseOrder;
@property (nonatomic ,strong)NSMutableArray         *arr_order;

@end

@implementation SearchPurchaseOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_order = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)onCreate{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem.customView = [UIView new];
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 44)];
    self.tf_search = [[UITextField alloc]initWithFrame:CGRectMake(0, 7, v_header.width - 50, 30)];
    UIView *v_left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIImageView *iv_icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
    [iv_icon setImage:[UIImage imageNamed:@"home_search"]];
    [v_left addSubview:iv_icon];
    self.tf_search.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.tf_search.leftView = v_left;
    self.tf_search.leftViewMode = UITextFieldViewModeAlways;
    self.tf_search.placeholder = @"搜索商品名称、供应商或订单号";
    self.tf_search.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    self.tf_search.textColor = [UIColor blackColor];
    [self.tf_search.layer setCornerRadius:5];
    self.tf_search.layer.masksToBounds = YES;
    self.tf_search.delegate = self;
    self.tf_search.returnKeyType = UIReturnKeySearch;
    self.tf_search.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_search.enablesReturnKeyAutomatically = YES;
    self.tf_search.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
    [v_header addSubview:self.tf_search];
    
    UIButton *btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.tf_search.right,0, 60, 44)];
    [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [btn_cancel setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [v_header addSubview:btn_cancel];
    
    self.navigationItem.titleView = v_header;
    
    self.tb_purchaseOrder = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_purchaseOrder];
    self.tb_purchaseOrder.delegate = self;
    self.tb_purchaseOrder.dataSource = self;
    [self.tb_purchaseOrder setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    self.tb_purchaseOrder.tableFooterView = [UIView new];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [ShoppingHandler selectOrderListWithStatus:nil keyWord:textField.text page:(int)nil prepare:^{
        
    } success:^(id obj) {
        [self.arr_order removeAllObjects];
        [self.arr_order addObjectsFromArray:(NSArray *)obj];
        [self.tb_purchaseOrder reloadData];
        if (self.arr_order.count == 0) {
            self.tb_purchaseOrder.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_purchaseOrder.frame withDefaultImage:nil withNoteTitle:@"没有找到对应订单" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
    return YES;
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
    return self.arr_order.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseOrderEntity *entity = [self.arr_order objectAtIndex:indexPath.section];
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
    
    PurchaseOrderEntity *entity = [self.arr_order objectAtIndex:section];
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
        [lb_status setText:@"已取消"];
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
    PurchaseOrderEntity *entity = [self.arr_order objectAtIndex:indexPath.section];
    [cell contentCellWithPurchaseOrderEntity:entity];
    cell.countDownZero = ^(PurchaseOrderEntity *entity) {
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
    PurchaseOrderEntity *entity = [self.arr_order objectAtIndex:indexPath.section];
    PurchaseOrderDetailViewController *vc = [[PurchaseOrderDetailViewController alloc]init];
    vc.orderId = entity.orderId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelPurchaseOrderAction:(UIButton *)sender{
    PurchaseOrderEntity *entity = [self.arr_order objectAtIndex:sender.tag];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认取消订单?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ShoppingHandler cancelShopOrderDetailWithOrderId:entity.orderId prepare:^{
            
        } success:^(id obj) {
            entity.status = 9;
            [self.tb_purchaseOrder reloadData];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:json];
        }];
        
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)PayPurchaseOrderAction:(UIButton *)sender{
    PurchaseOrderEntity *entity = [self.arr_order objectAtIndex:sender.tag];
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
            entity.status = 8;
            [self.tb_purchaseOrder reloadData];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }
}

- (void)vHeaderTgp:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    PurchaseOrderEntity *entity = [self.arr_order objectAtIndex:v_sender.tag];
    PurchaseOrderDetailViewController *vc = [[PurchaseOrderDetailViewController alloc]init];
    vc.orderId = entity.orderId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:NO];
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
