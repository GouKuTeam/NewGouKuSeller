//
//  SearchSupplierViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchSupplierViewController.h"
#import "PurchaseHandler.h"
#import "StoreEntity.h"
#import "SupplierListTableViewCell.h"
@interface SearchSupplierViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITextField           *tf_search;
@property (nonatomic, strong)BaseTableView         *tb_supplier;
@property (nonatomic, strong)NSMutableArray        *arr_data;

@end

@implementation SearchSupplierViewController
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
    [v_header addSubview:self.tf_search];
    [self.tf_search becomeFirstResponder];
    
    UIButton *btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.tf_search.right,0, 60, 44)];
    [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [btn_cancel setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [v_header addSubview:btn_cancel];
    self.navigationItem.titleView = v_header;
    
    self.tb_supplier = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_supplier];
    self.tb_supplier.delegate = self;
    self.tb_supplier.dataSource = self;
    self.tb_supplier.tableFooterView = [UIView new];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [PurchaseHandler searchSupplierWithName:textField.text prepare:^{
        
    } success:^(id obj) {
        
        [self.arr_data removeAllObjects];
        [self.arr_data addObjectsFromArray:(NSArray *)obj];
        [self.tb_supplier reloadData];
        if (self.arr_data.count == 0) {
            self.tb_supplier.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_supplier.frame withDefaultImage:nil withNoteTitle:@"暂未搜索到此供应商" withNoteDetail:nil withButtonAction:nil];
        }        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //关注 返回95  没有返回80
    StoreEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    if (entity.isAttention == YES) {
        return 95;
    }else{
        return 80;
    }
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"NotBeginningActivity";
    SupplierListTableViewCell *cell = (SupplierListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[SupplierListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    StoreEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    [cell contentCellWithStoreEntity:entity];
    return cell;
}


- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:NO];
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
