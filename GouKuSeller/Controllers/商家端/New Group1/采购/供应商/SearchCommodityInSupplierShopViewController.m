//
//  SearchSupplierCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/15.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchCommodityInSupplierShopViewController.h"
#import "SupplierCommodityTableViewCell.h"
#import "PurchaseHandler.h"

@interface SearchCommodityInSupplierShopViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITextField              *tf_search;
@property (nonatomic ,strong)BaseTableView            *tb_supplierCommodity;
@property (nonatomic ,strong)NSMutableArray           *arr_data;


@end

@implementation SearchCommodityInSupplierShopViewController
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
    // Do any additional setup after loading the view.
}

- (void)onCreate{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem.customView = [UIView new];
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 44)];
    
    self.tf_search = [[UITextField alloc]initWithFrame:CGRectMake(0, 7, v_header.width - 50, 30)];
    UIView *v_left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIImageView *iv_icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
    [iv_icon setImage:[UIImage imageNamed:@"home_search"]];
    [v_left addSubview:iv_icon];
    self.tf_search.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.tf_search.leftView = v_left;
    self.tf_search.leftViewMode = UITextFieldViewModeAlways;
    self.tf_search.placeholder = @"输入订单号搜索订单";
    self.tf_search.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    self.tf_search.textColor = [UIColor blackColor];
    [self.tf_search.layer setCornerRadius:5];
    self.tf_search.layer.masksToBounds = YES;
    self.tf_search.delegate = self;
    self.tf_search.returnKeyType = UIReturnKeySearch;
    self.tf_search.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_search.enablesReturnKeyAutomatically = YES;
    self.tf_search.tintColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
    [v_header addSubview:self.tf_search];
    
    UIButton *btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.tf_search.right,0, 60, 44)];
    [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [btn_cancel setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [v_header addSubview:btn_cancel];
    
    self.navigationItem.titleView = v_header;
    
    self.tb_supplierCommodity = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_supplierCommodity];
    self.tb_supplierCommodity.delegate = self;
    self.tb_supplierCommodity.dataSource = self;
    self.tb_supplierCommodity.rowHeight = 96;
    self.tb_supplierCommodity.tableFooterView = [UIView new];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"%@",textField.text);
    
    [PurchaseHandler getWareWithShopId:self.shopId keyword:textField.text status:nil firstCategoryId:nil page:(int)nil prepare:^{
        
    } success:^(id obj) {
        NSArray *arrdata = (NSArray *)obj;
        if (arrdata.count > 0) {
            [self.arr_data removeAllObjects];
        }
        [self.arr_data addObjectsFromArray:arrdata];
        [self.tb_supplierCommodity reloadData];
        if (self.arr_data.count == 0) {
            self.tb_supplierCommodity.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_supplierCommodity.frame withDefaultImage:nil withNoteTitle:@"未找到相关商品" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
    
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arr_data.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SupplierCommodityTableViewCell";
    SupplierCommodityTableViewCell *cell = (SupplierCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[SupplierCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    SupplierCommodityEndity *entity = [self.arr_data objectAtIndex:indexPath.row];
    [cell contentCellWithWareEntity:entity];
    return cell;
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
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
