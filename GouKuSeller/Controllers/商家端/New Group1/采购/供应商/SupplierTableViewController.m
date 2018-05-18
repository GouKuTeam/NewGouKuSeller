//
//  SupplierTableViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierTableViewController.h"
#import "SupplierListTableViewCell.h"
#import "PurchaseHandler.h"
#import "StoreEntity.h"
#import "SupplierShopViewController.h"

@interface SupplierTableViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic ,strong)NSMutableArray        *arr_supplierList;
@property (nonatomic ,strong)BaseTableView         *tb_supplierList;

@end

@implementation SupplierTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr_supplierList = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)onCreate{
    self.tb_supplierList = [[BaseTableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 42.3) style:UITableViewStylePlain hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    [self.view addSubview:self.tb_supplierList];
    self.tb_supplierList.delegate = self;
    self.tb_supplierList.dataSource = self;
    self.tb_supplierList.tableViewDelegate = self;
    self.tb_supplierList.tableFooterView = [UIView new];
    [self.tb_supplierList requestDataSource];
}

- (void)loadData{
    [self.tb_supplierList requestDataSource];
}

- (void)scrollToTop{
    if (self.tb_supplierList.contentOffset.y > 0) {
        [self.tb_supplierList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [PurchaseHandler getCategorySupplierWithCategoryId:self.categoryEntity.industryId page:(int)pageNum prepare:^{
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_supplierList removeAllObjects];
        }
        [self.arr_supplierList addObjectsFromArray:(NSArray *)obj];
        [self.tb_supplierList reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_supplierList.count == 0) {
            self.tb_supplierList.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_supplierList.frame withDefaultImage:nil withNoteTitle:@"暂未数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //关注 返回95  没有返回80
    StoreEntity *entity = [self.arr_supplierList objectAtIndex:indexPath.row];
    if (entity.isAttention == YES) {
        return 95;
    }else{
        return 80;
    }
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_supplierList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"NotBeginningActivity";
    SupplierListTableViewCell *cell = (SupplierListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[SupplierListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    StoreEntity *entity = [self.arr_supplierList objectAtIndex:indexPath.row];
    [cell contentCellWithStoreEntity:entity];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SupplierShopViewController *vc = [[SupplierShopViewController alloc]init];
    StoreEntity *entity = [self.arr_supplierList objectAtIndex:indexPath.row];
    vc.storeEntity = entity;
    vc.hidesBottomBarWhenPushed = YES;
    [[(UITabBarController *)[AppUtils activityViewController] selectedViewController] pushViewController:vc animated:YES];
}

- (void)setTableFrameWithHeight:(double)height{
    [_tb_supplierList setFrame:CGRectMake(_tb_supplierList.left, _tb_supplierList.top, _tb_supplierList.width,height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
