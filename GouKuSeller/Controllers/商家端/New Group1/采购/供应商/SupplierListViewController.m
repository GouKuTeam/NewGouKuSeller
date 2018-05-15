//
//  SupplierListViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierListViewController.h"
#import "TabBarViewController.h"
#import "PurchaseHandler.h"
#import "CategoryEntity.h"
#import "SupplierTableViewController.h"
#import "HYTabbarView.h"
#import "SearchSupplierViewController.h"
@interface SupplierListViewController ()<UITextFieldDelegate,HYTopBarDelegate>

@property (nonatomic, strong)UITextField           *tf_search;
@property (nonatomic, strong)HYTabbarView          *v_topBar;

@end

@implementation SupplierListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)onCreate{
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
    UIButton *btn_search = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 30)];
    [self.navigationItem.titleView addSubview:btn_search];
    [btn_search addTarget:self action:@selector(btnSearchAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.v_topBar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - 49)];
    [self.view addSubview:self.v_topBar];
    self.v_topBar.tabbar.topBarDelegate = self;
    self.v_topBar.backgroundColor = [UIColor whiteColor];
    
    UIView *v_line = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 42, SCREEN_WIDTH, 0.5)];
    [v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [self.view addSubview:v_line];
    
    [self loadData];
}

- (void)loadData{
    [PurchaseHandler getAllCategoryWithPrepare:^{
        [MBProgressHUD showActivityMessageInView:nil];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        NSArray *arr_category = (NSArray *)obj;
        if (arr_category.count > 0) {
            for (CategoryEntity *entity in arr_category) {
                SupplierTableViewController * vc = [[SupplierTableViewController alloc]init];
                vc.title = entity.industryName;
                vc.categoryEntity = entity;
                [self.v_topBar addSubItemWithViewController:vc];
            }
            [self.v_topBar.tabbar setSelectedItem:0];
        }
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)HYTopBarChangeSelectedItem:(HYTopBar *)topbar selectedIndex:(NSInteger)index{
    self.v_topBar.contentView.contentOffset = CGPointMake(HYScreenW * index, 0);
}

- (void)topBarDetailDidSelectedIndex:(int)selectedIndex{
    if (selectedIndex != self.v_topBar.tabbar.selectedIndex) {
        [self.v_topBar.tabbar setSelectedItem:selectedIndex];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"%@",textField.text);
    
    return YES;
}

- (void)btnSearchAction{
    SearchSupplierViewController *vc = [[SearchSupplierViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
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
