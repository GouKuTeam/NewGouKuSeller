//
//  InventoryDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryDetailViewController.h"
#import "InventoryDetailHeaderView.h"
#import "InventoryDetailFooterView.h"
#import "InventoryDetailTableViewCell.h"
#import "InventoryHandler.h"
#import "InventoryListEntity.h"
#import "DateUtils.h"


@interface InventoryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView          *tb_commodity;
@property (nonatomic ,strong)NSMutableArray       *arr_data;
@property (nonatomic ,strong)InventoryDetailHeaderView      *header;
@property (nonatomic ,strong)InventoryDetailFooterView      *footer;

@end

@implementation InventoryDetailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_data = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"盘点单详情";
}


- (void)onCreate{
    
    self.header = [[InventoryDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 191)];
    self.footer = [[InventoryDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 76)];
    
    self.tb_commodity = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_commodity];
    self.tb_commodity.delegate = self;
    self.tb_commodity.dataSource = self;
    self.tb_commodity.tableHeaderView = self.header;
    self.tb_commodity.tableFooterView = self.footer;
    [self.tb_commodity setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [self loadData];
}

- (void)loadData{
    [InventoryHandler selectInventroyDetailWithInventroyId:self.inventoryId prepare:^{
        
    } success:^(id obj) {
        InventoryListEntity *entity = (InventoryListEntity *)obj;
        [self.header.lab_createTime setText:[DateUtils stringFromTimeInterval:entity.createTime formatter:@"yyyy-MM-dd HH:mm:ss"]];
        [self.header.lab_submitTime setText:[DateUtils stringFromTimeInterval:entity.submitTime formatter:@"yyyy-MM-dd HH:mm:ss"]];
        [self.arr_data addObjectsFromArray:entity.wares];
        [self.tb_commodity reloadData];
        int yingAll = 0;
        int kuiAll = 0;
        for (InventoryEntity *entity in self.arr_data) {
            if (entity.stock < entity.inventoryNum) {
                yingAll = yingAll + (entity.inventoryNum - entity.stock);
            }
            if (entity.stock > entity.inventoryNum) {
                kuiAll = kuiAll + (entity.stock - entity.inventoryNum);
            }
        }
        [self.footer.lab_ying setText:[NSString stringWithFormat:@"%d",yingAll]];
        [self.footer.lab_kui setText:[NSString stringWithFormat:@"%d",kuiAll]];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"InventoryDetailTableViewCell";
    InventoryDetailTableViewCell *cell = (InventoryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[InventoryDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row == self.arr_data.count - 1) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    InventoryEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    [cell contentCellWithInventoryEntity:entity];
    
    return cell;
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
