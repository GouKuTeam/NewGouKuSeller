//
//  ShopOrderManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopOrderManagerViewController.h"
#import "ShopOrderManagerView.h"
#import "TabBarViewController.h"
#import "SupplierOrderHandler.h"
#import "SupplierOrderHeaderView.h"
#import "ShopOrderManagerSectionHeaderView.h"
#import "ShopOrderManagerSectionFooterView.h"
#import "SupplierOrderManagerTableViewCell.h"
#import "SupplierOrderHandler.h"
#import "PurchaseOrderEntity.h"
#import "CountDownManager.h"
#import "SupplierCommodityEndity.h"
#import "ShopOutOrderCountEntity.h"
#import "SupplierTabbarViewController.h"
#import "ShopPriceDetailView.h"
#import "NSString+Size.h"
#import "ShopOrderManagerSectionFooterView.h"
#import "OrderSelectOnlineOrderSectionFooterView.h"
#import "JWBluetoothManage.h"
#import "DateUtils.h"

@interface ShopOrderManagerViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate,UITextFieldDelegate>{
    JWBluetoothManage * manage;
}

@property (nonatomic ,strong)ShopOrderManagerView      *v_top;
@property (nonatomic ,assign)int                        selectIndex;

@property (nonatomic ,strong)SupplierOrderHeaderView   *v_header;
@property (nonatomic ,strong)BaseTableView             *tb_orderManager;
@property (nonatomic ,strong)NSMutableArray            *arr_data;
@property (nonatomic ,assign)int                       newOrderCount;
@property (nonatomic ,assign)int                       hadleOrderCount;
@property (nonatomic ,assign)int                       cleseOrderCount;

@property (nonatomic ,strong)ShopPriceDetailView       *shopPriceDetailView;


@end

@implementation ShopOrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    
    self.arr_data = [NSMutableArray array];
    [kCountDownManager start];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshSupplierOrderData) name:@"RefreshSupplierOrderData" object:nil];
    manage = [JWBluetoothManage sharedInstance];
}

- (void)onCreate{
    self.v_top = [[ShopOrderManagerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaStatusBarHeight + 72)];
    [self.view addSubview:self.v_top];
    WS(weakSelf);
    self.v_top.selectType = ^(NSInteger index) {
        weakSelf.selectIndex = (int)index + 1;
        [weakSelf.tb_orderManager requestDataSource];
//        NSLog(@"%d     %d",(int)index,weakSelf.selectIndex);
    };
    self.tb_orderManager = [[BaseTableView alloc]initWithFrame:CGRectMake(0,self.v_top.bottom, SCREEN_WIDTH,SCREEN_HEIGHT - self.v_top.bottom - SafeAreaBottomHeight - 49) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_orderManager.delegate = self;
    self.tb_orderManager.dataSource = self;
    self.tb_orderManager.tableViewDelegate = self;
    self.tb_orderManager.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tb_orderManager.separatorColor = [UIColor clearColor];
    self.tb_orderManager.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_orderManager];
    
    
    self.shopPriceDetailView = [[ShopPriceDetailView alloc]init];
    [self.shopPriceDetailView setHidden:YES];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.shopPriceDetailView];
    [self.shopPriceDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self.v_top setItemWithIndex:0];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
   
    [SupplierOrderHandler shopSelectManagerOrderWithOrderStatus:[NSNumber numberWithInt:self.selectIndex] prepare:^{
        
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
    ShopOrderManagerSectionHeaderView *v_header = [[ShopOrderManagerSectionHeaderView alloc]init];
    return [v_header getHeightWithPurchaseOrderEntity:entity];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.selectIndex == 1) {
        return 147;
    }
    if (self.selectIndex == 2) {
        return 97;
    }
    if (self.selectIndex == 3) {
        return 166 + 45;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:section];
    ShopOrderManagerSectionHeaderView *v_header = [[ShopOrderManagerSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    CGFloat height = [v_header getHeightWithPurchaseOrderEntity:entity];
    [v_header setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    [v_header contentViewWithPurchaseOrderEntity:entity];
    v_header.btn_zhankai.tag = section;
    [v_header.btn_zhankai addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    v_header.btn_tell.tag = section;
    [v_header.btn_tell addTarget:self action:@selector(btn_tellAction:) forControlEvents:UIControlEventTouchUpInside];
    v_header.btn_DetailTell.tag = section;
    [v_header.btn_DetailTell addTarget:self action:@selector(btn_tellAction:) forControlEvents:UIControlEventTouchUpInside];
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
    ShopOrderManagerSectionFooterView *v_footer = [[ShopOrderManagerSectionFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [v_footer contentViewWithPurchaseOrderEntity:entity];
    v_footer.btn_right.tag = section;
    [v_footer.btn_right addTarget:self action:@selector(btn_rightAction:) forControlEvents:UIControlEventTouchUpInside];

    v_footer.btn_copy.tag = section;
    [v_footer.btn_copy addTarget:self action:@selector(btn_copyAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_priceDetail.tag = section;
    [v_footer.btn_priceDetail addTarget:self action:@selector(showPriceDetail:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_printer.tag = section;
    [v_footer.btn_printer addTarget:self action:@selector(btn_printerAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.countDownZero = ^(PurchaseOrderEntity *entity) {
        [self.arr_data removeObjectAtIndex:section];
        [self.tb_orderManager reloadData];
//        self.obligationTotal = self.obligationTotal - 1;
        [self setNumData];

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
    if (entity.status == 1) {
        //接单
        [SupplierOrderHandler shopGetOrderWithOrderId:entity.orderId prepare:^{
            
        } success:^(id obj) {
            [self.arr_data removeObjectAtIndex:btn_sender.tag];
            [self.tb_orderManager reloadData];
            self.newOrderCount = self.newOrderCount - 1;
            [self setNumData];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }else if (entity.status == 9){
        //取消
        if (entity.refund == 1) {
            //用户申请退款退款
            [SupplierOrderHandler shopAgreeUserCancelOrderWithOrderId:entity.orderId prepare:^{
                
            } success:^(id obj) {
                [self.arr_data removeObjectAtIndex:btn_sender.tag];
                [self.tb_orderManager reloadData];
                self.cleseOrderCount = self.cleseOrderCount - 1;
                [self setNumData];
            } failed:^(NSInteger statusCode, id json) {
                
            }];
        }
        if (entity.refund == 2) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要同意取消订单？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SupplierOrderHandler shopAgreeUserCancelOrderWithOrderId:entity.orderId prepare:^{
                    
                } success:^(id obj) {
                    [self.arr_data removeObjectAtIndex:btn_sender.tag];
                    [self.tb_orderManager reloadData];
                    self.cleseOrderCount = self.cleseOrderCount - 1;
                    [self setNumData];
                } failed:^(NSInteger statusCode, id json) {
                    
                }];
            }];
            [alert addAction:forgetPassword];
            [alert addAction:again];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)showPriceDetail:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    [self.shopPriceDetailView contentViewWithPurchaseOrderEntity:entity];
    [self.shopPriceDetailView setHidden:NO];
}

- (void)setNumData{
    UILabel *lb_num1 = [self.v_top.arr_num objectAtIndex:0];
    UILabel *lb_num2 = [self.v_top.arr_num objectAtIndex:1];
    UILabel *lb_num3 = [self.v_top.arr_num objectAtIndex:2];
    if (self.newOrderCount > 0) {
        [lb_num1 setHidden:NO];
        [lb_num1 setText:[NSString stringWithFormat:@"%d",self.newOrderCount]];
        CGFloat width = 16;
        if (self.newOrderCount < 10) {
            width = 16;
        }else{
            width = [lb_num1.text fittingLabelWidthWithHeight:16 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_MEMO]] + 6;
        }
        [lb_num1 setFrame:CGRectMake(lb_num1.left, lb_num1.top, width, lb_num1.height)];
    }else{
        [lb_num1 setHidden:YES];
    }
    if (self.hadleOrderCount > 0) {
        [lb_num2 setHidden:NO];
        [lb_num2 setText:[NSString stringWithFormat:@"%d",self.hadleOrderCount]];
        CGFloat width = 16;
        if (self.hadleOrderCount < 10) {
            width = 16;
        }else{
            width = [lb_num2.text fittingLabelWidthWithHeight:16 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_MEMO]] + 6;
        }
        [lb_num2 setFrame:CGRectMake(lb_num2.left, lb_num2.top, width, lb_num2.height)];
    }else{
        [lb_num2 setHidden:YES];
    }
    if (self.cleseOrderCount > 0) {
        [lb_num3 setHidden:NO];
        [lb_num3 setText:[NSString stringWithFormat:@"%d",self.cleseOrderCount]];
        CGFloat width = 16;
        if (self.cleseOrderCount < 10) {
            width = 16;
        }else{
            width = [lb_num3.text fittingLabelWidthWithHeight:16 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_MEMO]] + 6;
        }
        [lb_num3 setFrame:CGRectMake(lb_num3.left, lb_num3.top, width, lb_num3.height)];
    }else{
        [lb_num3 setHidden:YES];
    }
    [(TabBarViewController *)self.tabBarController showBadgeOnItemIndex:1 withCount:self.newOrderCount + self.hadleOrderCount + self.cleseOrderCount];
}

- (void)RefreshSupplierOrderData{
    [self.v_header setItemWithIndex:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
    [SupplierOrderHandler selectOutOrderCountPrepare:^{
        
    } success:^(id obj) {
        ShopOutOrderCountEntity *entity = (ShopOutOrderCountEntity *)obj;
        self.newOrderCount = entity.newOrderCount;
        self.hadleOrderCount = entity.hadleOrderCount;
        self.cleseOrderCount = entity.cleseOrderCount;
        [self setNumData];
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

- (void)btn_printerAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    
    if (manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = [NSString stringWithFormat:@"********饿了么#%@********",entity.number];
    [printer appendText:str1 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    NSString *str2 = [LoginStorage GetShopName];
    [printer appendText:str2 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    NSString *str3 = @"--已在线支付--";
    [printer appendText:str3 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
    [printer appendSeperatorLine];
    NSString *str5 = [NSString stringWithFormat:@"下单时间：%@",[DateUtils stringFromTimeInterval:entity.createTime formatter:@"MM-dd HH:mm"]];
    [printer appendText:str5 alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    NSString *str6 = entity.remark;
    [printer appendText:str6 alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleMiddle];
    if (entity.invoice.length > 0) {
        NSString *str7 = [NSString stringWithFormat:@"发票：%@",entity.invoice];
        [printer appendText:str7 alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleMiddle];
    }
    NSMutableArray *arr_commodity = [[NSMutableArray alloc]init];
    NSMutableArray *arr_baozhuang = [[NSMutableArray alloc]init];
    NSMutableArray *arr_zengpin = [[NSMutableArray alloc]init];
    for (int i= 0; i < entity.items.count; i++) {
        SupplierCommodityEndity *commidityEntity = [entity.items objectAtIndex:i];
        if ([commidityEntity.type intValue] == 1) {
            [arr_commodity addObject:commidityEntity];
        }
        if ([commidityEntity.type intValue] == 2) {
            [arr_baozhuang addObject:commidityEntity];
        }
        if ([commidityEntity.type intValue] == 3) {
            [arr_zengpin addObject:commidityEntity];
        }
    }
    if (arr_commodity.count > 0) {
        NSString *str8 = @"-------------商品-------------";
        [printer appendText:str8 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
        for (int i = 0; i < arr_commodity.count; i++) {
            SupplierCommodityEndity *commidityEntity = [arr_commodity objectAtIndex:i];
            [printer appendLeftText:commidityEntity.name middleText:[NSString stringWithFormat:@"x%ld",commidityEntity.count] rightText:[NSString stringWithFormat:@"%.2f",commidityEntity.count * commidityEntity.price] isTitle:YES];
        }
    }
    if (arr_baozhuang.count > 0) {
        NSString *str9 = @"-------------包装-------------";
        [printer appendText:str9 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
        for (int i = 0; i < arr_baozhuang.count; i++) {
            SupplierCommodityEndity *commidityEntity = [arr_baozhuang objectAtIndex:i];
            [printer appendLeftText:commidityEntity.name middleText:[NSString stringWithFormat:@"x%ld",commidityEntity.count] rightText:[NSString stringWithFormat:@"%.2f",commidityEntity.count * commidityEntity.price] isTitle:YES];
        }
    }
    if (arr_zengpin.count > 0) {
        NSString *str10 = @"-------------赠品-------------";
        [printer appendText:str10 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
        for (int i = 0; i < arr_zengpin.count; i++) {
            SupplierCommodityEndity *commidityEntity = [arr_zengpin objectAtIndex:i];
            [printer appendLeftText:commidityEntity.name middleText:[NSString stringWithFormat:@"x%ld",commidityEntity.count] rightText:[NSString stringWithFormat:@"%.2f",commidityEntity.count * commidityEntity.price] isTitle:YES];
        }
    }
    [printer appendSeperatorLine];
    
    NSMutableArray *arr_youhui = [NSMutableArray arrayWithArray:entity.actOut];
    if (arr_youhui.count > 0) {
        for (int i = 0; i < arr_youhui.count; i++) {
            NSDictionary *diccc = [arr_youhui objectAtIndex:i];
            [printer appendTitle:[diccc objectForKey:@"name"]  value:[[diccc objectForKey:@"price"] stringValue]];
        }
    }
    
    [printer appendTitle:@"配送费"  value:[NSString stringWithFormat:@"%.2f",entity.payFreight]];
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"实付" value:[NSString stringWithFormat:@"%.2f",entity.payActual] fontSize:HLFontSizeTitleSmalle];
    [printer appendSeperatorLine];
    [printer appendText:entity.address.address alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleMiddle];
    [printer appendText:entity.address.name alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleMiddle];
    [printer appendText:entity.address.phone alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleMiddle];
    
    [printer appendText:[NSString stringWithFormat:@"订单编号：%@",entity.orderId] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    
    [printer appendFooter:[NSString stringWithFormat:@"********%@********",[LoginStorage GetShopName]]];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
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
