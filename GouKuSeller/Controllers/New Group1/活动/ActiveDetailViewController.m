//
//  ActiveDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveDetailViewController.h"
#import "ActiveDetailHeaderView.h"
#import "ActiveHandler.h"
#import "ActivityEntity.h"
#import "DateUtils.h"
#import "ActiveDetailCommodityTableViewCell.h"
#import "ActiveRulesEntity.h"
#import "ActiveTimeEntity.h"

@interface ActiveDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)ActiveDetailHeaderView     *tb_header;
@property (nonatomic ,strong)ActivityEntity             *actDetailentity;
@property (nonatomic ,strong)UITableView        *tb_rules;
@property (nonatomic ,strong)NSMutableArray     *arr_rules;

@end

@implementation ActiveDetailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_rules = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
}


- (void)onCreate{
    self.tb_header = [[ActiveDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 310)];
    self.tb_rules = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_rules];
    self.tb_rules.dataSource = self;
    self.tb_rules.delegate = self;
    self.tb_rules.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_rules.tableFooterView = [UIView new];
    self.tb_rules.tableHeaderView = self.tb_header;
    [self loadData];
}

- (void)loadData{
    [ActiveHandler selectActiveDetailWithActiveId:self.actIc prepare:^{
        
    } success:^(id obj) {
        self.actDetailentity = (ActivityEntity *)obj;
        if (self.actDetailentity.status == 0) {
            [self.tb_header.lab_status setText:@"未开始"];
            [self.tb_header.lab_status setTextColor:[UIColor colorWithHexString:@"#000000"]];
        }else{
            [self.tb_header.lab_status setText:@"进行中"];
            [self.tb_header.lab_status setTextColor:[UIColor colorWithHexString:@"#18AD19"]];
        }
        [self.tb_header.lab_actName setText:self.actDetailentity.title];
        [self.tb_header.lab_beginTime setText:[DateUtils stringFromTimeInterval:self.actDetailentity.startTime formatter:@"yyyy-MM-dd"]];
        [self.tb_header.lab_endTime setText:[DateUtils stringFromTimeInterval:self.actDetailentity.endTime formatter:@"yyyy-MM-dd"]];
        
        NSMutableArray *arr_week = [NSMutableArray arrayWithArray:self.actDetailentity.weekDays];
        NSArray *arr_all = [NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"日", nil];
        if (arr_week.count == 7) {
            [self.tb_header.lab_actWeek setText:@"周一至周日"];
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
            [self.tb_header.lab_actWeek setText:str_week];
        }
        
        NSMutableArray *arr_time = [NSMutableArray arrayWithArray:self.actDetailentity.times];
        NSLog(@"%@",arr_time);
        NSString *str_time = @"";
        for (int i = 0; i < arr_time.count; i++) {
            ActiveTimeEntity *entity = [arr_time objectAtIndex:i];
            if (i == 0) {
                str_time = [NSString stringWithFormat:@"%@-%@",[DateUtils stringFromTimeInterval:entity.beginAt formatter:@"HH:mm"],[DateUtils stringFromTimeInterval:entity.endAt formatter:@"HH:mm"]];
                if ([str_time isEqualToString:@"00:00-23:59"]) {
                    str_time = @"全天";
                }
            }else{
                str_time = [str_time stringByAppendingString:[NSString stringWithFormat:@" %@-%@",[DateUtils stringFromTimeInterval:entity.beginAt formatter:@"HH:mm"],[DateUtils stringFromTimeInterval:entity.endAt formatter:@"HH:mm"]]];
            }
        }
        [self.tb_header.lab_actTime setText:str_time];
        if (self.actDetailentity.actCategory == 0) {
            [self.tb_header.lab_actType setText:@"活动规则"];
        }else{
            [self.tb_header.lab_actType setText:@"活动商品"];
        }
        [self.arr_rules addObjectsFromArray:self.actDetailentity.rules];
        [self.tb_rules reloadData];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.actDetailentity.actType == 0){
        return 44;
    }else{
        return 64;
    }
    return 0.01;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_rules.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.actDetailentity.actType intValue] == 0) {
        static NSString *CellIdentifier = @"UITableViewCell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ActiveRulesEntity *entity = [self.arr_rules objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"满%.2f元，减%.2f元",entity.fullPrice,entity.minusPrice]];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"ActiveDetailCommodityTableViewCell";
        ActiveDetailCommodityTableViewCell *cell = (ActiveDetailCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[ActiveDetailCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ActiveRulesEntity *entity = [self.arr_rules objectAtIndex:indexPath.row];
        [cell contentCellWithActiveEntity:entity];
        if ([self.actDetailentity.actType intValue] == 1) {
            [cell.lab_active setText:[NSString stringWithFormat:@"%.1f折",entity.discount]];
        }
        if ([self.actDetailentity.actType intValue] == 2) {
            [cell.lab_active setText:[NSString stringWithFormat:@"优惠价¥%.2f",entity.favorablePrive]];
        }
        if ([self.actDetailentity.actType intValue] == 3) {
            [cell.lab_active setText:[NSString stringWithFormat:@"立减¥%.2f",entity.wareMinusPrice]];
        }
        return cell;
    }
    return nil;
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
