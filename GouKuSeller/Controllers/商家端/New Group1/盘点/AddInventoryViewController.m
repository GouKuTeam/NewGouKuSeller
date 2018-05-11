//
//  AddInventoryViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddInventoryViewController.h"
#import "AddInventoryTabHeaderView.h"
#import "AddInventoryTableViewCell.h"

@interface AddInventoryViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITextField                    *tfsousuo;
@property (nonatomic, strong)AddInventoryTabHeaderView      *header;
@property (nonatomic ,strong)UITableView                    *tb_commodity;
@property (nonatomic ,strong)NSMutableArray                 *arr_data;
@end

@implementation AddInventoryViewController
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
    self.title = @"新建盘点单";
    [self.arr_data addObject:@""];
    [self.arr_data addObject:@""];
}

- (void)onCreate{
    self.tfsousuo = [[UITextField alloc]initWithFrame:CGRectMake(10, 10 + SafeAreaTopHeight, SCREEN_WIDTH - 20, 32)];
    [self.view addSubview:self.tfsousuo];
    [self.tfsousuo setBackgroundColor:[UIColor whiteColor]];
    self.tfsousuo.font = [UIFont systemFontOfSize:14];
    [self.tfsousuo setPlaceholder:@"输入商品条形码"];
    self.tfsousuo.delegate = self;
    self.tfsousuo.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.tfsousuo.returnKeyType = UIReturnKeySearch;
    self.tfsousuo.leftView  = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 11.f, 0.f)];
    self.tfsousuo.leftViewMode = UITextFieldViewModeAlways;
    [self.tfsousuo becomeFirstResponder];
    
    self.header = [[AddInventoryTabHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
    [self.view addSubview:self.header];
    
    self.tb_commodity = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_commodity];
    self.tb_commodity.delegate = self;
    self.tb_commodity.dataSource = self;
    self.tb_commodity.tableHeaderView = self.header;
    self.tb_commodity.tableFooterView = [UIView new];
    [self.tb_commodity setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    self.tb_commodity.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 42;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AddInventoryTableViewCell";
    AddInventoryTableViewCell *cell = (AddInventoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[AddInventoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row == self.arr_data.count - 1) {
        [cell.img_line setHidden:YES];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tfsousuo resignFirstResponder];
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
