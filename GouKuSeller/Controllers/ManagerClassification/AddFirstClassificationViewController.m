//
//  AddFirstClassificationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddFirstClassificationViewController.h"
#import "BaseTableView.h"
#import "AddClassificationTableViewCell.h"

@interface AddFirstClassificationViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic ,strong)BaseTableView      *tab_mc;
@property (nonatomic ,strong)NSMutableArray     *arr_mc;
@end

@implementation AddFirstClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加一级分类";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    self.tab_mc = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 44) style:UITableViewStylePlain hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    [self.view addSubview:self.tab_mc];
    self.tab_mc.delegate = self;
    self.tab_mc.dataSource = self;
    [self.tab_mc  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tab_mc setBackgroundColor:[UIColor whiteColor]];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(v_event)];
    [self.view addGestureRecognizer:tapGesture];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"AddClassificationTableViewCell";
    AddClassificationTableViewCell *cell = (AddClassificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[AddClassificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
    
}

- (void)v_event{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    AddClassificationTableViewCell *cell = [self.tab_mc cellForRowAtIndexPath:indexPath];
    [cell.tef_CName resignFirstResponder];
    
}

- (void)rightBarAction{
    
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
