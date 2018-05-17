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


@interface PayOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)BaseTableView    *tb_confirmOrder;
@property (nonatomic,strong)AddressHeaderView  *v_header;

@property (nonatomic,strong)UILabel     *lb_allPrice;
@property (nonatomic,strong)UIButton    *btn_payOrder;

@property (nonatomic ,strong)PayInCashCompleteView      *v_zhifuComplete;

@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付订单";
}

- (void)onCreate{
    
    self.tb_confirmOrder = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
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
    
    
    UIView *v_yue = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 50 - 54, SCREEN_WIDTH, 46)];
    UILabel *lab_yue = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 46)];
    [lab_yue setFont:[UIFont systemFontOfSize:14]];
    [lab_yue setTextColor:[UIColor colorWithHexString:@"#616161"]];
    NSMutableAttributedString *str_yu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"余额支付(剩余¥%.2f)",self.accountPrice]];
    [str_yu addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [lab_yue setAttributedText:str_yu];
    
    if (self.accountPrice < self.total) {
        //账户余额 大于 订单金额
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
    
    UIView *v_bottom = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 50, SCREEN_WIDTH, 50)];
    [v_bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:v_bottom];
    
    self.lb_allPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 120, 50)];
    [self.lb_allPrice setFont:[UIFont boldSystemFontOfSize:20]];
    [self.lb_allPrice setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [v_bottom addSubview:self.lb_allPrice];
    double double_allPrice = 0.00;
    for (StoreEntity *selectStoreEntity in self.arr_selectedData) {
        for (SupplierCommodityEndity *selectWareEntity in selectStoreEntity.shoppingCatItems) {
            double_allPrice = double_allPrice + selectWareEntity.price * selectWareEntity.count;
        }
    }
    NSString *str_allPrice = [NSString stringWithFormat:@"合计：￥%.2f",double_allPrice];
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
}

- (void)payOrder{
    
}

- (void)chongzhiAction{
    SupplierPayViewController *vc = [[SupplierPayViewController alloc]init];
    vc.payPrice = [NSString stringWithFormat:@"%.2f",self.total - self.accountPrice];
    [self.navigationController pushViewController:vc animated:YES];
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
    
//    UIImageView *iv_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 15, 19, 24, 24)];
//    [iv_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
//    [v_header addSubview:iv_arrow];
    
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

- (void)zhifucontinueAction{
    //支付成功  返回购物车
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)leftBarAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
