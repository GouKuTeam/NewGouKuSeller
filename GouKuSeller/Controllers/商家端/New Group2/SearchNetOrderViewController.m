//
//  SearchNetOrderViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchNetOrderViewController.h"
#import "IQKeyboardManager.h"
#import "OrderHandler.h"
#import "OrderListTableViewCell.h"
#import "OrderListEntity.h"
#import "DateUtils.h"
#import "OrderDetailViewController.h"
#import "SupplierOrderHandler.h"
#import "PurchaseOrderEntity.h"
#import "JWBluetoothManage.h"
#import "ShopOrderManagerSectionHeaderView.h"
#import "OrderSelectOnlineOrderSectionFooterView.h"
#import "SupplierOrderManagerTableViewCell.h"
#import "ShopPriceDetailView.h"

@interface SearchNetOrderViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>{
    JWBluetoothManage * manage;
}
@property (nonatomic, strong)UITextField           *tf_search;
@property (nonatomic ,strong)BaseTableView            *tb_order;
@property (nonatomic ,strong)NSMutableArray                *arr_index;
@property (nonatomic ,strong)NSMutableArray                *arr_allData;
@property (nonatomic ,strong)NSMutableArray                *arr_leftOrder;
@property (nonatomic ,strong)ShopPriceDetailView       *shopPriceDetailView;


@end

@implementation SearchNetOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    manage = [JWBluetoothManage sharedInstance];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_leftOrder = [[NSMutableArray alloc]init];
        self.arr_index = [[NSMutableArray alloc]init];
        self.arr_allData = [[NSMutableArray alloc]init];
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
    self.tf_search.placeholder = @"搜索商品名称或线上订单号";
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
    
    
    self.tb_order = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:YES];
    [self.view addSubview:self.tb_order];
    [self.tb_order setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    self.tb_order.delegate = self;
    self.tb_order.dataSource = self;
    self.tb_order.tableViewDelegate = self;
    self.tb_order.tableFooterView = [UIView new];
    self.tb_order.separatorColor = [UIColor clearColor];
    
    self.shopPriceDetailView = [[ShopPriceDetailView alloc]init];
    [self.shopPriceDetailView setHidden:YES];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.shopPriceDetailView];
    [self.shopPriceDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"%@",textField.text);
    
    [self.tb_order requestDataSource];
    return YES;
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [SupplierOrderHandler shopSelectOrderWithOrderStatus:nil keyWords:self.tf_search.text pageNum:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_leftOrder removeAllObjects];
            [self.arr_index removeAllObjects];
            [self.arr_allData removeAllObjects];
        }
        NSArray  *arr_data = [(NSDictionary *)obj objectForKey:@"data"];
        [self.arr_allData addObjectsFromArray:arr_data];
        for (int i = 0;i < arr_data.count;i++) {
            NSDictionary *dic = [arr_data objectAtIndex:i];
            [self.arr_index addObject:[NSNumber numberWithInt:(int)self.arr_leftOrder.count - 1 >= 0 ? (int)self.arr_leftOrder.count - 1 : 0]];
            NSArray *arr_entity = [PurchaseOrderEntity parsePurchaseOrderEntityListWithJson:[dic objectForKey:@"orders"]];
            [self.arr_leftOrder addObjectsFromArray:arr_entity];
        }
        complete([(NSArray *)arr_data count]);
        if (self.arr_leftOrder.count == 0) {
            self.tb_order.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_order.frame withDefaultImage:nil withNoteTitle:@"暂无数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:section];
    ShopOrderManagerSectionHeaderView *v_header = [[ShopOrderManagerSectionHeaderView alloc]init];
    return [v_header getHeightWithPurchaseOrderEntity:entity] + 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 91;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr_leftOrder.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:section];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_allHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170 + 37)];
    v_allHeader.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    UILabel *lb_date = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 26, 37)];
    [lb_date setFont:[UIFont systemFontOfSize:14]];
    [lb_date setTextColor:[UIColor colorWithHexString:@"#959595"]];
    [v_allHeader addSubview:lb_date];
    [lb_date setText:@""];
    for (int i = 0; i < self.arr_index.count; i++) {
        if (section == [[self.arr_index objectAtIndex:i] intValue]) {
            NSDictionary *dic = [self.arr_allData objectAtIndex:i];
            [lb_date setText:[dic objectForKey:@"date"]];
            break;
        }
    }
    
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:section];
    ShopOrderManagerSectionHeaderView *v_header = [[ShopOrderManagerSectionHeaderView alloc]initWithFrame:CGRectMake(0, 37, SCREEN_WIDTH, 170)];
    [v_header.v_top mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [v_allHeader addSubview:v_header];
    CGFloat height = [v_header getHeightWithPurchaseOrderEntity:entity];
    [v_header setFrame:CGRectMake(0, 37, SCREEN_WIDTH, height)];
    [v_allHeader setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height + 37)];
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
    return v_allHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:section];
    OrderSelectOnlineOrderSectionFooterView *v_footer = [[OrderSelectOnlineOrderSectionFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,91)];
    v_footer.clipsToBounds = YES;
    [v_footer contentViewWithPurchaseOrderEntity:entity];
    v_footer.btn_copy.tag = section;
    [v_footer.btn_copy addTarget:self action:@selector(btn_copyAction:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_priceDetail.tag = section;
    [v_footer.btn_priceDetail addTarget:self action:@selector(showPriceDetail:) forControlEvents:UIControlEventTouchUpInside];
    v_footer.btn_printer.tag = section;
    [v_footer.btn_printer addTarget:self action:@selector(btn_printerAction:) forControlEvents:UIControlEventTouchUpInside];
    return v_footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SupplierOrderCell";
    SupplierOrderManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SupplierOrderManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:indexPath.section];
    SupplierCommodityEndity *commidityEntity = [entity.items objectAtIndex:indexPath.row];
    [cell contentCellWithSupplierCommodityEndity:commidityEntity];
    return cell;
}

- (void)showAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:btn_sender.tag];
    if (entity.isShow == YES) {
        entity.isShow = NO;
    }else{
        entity.isShow = YES;
    }
    [self.tb_order reloadData];
}

- (void)btn_tellAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:btn_sender.tag];
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",entity.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)btn_copyAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:btn_sender.tag];
    [MBProgressHUD showInfoMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",entity.orderId];
}

- (void)showPriceDetail:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:btn_sender.tag];
    [self.shopPriceDetailView contentViewWithPurchaseOrderEntity:entity];
    [self.shopPriceDetailView setHidden:NO];
}

- (void)btn_printerAction:(UIButton *)btn_sender{
    PurchaseOrderEntity *entity = [self.arr_leftOrder objectAtIndex:btn_sender.tag];
    
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

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
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
