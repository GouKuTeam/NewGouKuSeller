//
//  SalesViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SalesViewController.h"
#import "SelectAcTiveTypeViewController.h"
#import "SalesHeaderView.h"
#import "ActiveHandler.h"
#import "ActivityEntity.h"
#import "NotBeginningActivityTableViewCell.h"
#import "BeginningActiveTableViewCell.h"
#import "FinishedActiveTableViewCell.h"
#import "ActiveDetailViewController.h"

@interface SalesViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>
@property (nonatomic ,strong)UIButton                 *btn_top;
@property (nonatomic ,strong)SalesHeaderView          *v_header;
@property (nonatomic,assign)int                       selectedIndex;
@property (nonatomic,assign)int                       statusIndex;
@property (nonatomic ,strong)UISegmentedControl       *segC;
@property (nonatomic ,strong)BaseTableView            *tb_activity;
@property (nonatomic ,strong)NSMutableArray           *arr_data;

@end

@implementation SalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr_data = [NSMutableArray array];
    self.selectedIndex = 0;
    // 初始化，添加分段名，会自动布局
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"满减活动",@"单品活动",nil];
    
    self.segC = [[UISegmentedControl alloc]initWithItems:segmentedArray];

    self.segC.frame = CGRectMake(0, 0, 216, 26);
    
    self.segC.selectedSegmentIndex = 0;
    self.segC.layer.masksToBounds = YES;
    self.segC.layer.borderColor = [[UIColor colorWithHexString:@"#ffffff"] CGColor];
    self.segC.layer.borderWidth = 1;
    self.segC.layer.cornerRadius = 4;
    self.segC.tintColor = [UIColor colorWithHexString:@"#ffffff"];
    
    [self.segC setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4167b2"]} forState:UIControlStateSelected];
    [self.segC setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#38393e"]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segC setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#ffffff"]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segC addTarget:self action:@selector(indexDidChangeForSegmentedControl:)
        forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segC;
    
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(addBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"add_white"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    self.v_header = [[SalesHeaderView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 40)];
    [self.view addSubview:self.v_header];
    WS(weakSelf);
    self.v_header.selectItem = ^(int index) {
        NSLog(@"%d",index);
        weakSelf.statusIndex = index;
        [weakSelf.tb_activity requestDataSource];
    };
    
    self.tb_activity = [[BaseTableView alloc]initWithFrame:CGRectMake(0,self.v_header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT- SafeAreaBottomHeight - self.v_header.bottom ) style:UITableViewStylePlain hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    [self.view addSubview:self.tb_activity];
    self.tb_activity.delegate = self;
    self.tb_activity.dataSource = self;
    self.tb_activity.tableViewDelegate = self;
    self.tb_activity.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_activity.tableFooterView = [UIView new];
    
    [self.tb_activity requestDataSource];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    
    [ActiveHandler getActivityListWithActCategory:[NSNumber numberWithInt:self.selectedIndex] status:[NSNumber numberWithInt:self.statusIndex] pageNumber:[NSNumber numberWithInteger:pageNum] prepare:^{
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_data removeAllObjects];
        }
        [self.arr_data addObjectsFromArray:(NSArray *)obj];
        complete([(NSArray *)obj count]);
        if (self.arr_data.count == 0) {
            self.tb_activity.defaultView = [[TableBackgroudView alloc]initWithFrame:self.tb_activity.frame withDefaultImage:nil withNoteTitle:@"暂无数据" withNoteDetail:nil withButtonAction:nil];
        }else{
            self.tb_activity.defaultView = nil;
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_Main] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_section = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    [v_section setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    return v_section;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v_section = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    [v_section setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    return v_section;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.statusIndex == 2) {
        return 63;
    }else{
        return 110;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.statusIndex == 0) {
        static NSString *CellIdentifier = @"NotBeginningActivity";
        NotBeginningActivityTableViewCell *cell = (NotBeginningActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[NotBeginningActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ActivityEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
        [cell contentCellWithActivityEntity:entity];
        cell.btn_stop.tag = indexPath.row;
        [cell.btn_stop addTarget:self action:@selector(btnstopAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (self.statusIndex == 1){
        static NSString *CellIdentifier = @"BeginningActive";
        BeginningActiveTableViewCell *cell = (BeginningActiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[BeginningActiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ActivityEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
        [cell contentCellWithActivityEntity:entity];
        cell.btn_stop.tag = indexPath.row;
        [cell.btn_stop addTarget:self action:@selector(btnstopAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (self.statusIndex == 2){
        static NSString *CellIdentifier = @"FinishedActive";
        FinishedActiveTableViewCell *cell = (FinishedActiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[FinishedActiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ActivityEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
        [cell contentCellWithActivityEntity:entity];
        return cell;
    }
    return nil;
}

- (void)btnstopAction:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定停止该活动吗" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ActivityEntity *entity = [self.arr_data objectAtIndex:btn.tag];
        [ActiveHandler stopActiveWithActiveId:[NSNumber numberWithLong:entity._id] prepare:^{
            
        } success:^(id obj) {
            [self.tb_activity requestDataSource];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    if (self.statusIndex == 0 || self.statusIndex == 1) {
        ActiveDetailViewController *vc = [[ActiveDetailViewController alloc]init];
        vc.actIc = [NSString stringWithFormat:@"%ld",entity._id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"满减活动");
        self.selectedIndex = 0;
    } else {
        NSLog(@"单品活动");
        self.selectedIndex = 1;
        
    }
    [self.tb_activity requestDataSource];
}

#pragma NavBarAction
- (void)btn_topAction{
    
}

- (void)addBarAction{
    SelectAcTiveTypeViewController *vc = [[SelectAcTiveTypeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma -

- (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
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
