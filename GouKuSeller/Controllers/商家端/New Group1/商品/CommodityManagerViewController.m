//
//  CommodityManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityManagerViewController.h"
#import "CommodityViewController.h"
#import "CommodityChildViewController.h"

@interface CommodityManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView              *tb_manager;
@property (nonatomic ,strong)NSMutableArray           *arr_manager;

@end

@implementation CommodityManagerViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_manager = [[NSMutableArray alloc]init];
        NSArray *arr = @[@"商品库"];
        NSArray *arr2 = @[@"门店商品",@"网店商品"];
        [self.arr_manager addObject:arr];
        [self.arr_manager addObject:arr2];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品管理";
}

- (void)onCreate{
    self.tb_manager = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_manager];
    self.tb_manager.delegate = self;
    self.tb_manager.dataSource = self;
    self.tb_manager.tableFooterView = [UIView new];
    self.tb_manager.backgroundColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr_manager.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arr_manager objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"YuEDetailTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self.arr_manager objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        CommodityViewController *vc = [[CommodityViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        CommodityChildViewController *vc = [[CommodityChildViewController alloc]init];
        vc.commodityChildFormType = CommodityChildFormShop;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        CommodityChildViewController *vc = [[CommodityChildViewController alloc]init];
        vc.commodityChildFormType = CommodityChildFormNetShop;
        [self.navigationController pushViewController:vc animated:YES];
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
