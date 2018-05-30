//
//  MoreAddCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "MoreAddCommodityViewController.h"
#import "IQKeyboardManager.h"
#import "CommodityHandler.h"
#import "CommodityFromCodeEntity.h"
#import "AddCustomCommodityViewController.h"

@interface MoreAddCommodityViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITextField         *tfsousuo;
@property (nonatomic ,strong)UITableView         *tb_commodity;
@property (nonatomic ,strong)NSMutableArray      *arr_commodity;

@end

@implementation MoreAddCommodityViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_commodity = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"批量新建商品";
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
    
    self.tb_commodity = [[UITableView alloc]initWithFrame:CGRectMake(0, 50 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_commodity];
    self.tb_commodity.delegate = self;
    self.tb_commodity.dataSource = self;
    self.tb_commodity.tableFooterView = [UIView new];
    self.tb_commodity.rowHeight = 44;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_commodity.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"BankCardTableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
    if (entity.name) {
        [cell.textLabel setText:entity.name];
    }else{
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",entity.barcode]];
    }
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    if (![textField.text isEqualToString:@""]) {
        [CommodityHandler getCommodityInformationWithBarCode:textField.text prepare:nil success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            if ([[dic objectForKey:@"errCode"] intValue] == 0) {
                CommodityFromCodeEntity *entity = [CommodityFromCodeEntity parseCommodityFromCodeEntityWithJson:[dic objectForKey:@"data"]];
                //添加商品
                [CommodityHandler addCommodityWithShopId:[LoginStorage GetShopId] name:entity.name itemId:entity.itemId barcode:entity.barcode shopWareCategoryId:nil wareCategoryId:entity.categoryId price:[entity.price doubleValue] stock:0 pictures:entity.pictures standards:entity.standards wid:entity.wid xprice:0 prepare:^{
                    
                } success:^(id obj) {
                    NSDictionary *dic = (NSDictionary *)obj;
                    CommodityFromCodeEntity *entity = [CommodityFromCodeEntity parseCommodityFromCodeEntityWithJson:[dic objectForKey:@"data"]];
                    if ([[dic objectForKey:@"errCode"] intValue] == 0 ) {
                        [self.arr_commodity removeAllObjects];
                        [self.arr_commodity addObject:entity];
                        [self.tb_commodity reloadData];
                    }else{
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showErrorMessage:[dic objectForKey:@"errMessage"]];
                    }
                    self.tfsousuo.text = @"";
                } failed:^(NSInteger statusCode,
                           id json) {
                    self.tfsousuo.text = @"";
                    [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
                }];
            }else{
                self.tfsousuo.text = @"";
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[dic objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
            AddCustomCommodityViewController *vc = [[AddCustomCommodityViewController alloc]init];
            vc.barcode = textField.text;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        [MBProgressHUD showInfoMessage:@"请输入条形码"];
    }
    
    return YES;
}

-(void)leftBarAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.addCommodityMoreFinish) {
        self.addCommodityMoreFinish();
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tfsousuo resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
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
