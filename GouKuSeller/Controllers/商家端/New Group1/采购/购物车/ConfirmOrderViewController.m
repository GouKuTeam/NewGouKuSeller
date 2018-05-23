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
#import "PayOrderViewController.h"
#import "ShoppingHandler.h"
#import "EditAddressViewController.h"
#import "AddressNullView.h"

@interface ConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)BaseTableView      *tb_confirmOrder;
@property (nonatomic,strong)AddressHeaderView  *v_header;
@property (nonatomic,strong)AddressNullView    *addressNullView;

@property (nonatomic,strong)UILabel     *lb_allPrice;
@property (nonatomic,strong)UIButton    *btn_confirmOrder;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交订单";
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
    [self.v_header contentCellWithAddressEntity:self.addressEntity];
    if (self.addressEntity.name.length > 0) {
        self.tb_confirmOrder.tableHeaderView = self.v_header;
    }else{
        self.addressNullView = [[AddressNullView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [self.addressNullView.btn_gotoAddress addTarget:self action:@selector(addressTgpAction) forControlEvents:UIControlEventTouchUpInside];
        self.tb_confirmOrder.tableHeaderView = self.addressNullView;
    }
    UITapGestureRecognizer *addressTgp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressTgpAction)];
    [self.v_header addGestureRecognizer:addressTgp];

    [self setUpBottomUI];
}

- (void)setUpBottomUI{
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
    self.btn_confirmOrder = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 0, 120, 50)];
    [self.btn_confirmOrder setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.btn_confirmOrder setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    self.btn_confirmOrder.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_confirmOrder addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
    [v_bottom addSubview:self.btn_confirmOrder];
}

- (void)confirmOrder{
    if (self.tb_confirmOrder.tableHeaderView == self.addressNullView) {
        [MBProgressHUD showErrorMessage:@"请选择收货地址"];
        return;
    }
    NSMutableArray *arr_items = [NSMutableArray array];
    NSMutableArray *arr_remark = [NSMutableArray array];
    for (StoreEntity *storeEntity in self.arr_selectedData) {
        if (storeEntity.remark.length > 0) {
            [arr_remark addObject:@{@"shopId":storeEntity.shopId,@"remark":storeEntity.remark}];
        }
        for (SupplierCommodityEndity *entity in storeEntity.shoppingCatItems) {
            if ([entity.skuUnitId intValue] > 0) {
                [arr_items addObject:@{@"skuId":entity.skuId,@"skuUnitId":entity.skuUnitId}];
            }else{
                [arr_items addObject:@{@"skuId":entity.skuId}];
            }
        }
    }
    [ShoppingHandler generateNewOrderWithReceiver:self.addressEntity.name address:self.addressEntity.address phone:self.addressEntity.phone items:arr_items remarks:arr_remark prepare:^{
        [MBProgressHUD showActivityMessageInView:@"正在提交订单"];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        NSMutableArray *arr_orderId = [(NSDictionary *)obj objectForKey:@"orderList"];
        NSMutableArray *arr_data = [NSMutableArray array];
        for (NSDictionary *dic in arr_orderId) {
            [arr_data addObject:[dic objectForKey:@"orderId"]];
        }
        PayOrderViewController *vc = [[PayOrderViewController alloc]init];
        vc.addressEntity = self.addressEntity;
        vc.arr_selectedData = self.arr_selectedData;
        vc.arr_orderId = arr_data;
        vc.total = [[(NSDictionary *)obj objectForKey:@"total"] doubleValue];
        vc.accountPrice = [[(NSDictionary *)obj objectForKey:@"accountPrice"] doubleValue];
        [self.navigationController pushViewController:vc animated:YES];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
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
    [tf_memo setPlaceholder:@"请填写备注"];
    [tf_memo setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
    [tf_memo setTextColor:[UIColor blackColor]];
    tf_memo.delegate = self;
    tf_memo.tag = section;
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    StoreEntity *storeEntity = [self.arr_selectedData objectAtIndex:textField.tag];
    storeEntity.remark = textField.text;
    [self.arr_selectedData replaceObjectAtIndex:textField.tag withObject:storeEntity];
}

- (void)addressTgpAction{
    EditAddressViewController *vc = [[EditAddressViewController alloc]init];
    vc.addressEnterFromType = AddressEnterFromConfirmOrder;
    [self.navigationController pushViewController:vc animated:YES];
    vc.selectAddressComplete = ^(AddressEntity *addressEntity) {
        [self.v_header contentCellWithAddressEntity:addressEntity];
        self.tb_confirmOrder.tableHeaderView = self.v_header;
    };
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
