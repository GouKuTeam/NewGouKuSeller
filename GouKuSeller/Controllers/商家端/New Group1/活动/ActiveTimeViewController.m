//
//  ActiveTimeViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveTimeViewController.h"
#import "ActiveTimeTabHeader.h"
#import "ActiveTimeTableViewCell.h"
#import "LYLOptionPicker.h"
#import "LYLDatePicker.h"

@interface ActiveTimeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)ActiveTimeTabHeader         *v_tabHeader;
@property (nonatomic ,strong)UIButton                    *btn_tabFooter;
@property (nonatomic ,strong)UITableView                 *tb_activeTime;
@property (nonatomic ,strong)NSMutableArray              *arr_activeTime;

@end

@implementation ActiveTimeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动时段";
    if (!self.arr_selectTime) {
        self.arr_selectTime = [NSMutableArray array];
    }
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_activeTime = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)onCreate{
    self.v_tabHeader = [[ActiveTimeTabHeader alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 97)];
    [self.view addSubview:self.v_tabHeader];
    
    [self.v_tabHeader.switch_quantian addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    self.btn_tabFooter = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.btn_tabFooter setBackgroundColor:[UIColor whiteColor]];
        [self.btn_tabFooter setTitle:@"添加时间段" forState: UIControlStateNormal];
    [self.btn_tabFooter setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    self.btn_tabFooter.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_tabFooter setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.btn_tabFooter setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0.0, 0.0)];
    [self.btn_tabFooter addTarget:self action:@selector(btn_addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_tabFooter setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.btn_tabFooter.contentEdgeInsets = UIEdgeInsetsMake(0,17, 0, 0);
    
    self.tb_activeTime = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_activeTime];
    self.tb_activeTime.delegate = self;
    self.tb_activeTime.dataSource = self;
    self.tb_activeTime.tableHeaderView = self.v_tabHeader;
    self.tb_activeTime.tableFooterView = self.btn_tabFooter;
    self.tb_activeTime.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_activeTime.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MainJianTableViewCell";
    ActiveTimeTableViewCell *cell = (ActiveTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[ActiveTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btn_beginTime.tag = indexPath.row ;
    [cell.btn_beginTime addTarget:self action:@selector(btn_beginTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_endTime.tag = indexPath.row;
    [cell.btn_endTime addTarget:self action:@selector(btn_endTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_delete.tag = indexPath.row ;
    [cell.btn_delete addTarget:self action:@selector(btn_deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *dic = [self.arr_activeTime objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"beginAt"] length] > 0) {
        [cell.btn_beginTime setTitle:[dic objectForKey:@"beginAt"] forState:UIControlStateNormal];
        [cell.btn_beginTime setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    }else{
        [cell.btn_beginTime setTitle:@"开始时间" forState:UIControlStateNormal];
        [cell.btn_beginTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
    }
    if ([[dic objectForKey:@"endAt"] length] > 0) {
        [cell.btn_endTime setTitle:[dic objectForKey:@"endAt"] forState:UIControlStateNormal];
        [cell.btn_endTime setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    }else{
        [cell.btn_endTime setTitle:@"结束时间" forState:UIControlStateNormal];
        [cell.btn_endTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
    }
    
    return cell;
    
}

- (void)btn_beginTimeAction:(UIButton *)btn{
    [LYLDatePicker showDateDetermineChooseInView:self.view modeType:UIDatePickerModeTime determineChoose:^(NSString *dateString) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.arr_activeTime objectAtIndex:btn.tag]];
        [dic setObject:dateString forKey:@"beginAt"];
        [self.arr_activeTime replaceObjectAtIndex:btn.tag withObject:dic];
        [self.tb_activeTime reloadData];

    }];
    
}

- (void)btn_endTimeAction:(UIButton *)btn{
    [LYLDatePicker showDateDetermineChooseInView:self.view modeType:UIDatePickerModeTime determineChoose:^(NSString *dateString) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.arr_activeTime objectAtIndex:btn.tag]];
        [dic setObject:dateString forKey:@"endAt"];
        [self.arr_activeTime replaceObjectAtIndex:btn.tag withObject:dic];
        [self.tb_activeTime reloadData];
    }];
}

- (void)btn_deleteAction:(UIButton *)btn{
    [self.arr_activeTime removeObjectAtIndex:btn.tag];
    NSLog(@"%ld",btn.tag);
    [self.tb_activeTime reloadData];
}

- (void)btn_addAction{
    
    [self.arr_activeTime addObject:@{@"beginAt":@"",@"endAt":@""}];
    [self.tb_activeTime reloadData];
    NSLog(@"%lu",(unsigned long)self.arr_activeTime.count);
}



- (void)switchAction:(id)sender{
    if (self.v_tabHeader.switch_quantian.on) {
            NSLog(@"switch is on");
        } else {
            NSLog(@"switch is off");
        }
}

- (void)leftBarAction:(id)sender{
    
    for (int i = 0; i < self.arr_activeTime.count; i++) {
        ActiveTimeTableViewCell *cell = [self.tb_activeTime cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell.btn_beginTime.titleLabel.text isEqualToString:@"开始时间"] || [cell.btn_endTime.titleLabel.text isEqualToString:@"结束时间"]) {
            [MBProgressHUD showInfoMessage:@"请完善时间段"];
            return;
         }
    }
    self.arr_selectTime = [NSMutableArray arrayWithArray:self.arr_activeTime];
    if (self.v_tabHeader.switch_quantian.on) {
        [self.arr_selectTime removeAllObjects];
        [self.arr_selectTime addObject:@{@"beginAt":@"00:00",@"endAt":@"23:59"}];
        NSLog(@"switch is on");
    } else {
        NSLog(@"switch is off");
    }
    if (self.goBackFromTime) {
        self.goBackFromTime(self.arr_selectTime);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

+ (long long)getZiFuChuan:(NSString*)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSDate *date1=[dateFormatter dateFromString:time];
    
    return [date1 timeIntervalSince1970]*1000;
    
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
