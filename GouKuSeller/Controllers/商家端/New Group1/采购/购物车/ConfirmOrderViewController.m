//
//  ConfirmOrderViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmOrderTableViewCell.h"
#import "AddressHeaderView.h"
#import "StoreEntity.h"
#import "SupplierCommodityEndity.h"

@interface ConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)BaseTableView    *tb_confirmOrder;
@property (nonatomic,strong)AddressHeaderView  *v_header;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交订单";
}

- (void)onCreate{
    
    self.tb_confirmOrder = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    self.tb_confirmOrder.delegate = self;
    self.tb_confirmOrder.dataSource = self;
    self.tb_confirmOrder.tableFooterView = [UIView new];
    self.tb_confirmOrder.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_confirmOrder];
    
    self.v_header = [[AddressHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    self.tb_confirmOrder.tableHeaderView = self.v_header;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_selectedData.count;
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
    iv_avatar.contentMode = UIViewContentModeScaleAspectFill;
    [v_header addSubview:iv_avatar];
    
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(iv_avatar.right + 10, 10, SCREEN_WIDTH - iv_avatar.right - 42, 42)];
    [lb_title setFont:[UIFont systemFontOfSize:14]];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [v_header addSubview:lb_title];
    
    UIImageView *iv_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 8, 14.5 + 10, 13, 13)];
    [iv_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
    [v_header addSubview:iv_arrow];
    
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
    [tf_memo setPlaceholder:@"请填写备注"];
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

@end
