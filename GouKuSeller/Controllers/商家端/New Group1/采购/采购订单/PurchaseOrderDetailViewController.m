//
//  PurchaseOrderDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseOrderDetailViewController.h"
#import "AddressHeaderView.h"
#import "ConfirmOrderTableViewCell.h"
#import "SupplierCommodityEndity.h"
#import "ShoppingHandler.h"
#import "NSString+Size.h"
#import "PurchaseOrderDetailBottomView.h"
#import "SupplierPayViewController.h"
#import "OrderDetailCountDownManager.h"
#import "PasswordAlertView.h"
#import "PurchaseOrderStatusView.h"
#import "SupplierPayCompleteViewController.h"
#import "FindPwWithUserNameViewController.h"


@interface PurchaseOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PasswordAlertViewDelegate>

@property (nonatomic,strong)BaseTableView        *tb_orderDetail;
@property (nonatomic,strong)AddressHeaderView    *v_header;
@property (nonatomic,strong)PurchaseOrderEntity  *orderEntity;
@property (nonatomic,strong)PurchaseOrderDetailBottomView      *tb_footerView;
@property (nonatomic,strong)UIButton             *btn_pay;
@property (nonatomic,strong)UIButton             *btn_cancel;
@property (nonatomic,strong)UIButton             *btn_confirm;
@property (nonatomic,strong)UIView               *v_bottom;
@property (nonatomic,strong)UILabel              *lab_status;
@property (nonatomic,strong)PurchaseOrderStatusView  *v_purchaseOrderStatus;

@end

@implementation PurchaseOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    [DetailCountDownManager start];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(countDownNotfifcation) name:OrderDetailCountDownNotification object:nil];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)onCreate{
    
    self.tb_orderDetail = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_orderDetail.delegate = self;
    self.tb_orderDetail.dataSource = self;
    self.tb_orderDetail.tableFooterView = [UIView new];
    self.tb_orderDetail.separatorColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_orderDetail.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_orderDetail];
    
    self.tb_footerView = [[PurchaseOrderDetailBottomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    self.tb_orderDetail.tableFooterView = self.tb_footerView;
    [self.tb_footerView.btn_tell addTarget:self action:@selector(btn_tellAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tb_footerView.btn_copy addTarget:self action:@selector(btn_copyAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.v_header = [[AddressHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    [self.v_header.iv_arrow setHidden:YES];
    self.tb_orderDetail.tableHeaderView = self.v_header;
    [self setHeaderUI];
    [self setBottomUI];
    [self loadData];
    
    self.v_purchaseOrderStatus = [[PurchaseOrderStatusView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.v_purchaseOrderStatus setHidden:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self.v_purchaseOrderStatus];
 
}

- (void)setHeaderUI{
    UIView *v_status = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 50)];
    [self.view addSubview:v_status];
    [v_status setBackgroundColor:[UIColor colorWithHexString:@"#616161"]];
    
    UITapGestureRecognizer *v_statusTgp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(v_statusTgp)];
    [v_status addGestureRecognizer:v_statusTgp];
    
    self.lab_status = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
    [v_status addSubview:self.lab_status];
    [self.lab_status setFont:[UIFont boldSystemFontOfSize:16]];
    [self.lab_status setTextColor:[UIColor whiteColor]];
    
    UIImageView *img_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 37, 13, 24, 24)];
    [v_status addSubview:img_arrow];
    [img_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
}

- (void)setBottomUI{
    self.v_bottom = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 46 - SafeAreaBottomHeight, SCREEN_WIDTH, 46)];
    [self.v_bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.v_bottom];
    
    self.btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 46)];
    [self.btn_cancel setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.v_bottom addSubview:self.btn_cancel];
    [self.btn_cancel addTarget:self action:@selector(btn_cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_pay = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 46)];
    [self.btn_pay setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
    [self.btn_pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn_pay.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.v_bottom addSubview:self.btn_pay];
    [self.btn_pay addTarget:self action:@selector(btn_payAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_confirm = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46)];
    [self.btn_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn_confirm setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.btn_confirm setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
    self.btn_confirm.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.v_bottom addSubview:self.btn_confirm];
    [self.btn_confirm addTarget:self action:@selector(btn_confirmAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData{
    [ShoppingHandler selectShopOrderDetailWithOrderId:self.orderId prepare:^{
        [MBProgressHUD showActivityMessageInView:nil];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        self.orderEntity = (PurchaseOrderEntity *)obj;
        [self.v_header contentCellWithAddressEntity:self.orderEntity.address];
        [DetailCountDownManager reload];
        [self.tb_orderDetail reloadData];
        [self.tb_footerView contentViewWithPurchaseOrderEntity:self.orderEntity];
        [self loadBottomData];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)loadBottomData{
    if (self.orderEntity.status == 0) {//(0待付款1待接单2待发货3待收货8已完成9已取消)
        [self.lab_status setText:@"待付款"];
    }else if (self.orderEntity.status == 1){
        [self.lab_status setText:@"待接单"];
    }else if (self.orderEntity.status == 2){
        [self.lab_status setText:@"待发货"];
    }else if (self.orderEntity.status == 3){
        [self.lab_status setText:@"待收货"];
    }else if (self.orderEntity.status == 8){
        [self.lab_status setText:@"已完成"];
    }else if (self.orderEntity.status == 9){
        [self.lab_status setText:@"已关闭"];
    }
    if (self.orderEntity.status == 0 || self.orderEntity.status == 3) {
        [self.v_bottom setHidden:NO];
        if (self.orderEntity.status == 0) {
            [self.btn_confirm setHidden:YES];
            [self.btn_cancel setHidden:NO];
            [self.btn_pay setHidden:NO];
            [self.btn_pay setTitle:[NSString stringWithFormat:@"付款%02zd:%02zd:%02zd",self.orderEntity.countDown/3600,(self.orderEntity.countDown/60)%60,self.orderEntity.countDown%60]    forState:UIControlStateNormal];
        }else if (self.orderEntity.status == 3){
            [self.btn_confirm setHidden:NO];
            [self.btn_cancel setHidden:YES];
            [self.btn_pay setHidden:YES];
        }
        [self.tb_orderDetail setFrame:CGRectMake(0,SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50 - 46)];
    }else{
        [self.v_bottom setHidden:YES];
        [self.tb_orderDetail setFrame:CGRectMake(0,SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50)];
    }
}

- (void)countDownNotfifcation{
    NSInteger countDown = self.orderEntity.countDown - DetailCountDownManager.timeInterval;
    [self.btn_pay setTitle:[NSString stringWithFormat:@"付款%02zd:%02zd:%02zd",countDown/3600,(countDown/60)%60,countDown%60] forState:UIControlStateNormal];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderEntity.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 52;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.orderEntity.status == 0) {
        return 70 + 55;
    }
    return 70;
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
    
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(iv_avatar.right + 10, 10, SCREEN_WIDTH - iv_avatar.right - 42, 42)];
    [lb_title setFont:[UIFont systemFontOfSize:14]];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [v_header addSubview:lb_title];
    
    [iv_avatar sd_setImageWithURL:[NSURL URLWithString:self.orderEntity.logo] placeholderImage:nil];
    [lb_title setText:self.orderEntity.name];
    
    return v_header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,70)];
    [v_footer setBackgroundColor:[UIColor whiteColor]];
    
    UILabel  *lb_yunfei = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 100, 17)];
    [lb_yunfei setText:@"运费"];
    [lb_yunfei setFont:[UIFont systemFontOfSize:12]];
    [lb_yunfei setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [v_footer addSubview:lb_yunfei];
    
    UILabel *lb_yunfeiPrice = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 12, 140, 17)];
    [lb_yunfeiPrice setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [lb_yunfeiPrice setFont:[UIFont systemFontOfSize:12]];
    [lb_yunfeiPrice setText:[NSString stringWithFormat:@"¥%.2f",self.orderEntity.payFreight]];
    [lb_yunfeiPrice setTextAlignment:NSTextAlignmentRight];
    [v_footer addSubview:lb_yunfeiPrice];
    
    UILabel  *lb_priceTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, lb_yunfei.bottom + 8, 100, 20)];
    [lb_priceTitle setTextColor:[UIColor blackColor]];
    [lb_priceTitle setFont:[UIFont systemFontOfSize:14]];
    [lb_priceTitle setText:@"应付"];
    [v_footer addSubview:lb_priceTitle];
    
    UILabel   *lb_price = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, lb_priceTitle.top, 140, lb_priceTitle.height)];
    [lb_price setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [lb_price setFont:[UIFont systemFontOfSize:16]];
    [lb_price setTextAlignment:NSTextAlignmentRight];
    [v_footer addSubview:lb_price];
    [lb_price setText:[NSString stringWithFormat:@"¥%.2f",self.orderEntity.payTotal]];
    
    if (self.orderEntity.status == 0) {
        UIView  *v_line = [[UIView alloc]initWithFrame:CGRectMake(0,70, SCREEN_WIDTH, 10)];
        [v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [v_footer addSubview:v_line];
        
        UIView *v_yue = [[UIView alloc]initWithFrame:CGRectMake(0, v_line.bottom, SCREEN_WIDTH, 46)];
        [v_yue setBackgroundColor:[UIColor whiteColor]];
        [v_footer addSubview:v_yue];
        UILabel *lab_yue = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 46)];
        [lab_yue setFont:[UIFont systemFontOfSize:14]];
        [lab_yue setTextColor:[UIColor colorWithHexString:@"#616161"]];
        NSMutableAttributedString *str_yu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"余额支付(剩余¥%.2f)",self.orderEntity.accountPrice]];
        [str_yu addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
        [lab_yue setAttributedText:str_yu];
        [v_yue addSubview:lab_yue];
        
        if (self.orderEntity.accountPrice < self.orderEntity.payTotal) {
            
            UIButton *btn_chongzhi = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 76, 8, 66, 30)];
            [btn_chongzhi setTitle:@"充值" forState:UIControlStateNormal];
            [btn_chongzhi setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
            [btn_chongzhi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn_chongzhi.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn_chongzhi addTarget:self action:@selector(chongzhiAction) forControlEvents:UIControlEventTouchUpInside];
            [v_yue addSubview:btn_chongzhi];
            
            CGFloat width = [lab_yue.text fittingLabelWidthWithHeight:15 andFontSize:[UIFont systemFontOfSize:14]];
            UILabel *lab_nopay = [[UILabel alloc]initWithFrame:CGRectMake(width + 10 + 5, 0, 60, 46)];
            [lab_nopay setText:@"不足支付"];
            [lab_nopay setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
            [lab_nopay setFont:[UIFont systemFontOfSize:14]];
            [v_yue addSubview:lab_nopay];
        }
    }
    
    return v_footer;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"confirmOrderCell";
    ConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ConfirmOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    SupplierCommodityEndity *entity = [self.orderEntity.items objectAtIndex:indexPath.row];
    [cell contentCellWithSupplierCommodityEndity:entity];
    return cell;
}

- (void)chongzhiAction{
    SupplierPayViewController *vc = [[SupplierPayViewController alloc]init];
    vc.payPrice = [NSString stringWithFormat:@"%.2f",self.orderEntity.payTotal - self.orderEntity.accountPrice];
    [self.navigationController pushViewController:vc animated:YES];
    vc.changAccountPrice = ^(NSString *price) {
        [self loadData];
    };
}

- (void)btn_tellAction{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.orderEntity.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)btn_copyAction{
    [MBProgressHUD showInfoMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",self.orderEntity.orderId];
}

- (void)btn_cancelAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认取消订单?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ShoppingHandler cancelShopOrderDetailWithOrderId:self.orderEntity.orderId prepare:^{
            
        } success:^(id obj) {
            self.orderEntity.status = 9;
            [self loadBottomData];
            if (self.reloadStatus) {
                self.reloadStatus(self.orderEntity);
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:json];
        }];
        
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)v_statusTgp{
    [self.v_purchaseOrderStatus setArr_data:self.orderEntity.flow];
    [self.v_purchaseOrderStatus setHidden:NO];
}

- (void)btn_payAction{
    PasswordAlertView *view = [[PasswordAlertView alloc]initWithPrice:self.orderEntity.payTotal title:@"余额支付" delegate:self];
    [view show];
}

- (void)btn_confirmAction{
    [ShoppingHandler confirmShopOrderDetailWithOrderId:self.orderEntity.orderId prepare:^{
        
    } success:^(id obj) {
        self.orderEntity.status = 8;
        [self loadBottomData];
        if (self.reloadStatus) {
            self.reloadStatus(self.orderEntity);
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma PasswordDelegate
- (void)alertView:(PasswordAlertView *)alertView buttonType:(PasswordAlertBtnType)btnType passwordStr:(NSString *)password{
    if (btnType == PasswordAlertBtnConfirm) {
        
        [ShoppingHandler payOrderWithOrderId:[NSString stringWithFormat:@"%@",self.orderId] passWord:password prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                SupplierPayCompleteViewController *vc = [[SupplierPayCompleteViewController alloc]init];
                vc.price = [NSString stringWithFormat:@"%.2f",self.orderEntity.payTotal];
                [self.navigationController pushViewController:vc animated:YES];
            }else if([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 1){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误，请重试" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    FindPwWithUserNameViewController *vc = [[FindPwWithUserNameViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                UIAlertAction *again = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    PasswordAlertView *view = [[PasswordAlertView alloc]initWithPrice:self.orderEntity.payTotal title:@"余额支付" delegate:self];
                    [view show];
                }];
                [alert addAction:forgetPassword];
                [alert addAction:again];
                [self presentViewController:alert animated:YES completion:nil];
                
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
