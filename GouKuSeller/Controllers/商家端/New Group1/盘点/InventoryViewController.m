//
//  InventoryViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryViewController.h"
#import "AddInventoryViewController.h"
#import "InventoryTableViewCell.h"
#import "InventoryListEntity.h"
#import "InventoryHandler.h"

@interface InventoryViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic ,strong)BaseTableView          *tb_inventory;
@property (nonatomic ,strong)NSMutableArray         *arr_inventory;

@end

@implementation InventoryViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_inventory = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"盘点";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(addBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"add_white"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    self.tb_inventory = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    [self.view addSubview:self.tb_inventory];
    self.tb_inventory.delegate = self;
    self.tb_inventory.dataSource = self;
    self.tb_inventory.tableViewDelegate = self;
    self.tb_inventory.tableFooterView = [UIView new];
    self.tb_inventory.rowHeight = 78;
    self.tb_inventory.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [InventoryHandler inventroyListWithPage:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_inventory removeAllObjects];
        }
        [self.arr_inventory addObjectsFromArray:(NSArray *)obj];
        [self.tb_inventory reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_inventory.count == 0) {
            self.tb_inventory.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_inventory.frame withDefaultImage:nil withNoteTitle:@"暂无数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_inventory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"InventoryTableViewCell";
    InventoryTableViewCell *cell = (InventoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[InventoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addBarAction{
    AddInventoryViewController *vc = [[AddInventoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
