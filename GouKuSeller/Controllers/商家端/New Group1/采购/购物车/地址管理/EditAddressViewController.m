//
//  EditAddressViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditAddressViewController.h"
#import "EditAddressTableViewCell.h"
#import "CreateAddressViewController.h"
#import "PurchaseHandler.h"
#import "AddressEntity.h"

@interface EditAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)BaseTableView         *tb_adress;
@property (nonatomic ,strong)NSMutableArray      *arr_adress;

@end

@implementation EditAddressViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_adress = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}


- (void)onCreate{
    self.tb_adress = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_adress];
    self.tb_adress.delegate = self;
    self.tb_adress.dataSource = self;
    [self.tb_adress setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    self.tb_adress.tableFooterView = [UIView new];
    [self loadData];
}

- (void)loadData{
    [PurchaseHandler selectAllAddressWithprepare:^{
        
    } success:^(id obj) {
        
        if ([(NSArray *)obj count] == 0) {
            self.tb_adress.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_adress.frame withDefaultImage:nil withNoteTitle:@"暂无地址，快去添加吧" withNoteDetail:nil withButtonAction:nil];
        }
        [self.arr_adress removeAllObjects];
        [self.arr_adress addObjectsFromArray:(NSArray *)obj];
        [self.tb_adress reloadData];
        
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_adress.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"NotBeginningActivity";
    EditAddressTableViewCell *cell = (EditAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[EditAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.btn_morenAddress.tag = indexPath.row;
    cell.btn_delete.tag = indexPath.row;
    [cell.btn_morenAddress addTarget:self action:@selector(btn_morenAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_delete addTarget:self action:@selector(btn_deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    AddressEntity *entity = [self.arr_adress objectAtIndex:indexPath.row];
    [cell contentCellWithAddressEntity:entity];
    return cell;
}

- (void)btn_morenAddressAction:(UIButton *)btn{
    
    AddressEntity *entity = [self.arr_adress objectAtIndex:btn.tag];
    [PurchaseHandler setDefaultAddressWithAddressId:[NSNumber numberWithLong:entity._id] prepare:^{
        
    } success:^(id obj) {
        if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
            [self loadData];
        }else{
            [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)btn_deleteAction:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认删除？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddressEntity *entity = [self.arr_adress objectAtIndex:btn.tag];
        [PurchaseHandler deleteAddressWithAddressId:[NSNumber numberWithLong:entity._id] prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                [self.arr_adress removeObjectAtIndex:btn.tag];
                [self.tb_adress reloadData];
            }else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)rightBarAction{
    CreateAddressViewController *vc = [[CreateAddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
