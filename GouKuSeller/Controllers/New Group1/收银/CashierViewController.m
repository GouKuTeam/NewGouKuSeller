//
//  CashierViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CashierViewController.h"
#import "CashierTableViewCell.h"
#import "CashierBottomView.h"
#import "TitleView.h"
#import "TitleClear.h"
#import "CashierHandler.h"
#import "CashierCommodityEntity.h"
#import "PayInCashViewController.h"
#import "PayInGouKuViewController.h"
#import "ChangeCommodirtyCountAlertView.h"
#import "SettlementHandler.h"
#import "IQKeyboardManager.h"
#import "PayInGouKuViewController.h"
#import "AddPriceViewController.h"
#import "CommonAlertView.h"
#import "PayWaitView.h"
#import "PayInCashCompleteView.h"

@interface CashierViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,TextViewClickReturnDelegate,TextFieldClickReturnDelegate,CommonAlertViewDelegate>
@property (nonatomic, strong)UITextField         *tfsousuo;
@property (nonatomic, strong)UITableView         *tb_commodityList;
@property (nonatomic, strong)NSMutableArray      *arr_commodityList;
@property (nonatomic ,strong)CashierBottomView   *v_cashierBottom;

@property (nonatomic ,assign)BOOL                 keyboardIsVisible;

@property (nonatomic ,strong)TitleView           *titleView;
@property (nonatomic ,strong)TitleClear          *titleClearView;

@property (nonatomic ,assign)double               totalPrice;     //总计金额
@property (nonatomic ,assign)double               discountPrice;  //优惠金额
@property (nonatomic ,strong)ChangeCommodirtyCountAlertView *alert;

@property (nonatomic ,assign)double               noGoods;        //无码商品
@property (nonatomic ,assign)double               manjianPrice;     //满减金额
@property (nonatomic ,strong)NSString             *zhekou;      //折扣数值
@property (nonatomic ,assign)double               orderDiscount;  //整单折扣金额
@property (nonatomic ,assign)double               orderMinus;     //整单减价

@property (nonatomic        )BOOL                 mofenAction; //抹分操作
@property (nonatomic        )BOOL                 mojiaoAction; //抹角操作
@property (nonatomic ,assign)double               loseSmallReduce;        //去零金额
@property (nonatomic ,strong)NSNumber            *actId;             //整单活动id
@property (nonatomic ,strong)NSString            *userFukuanma;     // 用户付款吗

@property (nonatomic ,strong)PayWaitView      *v_wait;
@property (nonatomic ,strong)PayInCashCompleteView      *v_cashComplete;


@end

@implementation CashierViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_commodityList = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"收银";
    
    UIButton *btn_shouyin = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [btn_shouyin setTitle:@"收银" forState:UIControlStateNormal];
    [btn_shouyin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_shouyin setImage:[UIImage imageNamed:@"triangle_down_white"] forState:UIControlStateNormal];
    [btn_shouyin setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn_shouyin.imageView.frame.size.width, 0, btn_shouyin.imageView.frame.size.width)];
    [btn_shouyin setImageEdgeInsets:UIEdgeInsetsMake(0, btn_shouyin.titleLabel.bounds.size.width + 10, 0, -btn_shouyin.titleLabel.bounds.size.width)];
    [btn_shouyin addTarget:self action:@selector(btnshouyinAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn_shouyin;
    
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"more"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NocatifionCashierAction) name:@"ClearShoppingCar" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NocatifioncashcompleteAction) name:@"cashcomplete" object:nil];
    
    
    self.v_wait = [[PayWaitView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:self.v_wait];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.v_wait] ;
    [self.v_wait.btn_back addTarget:self action:@selector(btn_backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_wait setHidden:YES];

    self.v_cashComplete = [[PayInCashCompleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.v_cashComplete.btn_continueShou addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_cashComplete.lab_shifu setText:@"收款成功"];
    [self.v_cashComplete.lab_zhaoling setText:@""];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.v_cashComplete];
    [self.v_cashComplete setHidden:YES];
    
}

- (void)onCreate{
    
    self.tfsousuo = [[UITextField alloc]initWithFrame:CGRectMake(10, 10 + SafeAreaTopHeight, SCREEN_WIDTH - 20, 32)];
    [self.view addSubview:self.tfsousuo];
    [self.tfsousuo setBackgroundColor:[UIColor whiteColor]];
    self.tfsousuo.font = [UIFont systemFontOfSize:14];
    [self.tfsousuo setPlaceholder:@"输入商品条形码"];
    self.tfsousuo.delegate = self;
    self.tfsousuo.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.tfsousuo.returnKeyType = UIReturnKeySearch;
    self.tfsousuo.leftView  = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 11.f, 0.f)];
    self.tfsousuo.leftViewMode = UITextFieldViewModeAlways;
    [self.tfsousuo becomeFirstResponder];
    
    self.v_cashierBottom = [[CashierBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 104 - SafeAreaBottomHeight, SCREEN_WIDTH, 104)];
    [self.view addSubview:self.v_cashierBottom];
    [self.v_cashierBottom.btn_cashPayment addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];

    
    self.tb_commodityList = [[UITableView alloc]initWithFrame:CGRectMake(0, 50 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - SafeAreaTopHeight - 104 - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_commodityList];
    self.tb_commodityList.delegate = self;
    self.tb_commodityList.dataSource = self;
    self.tb_commodityList.tableFooterView = [UIView new];

    
    self.titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight)];
    [self.view addSubview:self.titleView];
    [self.titleView.btn_addPrice addTarget:self action:@selector(titleViewbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView.btn_zhekou addTarget:self action:@selector(titleViewbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView.btn_jianjia addTarget:self action:@selector(titleViewbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView.btn_mofen addTarget:self action:@selector(titleViewbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView.btn_mojiao addTarget:self action:@selector(titleViewbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView setHidden:YES];
    UITapGestureRecognizer *tgp_titleview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleViewDissMiss)];
    [self.titleView addGestureRecognizer:tgp_titleview];
    
    self.titleClearView = [[TitleClear alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight)];
    [self.view addSubview:self.titleClearView];
    [self.titleClearView.btn_clear addTarget:self action:@selector(cashierAction) forControlEvents:UIControlEventTouchUpInside];
    [self.titleClearView setHidden:YES];
    UITapGestureRecognizer *tgp_titleClearview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tgp_titleClearviewDissMiss)];
    [self.titleClearView addGestureRecognizer:tgp_titleClearview];
    
    self.totalPrice = 0;
    self.discountPrice = 0;
    self.manjianPrice = 0;
    self.zhekou = @"0";
    self.orderDiscount = 0;
    self.orderMinus = 0;
    self.loseSmallReduce = 0;
    self.mofenAction = NO;
    self.mojiaoAction = NO;
    [self getResultAction];
    
    //6936952326
    
}

- (void)cashierAction{
    
    [self.arr_commodityList removeAllObjects];
    self.totalPrice = 0;
    self.discountPrice = 0;
    self.manjianPrice = 0;
    self.zhekou = @"0";
    self.orderDiscount = 0;
    self.orderMinus = 0;
    self.loseSmallReduce = 0;
    self.mofenAction = NO;
    self.mojiaoAction = NO;
    [self.tb_commodityList reloadData];
    [self getResultAction];
    [self.titleClearView setHidden:!self.titleClearView.isHidden];
    
}
- (void)NocatifionCashierAction{
    
    [self.arr_commodityList removeAllObjects];
    self.totalPrice = 0;
    self.discountPrice = 0;
    self.manjianPrice = 0;
    self.zhekou = @"0";
    self.orderDiscount = 0;
    self.orderMinus = 0;
    self.loseSmallReduce = 0;
    self.mofenAction = NO;
    self.mojiaoAction = NO;
    [self.tb_commodityList reloadData];
    [self getResultAction];
    
}

- (void)payAction:(UIButton *)btn{
    if (self.arr_commodityList.count == 0) {
        [MBProgressHUD showInfoMessage:@"请添加商品"];
        return;
    }else{
        if (btn == self.v_cashierBottom.btn_cashPayment) {
            // 现金支付   先网络请求提交订单
            NSMutableArray *arrItem = [[NSMutableArray alloc]init];
            for (int i = 0; i < self.arr_commodityList.count; i ++) {
                CashierCommodityEntity *entity = [self.arr_commodityList objectAtIndex:i];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                if (![entity.name isEqualToString:@"无码商品"]) {
                    [dic setObject:entity.name forKey:@"name"];
                    [dic setObject:entity.skuId forKey:@"skuId"];
                    [dic setObject:[NSNumber numberWithDouble:entity.price] forKey:@"price"];
                    [dic setObject:[NSNumber numberWithDouble:entity.amount] forKey:@"amount"];
                    [dic setObject:[NSNumber numberWithDouble:entity.price - entity.settlementPrice] forKey:@"pricePreferential"];
                    [dic setObject:entity.standards forKey:@"standards"];
                    if (entity.itemActId) {
                        [dic setObject:entity.itemActId forKey:@"itemActId"];
                    }
                    [arrItem addObject:dic];
                }
            }
            [CashierHandler addOrderWithShopId:[LoginStorage GetShopId] items:arrItem payTotal:[NSString stringWithFormat:@"%.2f",self.totalPrice + self.discountPrice] payReduce:[NSString stringWithFormat:@"%.2f",self.discountPrice] payActual:[NSString stringWithFormat:@"%.2f",self.totalPrice] noGoods:[NSString stringWithFormat:@"%.2f",self.noGoods] payType:2 orderDiscount:[NSString stringWithFormat:@"%.2f",self.orderDiscount] orderMinus:[NSString stringWithFormat:@"%.2f",self.orderMinus] loseSmallReduce:[NSString stringWithFormat:@"%.2f",self.loseSmallReduce] prepare:^{
                
            } success:^(id obj) {
                if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0){
                    PayInCashViewController *vc = [[PayInCashViewController alloc]init];
                    vc.totalPrice = self.totalPrice;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 1){
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下列商品已下架或不存在，不能购买" message:[(NSDictionary *)obj objectForKey:@"errMessage"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:sure];
                    [self presentViewController:alert animated:YES completion:nil];
                }else if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 3){
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下列商品价格发生了变化" message:[(NSDictionary *)obj objectForKey:@"errMessage"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"刷新价格" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //重新刷新tableview
                        [self.arr_commodityList removeAllObjects];
                        NSArray *arr = [CashierCommodityEntity parseStandardListWithJson:[(NSDictionary *)obj objectForKey:@"data"]];
                        [self.arr_commodityList addObject:arr];
                        [self.tb_commodityList reloadData];
                        [self getResultAction];
                        
                    }];
                    [alert addAction:sure];
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
}

-(void)btnshouyinAction{
    [self.titleClearView setHidden:!self.titleClearView.isHidden];
    if (self.titleView.hidden == NO) {
        
        [self.titleView setHidden:!self.titleView.isHidden];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField);
    if (textField.text.length < 17) {
        // 商品条码
        [CashierHandler commodityCashierWithBarcode:textField.text shopId:[LoginStorage GetShopId] addup:self.totalPrice prepare:^{
        } success:^(id obj) {
            
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0 ) {
                CashierCommodityEntity *entity = [CashierCommodityEntity parseStandardEntityWithJson:[(NSDictionary *)obj objectForKey:@"data"]];
                CashierCommodityEntity *demoEntity = [[CashierCommodityEntity alloc]init];
                int index = 0;
                for (int i = 0; i < self.arr_commodityList.count; i++) {
                    CashierCommodityEntity *caseEntity = [self.arr_commodityList objectAtIndex:i];
                    if ([caseEntity.barcode longValue] == [entity.barcode longValue]) {
                        demoEntity = caseEntity;
                        index = i;
                    }
                }
                if ([demoEntity.barcode longValue] != 0) {
                    demoEntity.amount = demoEntity.amount + 1;
                    [self.arr_commodityList replaceObjectAtIndex:index withObject:demoEntity];
                }else{
                    [self.arr_commodityList addObject:entity];
                }
                self.actId = entity.actId;
                self.manjianPrice = entity.payMinus;
                self.tfsousuo.text = @"";
                [self.tfsousuo becomeFirstResponder];
                [self.tb_commodityList reloadData];
                [self getResultAction];
            }else{
                self.tfsousuo.text = @"";
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
                
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
            self.tfsousuo.text = @"";
        }];
    }else{
        // 用户付款吗  先去下单  下单成功后上传付款吗 上传成功直接进入等待付款界面
        self.userFukuanma = textField.text;
        self.tfsousuo.text = @"";
        //购酷支付   先网络请求提交订单
        NSMutableArray *arrItem = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.arr_commodityList.count; i ++) {
            CashierCommodityEntity *entity = [self.arr_commodityList objectAtIndex:i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (![entity.name isEqualToString:@"无码商品"]) {
                [dic setObject:entity.name forKey:@"name"];
                [dic setObject:entity.skuId forKey:@"skuId"];
                [dic setObject:[NSNumber numberWithDouble:entity.price] forKey:@"price"];
                [dic setObject:[NSNumber numberWithDouble:entity.amount] forKey:@"amount"];
                [dic setObject:[NSNumber numberWithDouble:entity.price - entity.settlementPrice] forKey:@"pricePreferential"];
                [dic setObject:entity.standards forKey:@"standards"];
                if (entity.itemActId) {
                    [dic setObject:entity.itemActId forKey:@"itemActId"];
                }
                [arrItem addObject:dic];
            }
        }
        [CashierHandler addOrderWithShopId:[LoginStorage GetShopId] items:arrItem payTotal:[NSString stringWithFormat:@"%.2f",self.totalPrice + self.discountPrice] payReduce:[NSString stringWithFormat:@"%.2f",self.discountPrice] payActual:[NSString stringWithFormat:@"%.2f",self.totalPrice] noGoods:[NSString stringWithFormat:@"%.2f",self.noGoods] payType:1 orderDiscount:[NSString stringWithFormat:@"%.2f",self.orderDiscount] orderMinus:[NSString stringWithFormat:@"%.2f",self.orderMinus] loseSmallReduce:[NSString stringWithFormat:@"%.2f",self.loseSmallReduce] prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0){
                NSString *orderId = [(NSDictionary *)obj objectForKey:@"data"];
               //下单成功  上传用户付款吗
                [CashierHandler scanUserCashCodeWithOpenId:self.userFukuanma orderId:orderId prepare:^{
                    
                } success:^(id obj) {
                    //扫描成功  显示等待支付界面                    
                    [self.v_wait setHidden:NO];
//                    [self.v_cashComplete setHidden:YES];
                } failed:^(NSInteger statusCode, id json) {
                    [MBProgressHUD showErrorMessage:(NSString *)json];
                }];
                
            }else if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 1){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下列商品已下架或不存在，不能购买" message:[(NSDictionary *)obj objectForKey:@"errMessage"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:sure];
                [self presentViewController:alert animated:YES completion:nil];
            }else if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 3){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下列商品价格发生了变化" message:[(NSDictionary *)obj objectForKey:@"errMessage"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"刷新价格" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //重新刷新tableview
                    [self.arr_commodityList removeAllObjects];
                    NSArray *arr = [CashierCommodityEntity parseStandardListWithJson:[(NSDictionary *)obj objectForKey:@"data"]];
                    [self.arr_commodityList addObject:arr];
                    [self.tb_commodityList reloadData];
                    [self getResultAction];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:sure];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CashierCommodityEntity *entity = [self.arr_commodityList objectAtIndex:indexPath.row];
    if (entity.price > entity.settlementPrice) {
        return 58;
    }else{
        return 49;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_commodityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"BankCardTableViewCell";
    CashierTableViewCell *cell = (CashierTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[CashierTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CashierCommodityEntity *entity = [self.arr_commodityList objectAtIndex:indexPath.row];
    [cell contentWithCashierCommodity:entity];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tfsousuo resignFirstResponder];
    CashierCommodityEntity *entity = [self.arr_commodityList objectAtIndex:indexPath.row];
    if (![entity.name isEqualToString:@"无码商品"]) {
        self.alert = [[ChangeCommodirtyCountAlertView alloc]initWithName:entity.name commodirtyCount:entity.amount];
        [self.alert show];
        self.alert.btn_delete.tag = indexPath.row;
        [self.alert.btn_delete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        self.alert.dismissAlertView = ^(int count) {
            if (count > 0) {
                entity.amount = count;
                [weakSelf.arr_commodityList replaceObjectAtIndex:indexPath.row withObject:entity];
                [weakSelf.tb_commodityList reloadData];
                [weakSelf getResultAction];
            }
        };
    }
}

- (void)deleteAction:(UIButton *)btn_sender{
    [self.alert dismiss];
    [self.arr_commodityList removeObjectAtIndex:btn_sender.tag];
    [self.tb_commodityList reloadData];
    [self getResultAction];
}

- (void)getResultAction{
    CGFloat totalPrice = 0;
    CGFloat youhuiPrice = 0;
    for (CashierCommodityEntity *entity in self.arr_commodityList) {
        totalPrice = totalPrice + entity.settlementPrice * entity.amount;
        youhuiPrice = youhuiPrice + (entity.price - entity.settlementPrice) * entity.amount;
    }
//    //折扣金额
    if ([self.zhekou doubleValue] > 0) {
        self.orderDiscount = totalPrice - totalPrice * ([self.zhekou doubleValue] / 10);
    }else{
        self.orderDiscount = 0;
    }
    CGFloat  now_total = totalPrice - self.manjianPrice - self.orderDiscount - self.orderMinus ;
    
    //    抹分操作/抹角操作
    if (self.mofenAction == YES) {
        NSLog(@"抹分操作");
        NSMutableString *str_total = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%.2f",now_total]];
        NSString *loseSmallReduce = [NSString stringWithFormat:@"0.0%d",[[str_total substringFromIndex:str_total.length - 1] intValue]];
        self.loseSmallReduce = [loseSmallReduce doubleValue];
    }
    if (self.mojiaoAction == YES) {
        NSLog(@"抹角操作");
        NSMutableString *str_total = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%.2f",now_total]];
        NSString *loseSmallReduce = [NSString stringWithFormat:@"0.%d",[[str_total substringFromIndex:str_total.length - 2] intValue]];
        self.loseSmallReduce = [loseSmallReduce doubleValue];
    }
    //优惠金额
    self.discountPrice = youhuiPrice + self.manjianPrice + self.orderDiscount + self.orderMinus + self.loseSmallReduce;
    //应付金额
    self.totalPrice = now_total - self.loseSmallReduce;
    
    [self.v_cashierBottom.lab_manjianPrice setText:[NSString stringWithFormat:@"-¥%.2f",self.manjianPrice]];
    [self.v_cashierBottom.lab_zhekou setText:[NSString stringWithFormat:@"整单%@折：",self.zhekou]];
    [self.v_cashierBottom.lab_zhekouPrice setText:[NSString stringWithFormat:@"-¥%.2f",self.orderDiscount]];
    [self.v_cashierBottom.lab_jianjiaPrice setText:[NSString stringWithFormat:@"-¥%.2f",self.orderMinus]];
    [self.v_cashierBottom.lab_molingPrice setText:[NSString stringWithFormat:@"-¥%.2f",self.loseSmallReduce]];
    [self.v_cashierBottom.price_zhifu setText:[NSString stringWithFormat:@"¥%.2f",self.totalPrice]];
    [self.v_cashierBottom.price_youhui setText:[NSString stringWithFormat:@"已优惠¥%.2f",self.discountPrice]];
    
}

- (void)rightBarAction{
    [self.titleView setHidden:!self.titleView.isHidden];
    if (self.titleClearView.hidden == NO) {
        [self.titleClearView setHidden:!self.titleClearView.isHidden];
    }
}

- (void)titleViewbtnAction:(UIButton *)btn{
    
    [self.titleView setHidden:!self.titleView.isHidden];
    if (btn == self.titleView.btn_addPrice) {
        CommonAlertView *view = [[CommonAlertView alloc]initWithTitleType:@"添加金额" delegate:self];
        [view show];
    }
    if (btn == self.titleView.btn_zhekou) {
        CommonAlertView *view = [[CommonAlertView alloc]initWithTitleType:@"整单折扣" delegate:self];
        [view show];
    }
    if (btn == self.titleView.btn_jianjia) {
        CommonAlertView *view = [[CommonAlertView alloc]initWithTitleType:@"整单减价" delegate:self];
        [view show];
    }
    if (btn == self.titleView.btn_mofen) {
        self.mofenAction = YES;
        self.mojiaoAction = NO;
        [self getResultAction];
    }
    if (btn == self.titleView.btn_mojiao) {
        self.mojiaoAction = YES;
        self.mofenAction = NO;
        [self getResultAction];
    }
}

#pragma CommonAlertDelegate
- (void)alertView:(CommonAlertView *)alertView buttonType:(CommonAlertBtnType)btnType textFiledText:(NSString *)text{
    if ([alertView.title_type isEqualToString:@"整单折扣"]) {
        if (btnType == CommonAlertBtnConfirm) {
            self.zhekou = text;
            [self getResultAction];
        }
    }
    if ([alertView.title_type isEqualToString:@"整单减价"]) {
        if (btnType == CommonAlertBtnConfirm) {
            self.orderMinus = [text intValue];
            [self getResultAction];
        }
    }
    if ([alertView.title_type isEqualToString:@"添加金额"]) {
        if (btnType == CommonAlertBtnConfirm) {
            self.noGoods = [text doubleValue];
            CashierCommodityEntity *caseEntity = [[CashierCommodityEntity alloc]init];
            if (self.arr_commodityList.count > 0) {
                caseEntity = [self.arr_commodityList objectAtIndex:0];
            }
            if ([caseEntity.barcode intValue] == 0 && self.arr_commodityList.count > 0) {
                caseEntity.settlementPrice = caseEntity.settlementPrice + [text doubleValue];
                caseEntity.price = caseEntity.price + [text doubleValue];
                [self.arr_commodityList replaceObjectAtIndex:0 withObject:caseEntity];
            }else{
                CashierCommodityEntity *entity = [[CashierCommodityEntity alloc]init];
                entity.name = @"无码商品";
                entity.settlementPrice = [text doubleValue];
                entity.price = [text doubleValue];
                entity.amount = 1;
                [self.arr_commodityList insertObject:entity atIndex:0];
            }
            [self.tb_commodityList reloadData];
            [self getResultAction];
        }
    }
}

//- (void)tgpAction{
//    [self.tfsousuo resignFirstResponder];
//}

- (void)btn_backAction{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ClearShoppingCar" object:nil userInfo:nil];
    [self.v_wait setHidden:YES];

}

- (void)continueAction{
    //收款完成  发送通知  回到购物车页面  并清空购物车
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ClearShoppingCar" object:nil userInfo:nil];
    [self.v_cashComplete setHidden:YES];
}

- (void)NocatifioncashcompleteAction{
    [self.v_wait setHidden:YES];
    [self.v_cashComplete setHidden:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tfsousuo resignFirstResponder];
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

- (void)titleViewDissMiss{
    [self.titleView setHidden:YES];
    [self.tfsousuo resignFirstResponder];
}

- (void)tgp_titleClearviewDissMiss{
    [self.titleClearView setHidden:YES];
    [self.tfsousuo resignFirstResponder];
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
