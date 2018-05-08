//
//  SelectFisstCatagoryViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectFisstCatagoryViewController.h"
#import "CommodityHandler.h"
#import "ShopClassificationEntity.h"
#import "LoginStorage.h"

@interface SelectFisstCatagoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView         *tb_firstCatagory;
@property (nonatomic ,strong)NSMutableArray      *arr_firstCatagory;

@end

@implementation SelectFisstCatagoryViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_firstCatagory = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择一级分类";
}

- (void)onCreate{
    self.tb_firstCatagory = [[UITableView alloc]initWithFrame:CGRectMake(0, 10 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 10) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_firstCatagory];
    self.tb_firstCatagory.delegate = self;
    self.tb_firstCatagory.dataSource = self;
    self.tb_firstCatagory.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tb_firstCatagory.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tb_firstCatagory.tableFooterView = [UIView new];
    self.tb_firstCatagory.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self loadData];
}

- (void)loadData{
    [CommodityHandler getShopCatagoryWithShopId:[LoginStorage GetShopId] pid:0 prepare:nil success:^(id obj) {
        NSArray *arr_data = (NSArray *)obj;
        [self.arr_firstCatagory addObjectsFromArray:arr_data];
        [self.tb_firstCatagory reloadData];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_firstCatagory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    ShopClassificationEntity *entity = [self.arr_firstCatagory objectAtIndex:indexPath.row];
    [cell.textLabel setText:entity.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopClassificationEntity *entity = [self.arr_firstCatagory objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.goBackFirst) {
        self.goBackFirst(entity);
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
