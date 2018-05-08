//
//  SupplierListViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierListViewController.h"
#import "TabBarViewController.h"
#import "SupplierListTableViewCell.h"

@interface SupplierListViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic, strong)UITextField           *tf_search;
@property (nonatomic ,strong)NSMutableArray        *arr_supplierList;
@property (nonatomic ,strong)BaseTableView         *tb_supplierList;

@end

@implementation SupplierListViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_supplierList = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)onCreate{
//    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 50, 44)];
    
    self.tf_search = [[UITextField alloc]initWithFrame:CGRectMake(30, 7, SCREEN_WIDTH - 40, 30)];
    UIView *v_left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIImageView *iv_icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
    [iv_icon setImage:[UIImage imageNamed:@"home_search"]];
    [v_left addSubview:iv_icon];
    self.tf_search.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.tf_search.leftView = v_left;
    self.tf_search.leftViewMode = UITextFieldViewModeAlways;
    self.tf_search.placeholder = @"搜索供应商名称";
    self.tf_search.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    self.tf_search.textColor = [UIColor blackColor];
    [self.tf_search.layer setCornerRadius:5];
    self.tf_search.layer.masksToBounds = YES;
    self.tf_search.delegate = self;
    self.tf_search.returnKeyType = UIReturnKeySearch;
    self.tf_search.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_search.enablesReturnKeyAutomatically = YES;
    self.tf_search.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
    self.navigationItem.titleView = self.tf_search;
    
    self.tb_supplierList = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 42.3, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 42.3) style:UITableViewStylePlain hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    [self.view addSubview:self.tb_supplierList];
    self.tb_supplierList.delegate = self;
    self.tb_supplierList.dataSource = self;
    self.tb_supplierList.tableViewDelegate = self;
    self.tb_supplierList.tableFooterView = [UIView new];
    
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //关注 返回95  没有返回80
    return 80;
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"%@",textField.text);
    
    return YES;
}

- (void)leftBarAction:(id)sender{
    TabBarViewController *vc = [[TabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
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
