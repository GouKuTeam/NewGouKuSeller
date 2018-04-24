//
//  AddActiveViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddActiveViewController.h"
#import "ActiveInformation.h"
#import "LYLOptionPicker.h"
#import "LYLDatePicker.h"
#import "ActiveZhouViewController.h"
#import "ActiveTimeViewController.h"
#import "ManjianTableViewCell.h"
#import "SingleSalesTableViewCell.h"
#import "CommodityViewController.h"
#import "ActiveHandler.h"
#import "SelectAcTiveTypeViewController.h"

@interface AddActiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)ActiveInformation        *v_ainformation;
@property (nonatomic ,strong)UIView                   *v_tabHeader;
@property (nonatomic ,strong)UIButton                 *btn_tabFooter;
@property (nonatomic ,strong)UILabel                  *lab_tabHeaderTitle;
@property (nonatomic ,strong)NSMutableArray           *arr_week;
@property (nonatomic ,strong)NSMutableArray           *arr_time;
@property (nonatomic ,strong)UITableView              *tb_active;
@property (nonatomic ,strong)NSMutableArray           *arr_active;

@end

@implementation AddActiveViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_active = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"新建%@",self.titleType];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    self.v_tabHeader = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 273)];
    self.v_tabHeader.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.v_ainformation = [[ActiveInformation alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 220)];
    [self.v_tabHeader addSubview:self.v_ainformation];
    self.lab_tabHeaderTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 246, SCREEN_WIDTH - 15, 20)];
    [self.v_tabHeader addSubview:self.lab_tabHeaderTitle];
    [self.lab_tabHeaderTitle setText:@"活动商品"];
    [self.lab_tabHeaderTitle setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [self.lab_tabHeaderTitle setFont:[UIFont systemFontOfSize:14]];
    
    self.btn_tabFooter = [[UIButton alloc]initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, 44)];
    [self.btn_tabFooter setBackgroundColor:[UIColor whiteColor]];
    if (self.activeType == ActiceFormManJian) {
        [self.btn_tabFooter setTitle:@"添加规则" forState: UIControlStateNormal];
    }else{
        [self.btn_tabFooter setTitle:@"添加商品" forState: UIControlStateNormal];
    }
    [self.btn_tabFooter setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    self.btn_tabFooter.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_tabFooter setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.btn_tabFooter setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0.0, 0.0)];
    [self.btn_tabFooter addTarget:self action:@selector(btn_addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_tabFooter setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.btn_tabFooter.contentEdgeInsets = UIEdgeInsetsMake(0,17, 0, 0);
    
    [self.v_ainformation.btn_beginTime addTarget:self action:@selector(beginTimeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_ainformation.btn_endTime addTarget:self action:@selector(endTimeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_ainformation.btn_activeZhou addTarget:self action:@selector(activeZhouAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_ainformation.btn_activeTime addTarget:self action:@selector(activeTime) forControlEvents:UIControlEventTouchUpInside];
    
    self.tb_active = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight- SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_active];
    self.tb_active.delegate = self;
    self.tb_active.dataSource = self;
    self.tb_active.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_active.tableHeaderView = self.v_tabHeader;
    self.tb_active.tableFooterView = self.btn_tabFooter;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.activeType == ActiceFormManJian) {
        return 50;
    }else{
        return 84;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_active.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.activeType == ActiceFormManJian) {
        static NSString *CellIdentifier = @"MainJianTableViewCell";
        ManjianTableViewCell *cell = (ManjianTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[ManjianTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.btn_delete.tag = indexPath.row;
        [cell.btn_delete addTarget:self action:@selector(activeDelete:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *dic = [self.arr_active objectAtIndex:indexPath.row];
        cell.tf_man.text = [dic objectForKey:@"price"];
        cell.tf_jian.text = [dic objectForKey:@"minusPrice"];
        return cell;
    }else{
        static NSString *CellIdentifier = @"OtherTableViewCell";
        SingleSalesTableViewCell *cell = (SingleSalesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[SingleSalesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.btn_delete.tag = indexPath.row;
        [cell.btn_delete addTarget:self action:@selector(activeDelete:) forControlEvents:UIControlEventTouchUpInside];
        CommodityFromCodeEntity *entity = [self.arr_active objectAtIndex:indexPath.row];
        cell.lab_commodityName.text = entity.name;
        cell.lab_yuanjia.text = [NSString stringWithFormat:@"原价¥%.2f",[entity.price doubleValue]];
        cell.lab_ze.text = @"";
        if (self.activeType == ActiceFormTeJia) {
            cell.lab_youhui.text = @"优惠价¥";
        }else if (self.activeType == ActiceFormZheKou){
            cell.lab_youhui.text = @"优惠折扣¥";
            cell.lab_ze.text = @"  折";
        }else if (self.activeType == ActiceFormJianJia){
            cell.lab_youhui.text = @"减价¥";
        }
        cell.tf_youhui.text = entity.youhuiPrice;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)beginTimeAction{
    [self.v_ainformation.tf_activeName resignFirstResponder];
    [LYLDatePicker showDateDetermineChooseInView:self.view modeType:UIDatePickerModeDate determineChoose:^(NSString *dateString) {
        NSLog(@"%@",dateString);
        [self.v_ainformation.btn_beginTime setTitle:dateString forState:UIControlStateNormal];
        [self.v_ainformation.btn_beginTime setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    }];
}
- (void)endTimeAction{
    [self.v_ainformation.tf_activeName resignFirstResponder];
    [LYLDatePicker showDateDetermineChooseInView:self.view modeType:UIDatePickerModeDate determineChoose:^(NSString *dateString) {
        NSLog(@"%@",dateString);
        [self.v_ainformation.btn_endTime setTitle:dateString forState:UIControlStateNormal];
        [self.v_ainformation.btn_endTime setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    }];
}

- (void)activeDelete:(UIButton *)btnSender{
    NSLog(@"%ld",btnSender.tag);
    if (self.activeType == ActiceFormManJian) {
        for (int i = 0; i < self.arr_active.count; i++) {
            ManjianTableViewCell *cell = [self.tb_active cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [self.arr_active replaceObjectAtIndex:i withObject:@{@"price":cell.tf_man.text,@"minusPrice":cell.tf_jian.text}];
        }
    }else{
        for (int i = 0; i < self.arr_active.count; i++) {
            SingleSalesTableViewCell *cell = [self.tb_active cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            CommodityFromCodeEntity *entity = [self.arr_active objectAtIndex:i];
            entity.youhuiPrice = cell.tf_youhui.text;
            [self.arr_active replaceObjectAtIndex:i withObject:entity];
        }
    }
    [self.arr_active removeObjectAtIndex:btnSender.tag];
    [self.tb_active reloadData];
}

- (void)activeZhouAction{
    ActiveZhouViewController *vc = [[ActiveZhouViewController alloc]init];
    vc.arr_selectedWeek = self.arr_week;
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBack = ^(NSMutableArray *arr_week) {
        self.arr_week = arr_week;
        NSArray *arr_all = [NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"日", nil];
        if (arr_week.count == 0) {
            [self.v_ainformation.btn_activeZhou setTitle:@"请选择周" forState:UIControlStateNormal];
            [self.v_ainformation.btn_activeZhou setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
        }else if (arr_week.count == 7) {
            [self.v_ainformation.btn_activeZhou setTitle:@"周一至周日" forState:UIControlStateNormal];
            [self.v_ainformation.btn_activeZhou setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        }else{
            NSString *str_week = @"";
            for (int i = 0; i < arr_week.count; i++) {
                int index = [[arr_week objectAtIndex:i] intValue];
                if (i == 0) {
                    str_week = [NSString stringWithFormat:@"周%@",[arr_all objectAtIndex:index]];
                }else{
                    str_week = [str_week stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"、",[arr_all objectAtIndex:index]]];
                }
            }
            [self.v_ainformation.btn_activeZhou setTitle:str_week forState:UIControlStateNormal];
            [self.v_ainformation.btn_activeZhou setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        }
    };
}

- (void)activeTime{
    ActiveTimeViewController *vc = [[ActiveTimeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.goBackFromTime = ^(NSMutableArray *arr_time) {
        self.arr_time = arr_time;
        NSLog(@"%@",arr_time);
        NSString *str_time = @"";
        for (int i = 0; i < self.arr_time.count; i++) {
            NSDictionary *dic = [self.arr_time objectAtIndex:i];
            if (i == 0) {
                str_time = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"beginAt"],[dic objectForKey:@"endAt"]];
            }else{
                str_time = [str_time stringByAppendingString:[NSString stringWithFormat:@" %@-%@",[dic objectForKey:@"beginAt"],[dic objectForKey:@"endAt"]]];
            }
        }
        [self.v_ainformation.btn_activeTime setTitle:str_time forState:UIControlStateNormal];
        [self.v_ainformation.btn_activeTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    };
    
}

- (void)btn_addAction{
    if (self.activeType == ActiceFormManJian) {
        for (int i = 0; i < self.arr_active.count; i++) {
            ManjianTableViewCell *cell = [self.tb_active cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [self.arr_active replaceObjectAtIndex:i withObject:@{@"price":cell.tf_man.text,@"minusPrice":cell.tf_jian.text}];
        }
    }else{
        for (int i = 0; i < self.arr_active.count; i++) {
            SingleSalesTableViewCell *cell = [self.tb_active cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            CommodityFromCodeEntity *entity = [self.arr_active objectAtIndex:i];
            entity.youhuiPrice = cell.tf_youhui.text;
            [self.arr_active replaceObjectAtIndex:i withObject:entity];
        }
    }
    if (self.activeType == ActiceFormManJian) {
        [self.arr_active addObject:@{@"price":@"",@"minusPrice":@""}];
        [self.tb_active reloadData];
    }else{
        CommodityViewController *vc = [[CommodityViewController alloc] init];
        vc.enterFormType = EnterFromActice;
        [self.navigationController pushViewController:vc animated:YES];
        vc.selectCommodity = ^(CommodityFromCodeEntity *entity) {
            [self.arr_active addObject:entity];
            [self.tb_active reloadData];
        };
    }
}

- (void)rightBarAction{
    NSMutableArray *arr_data = [NSMutableArray array];
    if (self.activeType == ActiceFormManJian) {
        for (int i = 0; i < self.arr_active.count; i++) {
            ManjianTableViewCell *cell = [self.tb_active cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell.tf_jian.text.length == 0 || cell.tf_man.text.length == 0) {
                [MBProgressHUD showInfoMessage:@"请完善商品规则"];
                return;
            }else if ([cell.tf_man.text doubleValue] < [cell.tf_jian.text doubleValue]){
                [MBProgressHUD showInfoMessage:@"优惠不能大于原价"];
                return;
            }
            [arr_data addObject:@{@"fullPrice":[NSNumber numberWithDouble:[cell.tf_man.text doubleValue]],@"minusPrice":[NSNumber numberWithDouble:[cell.tf_jian.text doubleValue]]}];
        }
    }else{
        for (int i = 0; i < self.arr_active.count; i++) {
            SingleSalesTableViewCell *cell = [self.tb_active cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            CommodityFromCodeEntity *entity = [self.arr_active objectAtIndex:i];
            if (self.activeType == ActiceFormZheKou) {
                if (cell.tf_youhui.text.length == 0) {
                    [MBProgressHUD showInfoMessage:@"请完善优惠信息"];
                    return;
                }
                if (!([cell.tf_youhui.text doubleValue] > 0 && [cell.tf_youhui.text doubleValue] < 10)) {
                    [MBProgressHUD showInfoMessage:@"请输入规范折扣"];
                    return;
                }
                [arr_data addObject:@{@"discount":[NSNumber numberWithDouble:[cell.tf_youhui.text doubleValue]],@"skuId":entity.skuId}];
            }else if (self.activeType == ActiceFormTeJia){
                if (cell.tf_youhui.text.length == 0) {
                    [MBProgressHUD showInfoMessage:@"请完善优惠信息"];
                    return;
                }
                if ([cell.tf_youhui.text doubleValue] > [entity.price doubleValue]) {
                    [MBProgressHUD showInfoMessage:@"特价金额不能大于原价"];
                    return;
                }
                [arr_data addObject:@{@"favorablePrive":[NSNumber numberWithDouble:[cell.tf_youhui.text doubleValue]],@"skuId":entity.skuId}];

            }else if (self.activeType == ActiceFormJianJia){
                if (cell.tf_youhui.text.length == 0) {
                    [MBProgressHUD showInfoMessage:@"请完善优惠信息"];
                    return;
                }
                if ([cell.tf_youhui.text doubleValue] > [entity.price doubleValue]) {
                    [MBProgressHUD showInfoMessage:@"减价金额不能大于原价"];
                    return;
                }
                [arr_data addObject:@{@"wareMinusPrice":[NSNumber numberWithDouble:[cell.tf_youhui.text doubleValue]],@"skuId":entity.skuId}];
            }
        }

    }
    NSLog(@"%@",arr_data);

    if ([self.v_ainformation.tf_activeName.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入活动名称"];
        return;
    }
    if ([self.v_ainformation.btn_beginTime.titleLabel.text isEqualToString:@"请选择开始日期"]) {
        [MBProgressHUD showInfoMessage:@"请选择开始日期"];
        return;
    }
    if ([self.v_ainformation.btn_endTime.titleLabel.text isEqualToString:@"请选择结束日期"]) {
        [MBProgressHUD showInfoMessage:@"请选择结束日期"];
        return;
    }
    if (self.arr_week.count == 0) {
        [MBProgressHUD showInfoMessage:@"请选择活动周"];
        return;
    }
    if (self.arr_time.count == 0) {
        [MBProgressHUD showInfoMessage:@"请选择活动时段"];
        return;
    }
    if (arr_data.count == 0) {
        [MBProgressHUD showInfoMessage:@"请填写活动信息"];
        return;
    }

    NSMutableArray *arr_timeResult = [NSMutableArray array];
    for (NSDictionary *dic in self.arr_time) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSDate *date1=[dateFormatter dateFromString:[dic objectForKey:@"beginAt"]];
        NSNumber *num_begin = [NSNumber numberWithDouble:[date1 timeIntervalSince1970]*1000];
        NSDate *date2=[dateFormatter dateFromString:[dic objectForKey:@"endAt"]];
        NSNumber *num_end = [NSNumber numberWithDouble:[date2 timeIntervalSince1970]*1000];
        [arr_timeResult addObject:@{@"beginAt":num_begin,@"endAt":num_end}];
    }
    
    if (self.activeType == ActiceFormManJian) {
        [ActiveHandler addManJianActivityWithSid:[LoginStorage GetShopId] activityType:[NSNumber numberWithInt:self.activeType] activityName:self.v_ainformation.lab_activeName.text dateAt:self.v_ainformation.btn_beginTime.titleLabel.text dateEnd:self.v_ainformation.btn_endTime.titleLabel.text week:self.arr_week time:arr_timeResult manjian:arr_data prepare:^{

        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0 ) {
                NSArray *arr_vc = self.navigationController.viewControllers;
                for (NSUInteger index = arr_vc.count - 1; arr_vc >= 0; index--) {
                    UIViewController *vc = [arr_vc objectAtIndex:index];
                    if (![vc isKindOfClass:[AddActiveViewController class]] && ![vc isKindOfClass:[SelectAcTiveTypeViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        return;
                    }
                }
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld",statusCode]];
        }];
    }else{
        [ActiveHandler addOtherActivityWithSid:[LoginStorage GetShopId] activityType:[NSNumber numberWithInt:self.activeType] activityName:self.v_ainformation.lab_activeName.text dateAt:self.v_ainformation.btn_beginTime.titleLabel.text dateEnd:self.v_ainformation.btn_endTime.titleLabel.text week:self.arr_week time:arr_timeResult item:arr_data prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0 ) {
                NSArray *arr_vc = self.navigationController.viewControllers;
                for (NSUInteger index = arr_vc.count - 1; arr_vc >= 0; index--) {
                    UIViewController *vc = [arr_vc objectAtIndex:index];
                    if (![vc isKindOfClass:[AddActiveViewController class]] && ![vc isKindOfClass:[SelectAcTiveTypeViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                        return;
                    }
                }
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld",statusCode]];
        }];
    }


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
