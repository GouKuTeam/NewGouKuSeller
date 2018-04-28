//
//  ActiveZhouViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveZhouViewController.h"

@interface ActiveZhouViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView          *tb_activeZhou;
@property (nonatomic ,strong)NSMutableArray       *arr_activeZhou;
@end

@implementation ActiveZhouViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_activeZhou = [NSMutableArray arrayWithObjects:@"每周日",@"每周一",@"每周二",@"每周三",@"每周四",@"每周五",@"每周六", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动周";
    if (!self.arr_selectedWeek) {
        self.arr_selectedWeek = [NSMutableArray array];
    }
}

- (void)onCreate{
    self.tb_activeZhou = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tb_activeZhou];
    self.tb_activeZhou.delegate = self;
    self.tb_activeZhou.dataSource = self;
    UIView *tabHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tb_activeZhou.tableHeaderView = tabHeader;
}

- (void)leftBarAction:(id)sender{
    if (self.goBack) {
        self.goBack(self.arr_selectedWeek);
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_activeZhou.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"PotentialStoreTableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[self.arr_activeZhou objectAtIndex:indexPath.row]];
    if ([self.arr_selectedWeek containsObject:[NSNumber numberWithInt:(int)indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if ([self.arr_selectedWeek containsObject:[NSNumber numberWithInt:(int)indexPath.row]]) {
         [self.arr_selectedWeek removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
     }else{
         [self.arr_selectedWeek addObject:[NSNumber numberWithInt:(int)indexPath.row]];
     }
    [self.tb_activeZhou reloadData];
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
