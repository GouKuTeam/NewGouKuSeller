//
//  PayOrderViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PayOrderViewController.h"
#import "ConfirmOrderTableViewCell.h"
#import "AddressHeaderView.h"
#import "StoreEntity.h"
#import "SupplierCommodityEndity.h"
#import "NSString+Size.h"
#import "SupplierPayViewController.h"
#import "PayInCashCompleteView.h"
#import "PasswordAlertView.h"
#import "FindPwWithUserNameViewController.h"
#import "ShoppingHandler.h"
#import "SupplierPayCompleteViewController.h"

@interface PayOrderViewController ()<UITableViewDelegate,UITableViewDataSource,PasswordAlertViewDelegate>

@property (nonatomic,strong)BaseTableView               *tb_confirmOrder;
@property (nonatomic,strong)AddressHeaderView           *v_header;

@property (nonatomic,strong)UILabel                     *lb_allPrice;
@property (nonatomic,strong)UIButton                    *btn_payOrder;

@property (nonatomic ,strong)PayInCashCompleteView      *v_zhifuComplete;
@property (nonatomic ,strong)UIView                     *v_yue;
@property (nonatomic ,strong)UILabel                    *lab_yue;
@property (nonatomic ,strong)UIButton                   *btn_chongzhi;
@property (nonatomic ,strong)UILabel                    *lab_nopay;

@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付订单";
}

- (void)onCreate{
    
    self.tb_confirmOrder = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50 - 62) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_confirmOrder.delegate = self;
    self.tb_confirmOrder.dataSource = self;
    self.tb_confirmOrder.tableFooterView = [UIView new];
    self.tb_confirmOrder.separatorColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_confirmOrder.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_confirmOrder];
    
    self.v_header = [[AddressHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    [self.v_header.iv_arrow setHidden:YES];
    [self.v_header contentCellWithAddressEntity:self.addressEntity];
    self.tb_confirmOrder.tableHeaderView = self.v_header;
    
    [self setUpBottomUI];
    
    self.v_zhifuComplete = [[PayInCashCompleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.v_zhifuComplete.btn_continueShou setTitle:@"完成" forState:UIControlStateNormal];
    [self.v_zhifuComplete.btn_continueShou addTarget:self action:@selector(zhifucontinueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_zhifuComplete.lab_shifu setText:@"支付成功"];
    [self.v_zhifuComplete.lab_zhaoling setText:[NSString stringWithFormat:@"¥%.2f",self.total]];
    [self.view addSubview:self.v_zhifuComplete];
    [self.v_zhifuComplete setHidden:YES];
}

- (void)setUpBottomUI{
    
    self.v_yue = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 50 - 54, SCREEN_WIDTH, 46)];
    [self.v_yue setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.v_yue];
    self.lab_yue = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 46)];
    [self.lab_yue setFont:[UIFont systemFontOfSize:14]];
    [self.lab_yue setTextColor:[UIColor colorWithHexString:@"#616161"]];
    NSMutableAttributedString *str_yu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"余额支付(剩余¥%.2f)",self.accountPrice]];
    [str_yu addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [self.lab_yue setAttributedText:str_yu];
    [self.v_yue addSubview:self.lab_yue];
    
    if (self.accountPrice < self.total) {
        
        self.btn_chongzhi = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 76, 8, 66, 30)];
        [self.btn_chongzhi setTitle:@"充值" forState:UIControlStateNormal];
        [self.btn_chongzhi setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self.btn_chongzhi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_chongzhi.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_chongzhi addTarget:self action:@selector(chongzhiAction) forControlEvents:UIControlEventTouchUpInside];
        [self.v_yue addSubview:self.btn_chongzhi];
        
        CGFloat width = [self.lab_yue.text fittingLabelWidthWithHeight:15 andFontSize:[UIFont systemFontOfSize:14]];
        self.lab_nopay = [[UILabel alloc]initWithFrame:CGRectMake(width + 10 + 5, 0, 60, 46)];
        [self.lab_nopay setText:@"不足支付"];
        [self.lab_nopay setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lab_nopay setFont:[UIFont systemFontOfSize:14]];
        [self.v_yue addSubview:self.lab_nopay];
        
    }
    
    UIView *v_bottom = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 50, SCREEN_WIDTH, 50)];
    [v_bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:v_bottom];
    
    self.lb_allPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 120, 50)];
    [self.lb_allPrice setFont:[UIFont boldSystemFontOfSize:20]];
    [self.lb_allPrice setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [v_bottom addSubview:self.lb_allPrice];

    NSString *str_allPrice = [NSString stringWithFormat:@"合计：￥%.2f",self.total];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_allPrice];
    [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    [self.lb_allPrice setAttributedText:str_amount];
    self.btn_payOrder = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 0, 120, 50)];
    [self.btn_payOrder setTitle:@"去支付" forState:UIControlStateNormal];
    [self.btn_payOrder setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    self.btn_payOrder.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_payOrder addTarget:self action:@selector(payOrder) forControlEvents:UIControlEventTouchUpInside];
    [v_bottom addSubview:self.btn_payOrder];
    
    if (self.accountPrice < self.total) {
        [self.btn_payOrder setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
        self.btn_payOrder.enabled = NO;
    }
}

- (void)payOrder{
    PasswordAlertView *view = [[PasswordAlertView alloc]initWithPrice:self.total title:@"余额支付" delegate:self];
    [view show];
}

- (void)chongzhiAction{
    SupplierPayViewController *vc = [[SupplierPayViewController alloc]init];
    vc.payPrice = [NSString stringWithFormat:@"%.2f",self.total - self.accountPrice];
    [self.navigationController pushViewController:vc animated:YES];
    vc.changAccountPrice = ^(NSString *price) {
        self.accountPrice = self.accountPrice + [price doubleValue];
        [self getResult];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_selectedData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    StoreEntity *storeEntity = [self.arr_selectedData objectAtIndex:section];
    return storeEntity.shoppingCatItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 52;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 42 * 3;
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
    
    StoreEntity *selectStoreEntity = [self.arr_selectedData objectAtIndex:section];
    [iv_avatar sd_setImageWithURL:[NSURL URLWithString:selectStoreEntity.logo] placeholderImage:nil];
    [lb_title setText:selectStoreEntity.name];
    
    return v_header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42 * 3)];
    [v_footer setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lb_yunfeiTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 42)];
    [lb_yunfeiTitle setText:@"运费"];
    [lb_yunfeiTitle setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [lb_yunfeiTitle setTextColor:[UIColor blackColor]];
    [v_footer addSubview:lb_yunfeiTitle];
    
    UILabel *lb_yunfeiPrice = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 210, 0, 200, 42)];
    [lb_yunfeiPrice setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [lb_yunfeiPrice setTextColor:[UIColor blackColor]];
    [lb_yunfeiPrice setTextAlignment:NSTextAlignmentRight];
    [v_footer addSubview:lb_yunfeiPrice];
    
    UILabel *lb_memoTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 42, 48, 42)];
    [lb_memoTitle setText:@"备注"];
    [lb_memoTitle setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [lb_memoTitle setTextColor:[UIColor blackColor]];
    [v_footer addSubview:lb_memoTitle];
    
    UITextField *tf_memo = [[UITextField alloc]initWithFrame:CGRectMake(58, 42, SCREEN_WIDTH - 58 - 10, 42)];
    [tf_memo setEnabled:NO];
    [tf_memo setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [tf_memo setTextColor:[UIColor blackColor]];
    [v_footer addSubview:tf_memo];
    
    UILabel *lb_priceTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 42 * 2, 48, 42)];
    [lb_priceTitle setText:@"合计"];
    [lb_priceTitle setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [lb_priceTitle setTextColor:[UIColor blackColor]];
    [v_footer addSubview:lb_priceTitle];
    
    UILabel *lb_price = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 210, 42 * 2, 200, 42)];
    [lb_price setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [lb_price setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [lb_price setTextAlignment:NSTextAlignmentRight];
    [v_footer addSubview:lb_price];
    
    UIView *v_line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 0.5)];
    [v_line1 setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [v_footer addSubview:v_line1];
    
    UIView *v_line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 42 * 2, SCREEN_WIDTH, 0.5)];
    [v_line2 setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [v_footer addSubview:v_line2];
    
    StoreEntity *selectStoreEntity = [self.arr_selectedData objectAtIndex:section];
    double sectionAmount = 0.00;
    for (SupplierCommodityEndity *entity in selectStoreEntity.shoppingCatItems) {
        sectionAmount = sectionAmount + entity.count * entity.price;
    }
    lb_price.text = [NSString stringWithFormat:@"￥%.2f",sectionAmount];
    lb_yunfeiPrice.text = [NSString stringWithFormat:@"￥%.2f",selectStoreEntity.freightPrice];
    tf_memo.text = selectStoreEntity.remark;
    
    return v_footer;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"confirmOrderCell";
    ConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ConfirmOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    StoreEntity *storeEntity = [self.arr_selectedData objectAtIndex:indexPath.section];
    SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:indexPath.row];
    [cell contentCellWithSupplierCommodityEndity:wareEntity];
    return cell;
}

#pragma PasswordDelegate
- (void)alertView:(PasswordAlertView *)alertView buttonType:(PasswordAlertBtnType)btnType passwordStr:(NSString *)password{
    if (btnType == PasswordAlertBtnConfirm) {
        
        [ShoppingHandler payMoreOrderWithOrderId:self.arr_orderId passWord:password prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                SupplierPayCompleteViewController *vc = [[SupplierPayCompleteViewController alloc]init];
                vc.price = [NSString stringWithFormat:@"%.2f",self.total];
                [self.navigationController pushViewController:vc animated:YES];
            }else if([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 1){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误，请重试" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    FindPwWithUserNameViewController *vc = [[FindPwWithUserNameViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                UIAlertAction *again = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    PasswordAlertView *view = [[PasswordAlertView alloc]initWithPrice:self.total title:@"余额支付" delegate:self];
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
        }];
    }
}


- (void)getResult{
    if (self.accountPrice > self.total) {
        NSMutableAttributedString *str_yu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"余额支付(剩余¥%.2f)",self.accountPrice]];
        [str_yu addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
        [self.lab_yue setAttributedText:str_yu];
        [self.btn_chongzhi setHidden:YES];
        [self.lab_nopay setHidden:YES];
        [self.btn_payOrder setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
        self.btn_payOrder.enabled = YES;
    }
}

- (void)zhifucontinueAction{
    //支付成功  返回购物车
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)leftBarAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
