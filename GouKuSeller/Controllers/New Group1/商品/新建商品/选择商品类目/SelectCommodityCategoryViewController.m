//
//  SelectCommodityCategoryViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectCommodityCategoryViewController.h"
#import "CatagoryTableViewCell.h"
#import "RTHttpClient.h"
#import "CommodityHandler.h"

@interface SelectCommodityCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView        *tb_catagory;
@property (nonatomic ,strong)NSMutableArray     *arr_catagory;

@end

@implementation SelectCommodityCategoryViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_catagory = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择商品类目";
}

- (void)onCreate{
    self.tb_catagory = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_catagory];
    self.tb_catagory.delegate = self;
    self.tb_catagory.dataSource = self;
    [self.tb_catagory setRowHeight:44];
    self.tb_catagory.tableFooterView = [UIView new];
    self.tb_catagory.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    [self loadData];
}

- (void)loadData{
    [CommodityHandler getCommodityWithPid:0 prepare:nil success:^(id obj) {
        NSArray *arr_data = (NSArray *)obj;
        [self.arr_catagory addObjectsFromArray:arr_data];
        [self.tb_catagory reloadData];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_catagory.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CatagoryTableViewCell";
    CatagoryTableViewCell *cell = (CatagoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[CatagoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CommodityCatagoryEntity *entity = [self.arr_catagory objectAtIndex:indexPath.row];
    [cell.lab_title setText:entity.name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommodityCatagoryEntity *entity = [self.arr_catagory objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.goBackCategory) {
        self.goBackCategory(entity);
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
