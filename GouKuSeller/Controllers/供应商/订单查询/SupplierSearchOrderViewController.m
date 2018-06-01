//
//  SupplierSearchOrderViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/23.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierSearchOrderViewController.h"
#import "SupplierOrderSelectHeaderView.h"
#import "PurchaseOrderEntity.h"
#import "SupplierOrderHandler.h"
#import "SupplierOrderManagerSectionFooterView.h"
#import "SupplierOrderManagerSectionHeaderView.h"
#import "SupplierOrderManagerTableViewCell.h"
#import "PurchaseOrderEntity.h"
#import "CountDownManager.h"
#import "SupplierCommodityEndity.h"
#import "SupplierCountEntity.h"
#import "SupplierTabbarViewController.h"
#import "SupplierSearchOrderViewController.h"
#import "SupplierPriceDetailView.h"

@interface SupplierSearchOrderViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate,UITextFieldDelegate>

@property (nonatomic ,strong)UIButton                  *btn_daochu;
@property (nonatomic ,strong)BaseTableView             *tb_orderManager;
@property (nonatomic ,strong)NSMutableArray            *arr_data;
@property (nonatomic ,strong)UIAlertController         *alertController;
@property (nonatomic, strong)UITextField               *tf_search;
@property (nonatomic ,strong)SupplierPriceDetailView   *supplierPriceDetailView;

@end

@implementation SupplierSearchOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arr_data = [NSMutableArray array];
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
    self.tf_search.placeholder = @"输入订单号搜索订单";
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
    
    self.tb_orderManager = [[BaseTableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,self.view.height - SafeAreaBottomHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_orderManager.delegate = self;
    self.tb_orderManager.dataSource = self;
    self.tb_orderManager.tableViewDelegate = self;
    self.tb_orderManager.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tb_orderManager.separatorColor = [UIColor clearColor];
    self.tb_orderManager.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_orderManager];
    
    self.supplierPriceDetailView = [[SupplierPriceDetailView alloc]init];
    [self.supplierPriceDetailView setHidden:YES];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.supplierPriceDetailView];
    [self.supplierPriceDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"%@",textField.text);
    //网络请求
    [self.tb_orderManager requestDataSource];
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

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [SupplierOrderHandler supplierOrderListWithStatus:nil keyWord:self.tf_search.text prepare:^{
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_data removeAllObjects];
        }
        [self.arr_data addObjectsFromArray:(NSArray *)obj];
        [self.tb_orderManager reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_data.count == 0) {
            self.tb_orderManager.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_orderManager.frame withDefaultImage:nil withNoteTitle:@"未找到相关订单" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    if (entity.items.count > 2) {
        if (entity.isShow == NO) {
            return 2;
        }else{
            return entity.items.count;
        }
    }else{
        return entity.items.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    SupplierOrderManagerSectionHeaderView *v_header = [[SupplierOrderManagerSectionHeaderView alloc]init];
    return [v_header getHeightWithPurchaseOrderEntity:entity];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    if (entity.status == 8 || entity.status == 9) {
        return 65;
    }
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    SupplierOrderManagerSectionHeaderView *v_header = [[SupplierOrderManagerSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    CGFloat height = [v_header getHeightWithPurchaseOrderEntity:entity];
    [v_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    [v_header contentViewWithPurchaseOrderEntity:entity];
    v_header.btn_zhankai.tag = section;
    [v_header.btn_zhankai addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    if (entity.isShow == YES) {
        [v_header.btn_zhankai setTitle:@"收起" forState:UIControlStateNormal];
    }else{
        [v_header.btn_zhankai setTitle:@"展开" forState:UIControlStateNormal];
    }
    if (entity.items.count > 2) {
        [v_header.btn_zhankai setHidden:NO];
    }else{
        [v_header.btn_zhankai setHidden:YES];
    }
    return v_header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    SupplierOrderManagerSectionFooterView *v_footer = [[SupplierOrderManagerSectionFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [v_footer contentViewWithPurchaseOrderEntity:entity];
    v_footer.btn_right.tag = section;
    [v_footer.btn_right addTarget:self action:@selector(btn_rightAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_copy.tag = section;
    [v_footer.btn_copy addTarget:self action:@selector(btn_copyAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_cancelOrder.tag = section;
    [v_footer.btn_cancelOrder addTarget:self action:@selector(btn_cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_priceDetail.tag = section;
    [v_footer.btn_priceDetail addTarget:self action:@selector(showPriceDetail:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.countDownZero = ^(PurchaseOrderEntity *entity) {
        [self.arr_data removeObjectAtIndex:section];
        [SupplierOrderHandler supplierCancelOrderWithOrderId:entity.orderId prepare:^{
        } success:^(id obj) {
        } failed:^(NSInteger statusCode, id json) {
        }];
    };
    return v_footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SupplierOrderCell";
    SupplierOrderManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SupplierOrderManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:indexPath.section];
    SupplierCommodityEndity *commidityEntity = [entity.items objectAtIndex:indexPath.row];
    [cell contentCellWithSupplierCommodityEndity:commidityEntity];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    if (entity.isShow == YES) {
        entity.isShow = NO;
    }else{
        entity.isShow = YES;
    }
    [self.tb_orderManager reloadData];
}

- (void)btn_rightAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    if (entity.status == 0) {
        //修改价格
        self.alertController = [UIAlertController alertControllerWithTitle:nil message:@"输入最终交易价格" preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *userNameTextField = self.alertController.textFields.firstObject;
            if (![userNameTextField.text isEqualToString:@""]) {
                [SupplierOrderHandler supplierChangeOrderPriceWithOrderId:entity.orderId price:[NSString stringWithFormat:@"%.2f",[userNameTextField.text doubleValue]] prepare:^{
                } success:^(id obj) {
                    entity.payActual = [userNameTextField.text doubleValue];
                    [self.tb_orderManager reloadSections:[NSIndexSet indexSetWithIndex:btn_sender.tag] withRowAnimation:UITableViewRowAnimationNone];
                } failed:^(NSInteger statusCode, id json) {
                    
                }];
            }
        }]];
        //定义第一个输入框；
        [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.delegate = self;
        }];
        [self presentViewController:self.alertController animated:true completion:nil];
    }else if (entity.status == 2){
        //发货
        [SupplierOrderHandler supplierSendCommodityWithOrderId:entity.orderId prepare:^{
            
        } success:^(id obj) {
            entity.status = 3;
            [self.tb_orderManager reloadData];
            
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }
}

- (void)btn_cancelOrderAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定取消此采购订单?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SupplierOrderHandler supplierCancelOrderWithOrderId:entity.orderId prepare:^{
            
        } success:^(id obj) {
            entity.status = 9;
            [self.tb_orderManager reloadData];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)btn_copyAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    [MBProgressHUD showInfoMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",entity.orderId];
}

- (void)showPriceDetail:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    [self.supplierPriceDetailView contentViewWithPurchaseOrderEntity:entity];
    [self.supplierPriceDetailView setHidden:NO];
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
