//
//  OrderManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderManagerViewController.h"
#import "ExportOrderViewController.h"
#import "SupplierOrderHeaderView.h"
#import "SupplierOrderManagerSectionFooterView.h"
#import "SupplierOrderManagerSectionHeaderView.h"
#import "SupplierOrderManagerTableViewCell.h"
#import "SupplierOrderHandler.h"
#import "PurchaseOrderEntity.h"
#import "CountDownManager.h"
#import "SupplierCommodityEndity.h"
#import "SupplierCountEntity.h"
#import "SupplierTabbarViewController.h"
#import "SupplierPriceDetailView.h"
#import "NSString+Size.h"

@interface OrderManagerViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate,UITextFieldDelegate>

@property (nonatomic ,strong)UIButton                  *btn_daochu;
@property (nonatomic ,strong)SupplierOrderHeaderView   *v_header;
@property (nonatomic ,strong)BaseTableView             *tb_orderManager;
@property (nonatomic ,strong)NSMutableArray            *arr_data;
@property (nonatomic ,assign)int                        selectIndex;
@property (nonatomic ,assign)int                       obligationTotal;
@property (nonatomic ,assign)int                       pendingTotal;
@property (nonatomic ,strong)SupplierPriceDetailView   *supplierPriceDetailView;

@property (nonatomic ,strong)UIAlertController *alertController;


@end

@implementation OrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.arr_data = [NSMutableArray array];
    [kCountDownManager start];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshSupplierOrderData) name:@"RefreshSupplierOrderData" object:nil];
}

- (void)onCreate{
    
    self.v_header = [[SupplierOrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaStatusBarHeight + 72)];
    [self.view addSubview:self.v_header];
    WS(weakSelf);
    self.v_header.selectType = ^(NSInteger index) {
        if (index == 1) {
            index = 2;
        }
        weakSelf.selectIndex = (int)index;
        [weakSelf.tb_orderManager requestDataSource];
    };
    
    self.tb_orderManager = [[BaseTableView alloc]initWithFrame:CGRectMake(0,self.v_header.bottom, SCREEN_WIDTH,self.view.height - self.v_header.bottom - SafeAreaBottomHeight - 49) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_orderManager.delegate = self;
    self.tb_orderManager.dataSource = self;
    self.tb_orderManager.tableViewDelegate = self;
    self.tb_orderManager.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tb_orderManager.separatorColor = [UIColor clearColor];
    self.tb_orderManager.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_orderManager];

    self.btn_daochu = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 109, 44, 44)];
    [self.view addSubview:self.btn_daochu];
    [self.view bringSubviewToFront:self.btn_daochu];
    [self.btn_daochu setBackgroundImage:[UIImage imageNamed:@"export"] forState:UIControlStateNormal];
    [self.btn_daochu addTarget:self action:@selector(btn_daochuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_daochu setHidden:YES];
    
    self.supplierPriceDetailView = [[SupplierPriceDetailView alloc]init];
    [self.supplierPriceDetailView setHidden:YES];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.supplierPriceDetailView];
    [self.supplierPriceDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self.v_header setItemWithIndex:0];
}

- (void)btn_daochuAction{
    ExportOrderViewController *vc = [[ExportOrderViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [SupplierOrderHandler supplierOrderListWithStatus:[NSNumber numberWithInt:self.selectIndex] keyWord:nil prepare:^{
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_data removeAllObjects];
        }
        [self.arr_data addObjectsFromArray:(NSArray *)obj];
        [self.tb_orderManager reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_data.count == 0) {
            self.tb_orderManager.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_orderManager.frame withDefaultImage:nil withNoteTitle:@"暂无订单" withNoteDetail:nil withButtonAction:nil];
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
    [self.navigationController.navigationBar setHidden:YES];
    [SupplierOrderHandler getSupplierOrderCountPrepare:^{
        
    } success:^(id obj) {
        SupplierCountEntity *entity = (SupplierCountEntity *)obj;
        self.obligationTotal = entity.obligationTotal;
        self.pendingTotal = entity.pendingTotal;
        [self setNumData];
        if (entity.allTotal > 0) {
            [(SupplierTabbarViewController *)self.tabBarController showBadgeOnItemIndex:0 withCount:entity.allTotal];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    if (entity.items.count > 2) {
        if (entity.isShow == YES) {
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
    v_header.btn_tell.tag = section;
    [v_header.btn_tell addTarget:self action:@selector(btn_tellAction:) forControlEvents:UIControlEventTouchUpInside];
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
    v_footer.btn_cancelOrder.tag = section;
    [v_footer.btn_right addTarget:self action:@selector(btn_rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [v_footer.btn_cancelOrder addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_copy.tag = section;
    [v_footer.btn_copy addTarget:self action:@selector(btn_copyAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_priceDetail.tag = section;
    [v_footer.btn_priceDetail addTarget:self action:@selector(showPriceDetail:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.countDownZero = ^(PurchaseOrderEntity *entity) {
        [self.arr_data removeObjectAtIndex:section];
        self.obligationTotal = self.obligationTotal - 1;
        [self setNumData];
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

- (void)cancelAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定取消此采购订单?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SupplierOrderHandler supplierCancelOrderWithOrderId:entity.orderId prepare:^{
            
        } success:^(id obj) {
            [self.arr_data removeObjectAtIndex:btn_sender.tag];
            [self.tb_orderManager reloadData];
            self.obligationTotal = self.obligationTotal - 1;
            [self setNumData];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)btn_tellAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",entity.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)btn_copyAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    [MBProgressHUD showInfoMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",entity.orderId];
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
            [self.arr_data removeObjectAtIndex:btn_sender.tag];
            self.pendingTotal = self.pendingTotal - 1;
            [self.tb_orderManager reloadData];
            [self setNumData];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }
}

- (void)showPriceDetail:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    [self.supplierPriceDetailView contentViewWithPurchaseOrderEntity:entity];
    [self.supplierPriceDetailView setHidden:NO];
}

- (void)setNumData{
    UILabel *lb_num1 = [self.v_header.arr_num objectAtIndex:0];
    UILabel *lb_num2 = [self.v_header.arr_num objectAtIndex:1];
    if (self.obligationTotal > 0) {
        [lb_num1 setHidden:NO];
        [lb_num1 setText:[NSString stringWithFormat:@"%d",self.obligationTotal]];
        CGFloat width = 16;
        if (self.obligationTotal < 10) {
            width = 16;
        }else{
            width = [lb_num1.text fittingLabelWidthWithHeight:16 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_MEMO]] + 6;
        }
        [lb_num1 setFrame:CGRectMake(lb_num1.left, lb_num1.top, width, lb_num1.height)];
    }else{
        [lb_num1 setHidden:YES];
    }
    if (self.pendingTotal > 0) {
        [lb_num2 setHidden:NO];
        [lb_num2 setText:[NSString stringWithFormat:@"%d",self.pendingTotal]];
        CGFloat width = 16;
        if (self.pendingTotal < 10) {
            width = 16;
        }else{
            width = [lb_num2.text fittingLabelWidthWithHeight:16 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_MEMO]] + 6;
        }
        [lb_num2 setFrame:CGRectMake(lb_num2.left, lb_num2.top, width, lb_num2.height)];
    }else{
        [lb_num2 setHidden:YES];
    }
    [(SupplierTabbarViewController *)self.tabBarController showBadgeOnItemIndex:0 withCount:self.obligationTotal + self.pendingTotal];
}

- (void)RefreshSupplierOrderData{
    [self.v_header setItemWithIndex:1];
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
