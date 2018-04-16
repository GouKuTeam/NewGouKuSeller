//
//  YueDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/30.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "YueDetailViewController.h"
#import "YuEDetailTableViewCell.h"
#import "ShaiXuanView.h"
#import "SettlementHandler.h"
#import "AccountCashDetailEntity.h"
#import "TiXianDetailViewController.h"

@interface YueDetailViewController ()<UITableViewDataSource,UITableViewDelegate,BaseTableViewDelagate>

@property (nonatomic ,strong)BaseTableView            *tb_priceDetail;
@property (nonatomic ,strong)NSMutableArray           *arr_priceDetail;
@property (nonatomic ,strong)ShaiXuanView             *v_shaixuan;
@property (nonatomic ,assign)int                       Ktype;

@end

@implementation YueDetailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_priceDetail = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额明细";
    self.Ktype = 0;
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    
}

- (void)onCreate{
    
    self.tb_priceDetail = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    
    [self.view addSubview:self.tb_priceDetail];
    self.tb_priceDetail.delegate = self;
    self.tb_priceDetail.dataSource = self;
    self.tb_priceDetail.tableViewDelegate = self;
    self.tb_priceDetail.tableFooterView = [UIView new];
    self.tb_priceDetail.backgroundColor = [UIColor clearColor];
    self.tb_priceDetail.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tb_priceDetail requestDataSource];
    
    self.v_shaixuan = [[ShaiXuanView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.v_shaixuan];
    [self.v_shaixuan setHidden:YES];
    WS(weakSelf);
    self.v_shaixuan.btnSelectIndex = ^(int btnIndex) {
        weakSelf.Ktype = btnIndex;
        [weakSelf.tb_priceDetail requestDataSource];
    };
    
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [SettlementHandler accountdetailsWithshopId:[LoginStorage GetShopId] page:(int)pageNum type:self.Ktype prepare:^{
        
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_priceDetail removeAllObjects];
        }
        [self.arr_priceDetail addObjectsFromArray:(NSArray *)obj];
        [self.tb_priceDetail reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_priceDetail.count == 0) {
            self.tb_priceDetail.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_priceDetail.frame withDefaultImage:nil withNoteTitle:@"暂无数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr_priceDetail.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"YuEDetailTableViewCell";
    YuEDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YuEDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    AccountCashDetailEntity *entity = [self.arr_priceDetail objectAtIndex:indexPath.section];
    [cell contentCellWithAccountCashDetailEntity:entity];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AccountCashDetailEntity *entity = [self.arr_priceDetail objectAtIndex:indexPath.section];
    TiXianDetailViewController *vc = [[TiXianDetailViewController alloc]init];
    vc.crashId = [NSString stringWithFormat:@"%@",entity.cashOrderId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarAction{
    [self.v_shaixuan setHidden:!self.v_shaixuan.isHidden];
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
