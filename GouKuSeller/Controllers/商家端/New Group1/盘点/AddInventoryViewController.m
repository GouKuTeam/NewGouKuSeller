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
#import "InventoryHandler.h"
#import "InventoryEntity.h"
#import "AddInventoryFooterView.h"
#import "ChangeInventoryNumAlertView.h"

@interface AddInventoryViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITextField                    *tfsousuo;
@property (nonatomic, strong)AddInventoryTabHeaderView      *header;
@property (nonatomic, strong)AddInventoryFooterView         *bottom;
@property (nonatomic ,strong)UITableView                    *tb_commodity;
@property (nonatomic ,strong)NSMutableArray                 *arr_data;
@property (nonatomic ,strong)ChangeInventoryNumAlertView *alert;
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
    
    self.tb_commodity = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 46) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_commodity];
    self.tb_commodity.delegate = self;
    self.tb_commodity.dataSource = self;
    self.tb_commodity.tableFooterView = [UIView new];
    [self.tb_commodity setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    
    self.bottom = [[AddInventoryFooterView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 46, SCREEN_WIDTH, 46)];
    [self.view addSubview:self.bottom];
    [self.bottom.btn_caogao addTarget:self action:@selector(caogaoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom.btn_tijiao addTarget:self action:@selector(tijiaoAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [InventoryHandler selectInventoryWareInventoryInformationWithBarcode:textField.text prepare:^{
        
    } success:^(id obj) {
        if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0 ) {
            InventoryEntity *entity = [InventoryEntity parseInventoryEntityWithJson:[(NSDictionary *)obj objectForKey:@"data"]];
            InventoryEntity *demoEntity = [[InventoryEntity alloc]init];
            int index = 0;
            for (int i = 0; i < self.arr_data.count; i++) {
                InventoryEntity *caseEntity = [self.arr_data objectAtIndex:i];
                if ([caseEntity.skuId longValue] == [entity.skuId longValue]) {
                    demoEntity = caseEntity;
                    index = i;
                }
            }
            if ([demoEntity.skuId longValue] != 0) {
                [MBProgressHUD showInfoMessage:@"已添加该商品"];
            }else{
                [self.arr_data addObject:entity];
            }
            if (self.arr_data.count > 0) {
                self.tb_commodity.tableHeaderView = self.header;
            }else{
                self.tb_commodity.tableHeaderView = [UIView new];
            }
            self.tfsousuo.text = @"";
            [self.tfsousuo becomeFirstResponder];
            [self.tb_commodity reloadData];
            [self getResult];
        }else{
            self.tfsousuo.text = @"";
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
        }

    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
        self.tfsousuo.text = @"";
    }];
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

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
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    InventoryEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    [cell contentCellWithInventoryEntity:entity];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InventoryEntity *entity = [self.arr_data objectAtIndex:indexPath.row];
    self.alert = [[ChangeInventoryNumAlertView alloc]initWithName:entity.name commodirtyCount:entity.inventoryNum];
    [self.alert show];
    self.alert.btn_delete.tag = indexPath.row;
    [self.alert.btn_delete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf);
    self.alert.dismissAlertView = ^(int count) {
        if (count > 0) {
            entity.inventoryNum = count;
            [weakSelf.arr_data replaceObjectAtIndex:indexPath.row withObject:entity];
            [weakSelf.tb_commodity reloadData];
            [weakSelf getResult];
        }
    };
}

- (void)deleteAction:(UIButton *)btn_sender{
    [self.arr_data removeObjectAtIndex:btn_sender.tag];
    [self.tb_commodity reloadData];
    [self getResult];
    [self.tfsousuo becomeFirstResponder];
    [self.alert dismiss];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tfsousuo resignFirstResponder];
}

- (void)caogaoAction{
    NSMutableArray *arrItem = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.arr_data.count; i ++) {
        InventoryEntity *entity = [self.arr_data objectAtIndex:i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:entity.name forKey:@"name"];
        [dic setObject:entity.skuId forKey:@"skuId"];
        [dic setObject:[NSNumber numberWithInt:entity.inventoryNum] forKey:@"inventoryNum"];
        [arrItem addObject:dic];
    }
    if (arrItem.count > 0) {
        [InventoryHandler addInventoryWithTitle:nil status:[NSNumber numberWithInt:0] wares:arrItem prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0 ) {
                [MBProgressHUD showInfoMessage:@"提交成功"];
                [self performSelector:@selector(addInventoryFinishAction) withObject:nil afterDelay:1.5];
            }else if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 1001){
                NSString *str = @"";
                for (int i = 0; i < [[(NSDictionary *)obj objectForKey:@"data"] count]; i++) {
                    int index = [[[(NSDictionary *)obj objectForKey:@"data"] objectAtIndex:i] intValue];
                    if (i == 0) {
                        str = [NSString stringWithFormat:@"%@",[[(NSDictionary *)obj objectForKey:@"data"] objectAtIndex:index]];
                    }else{
                        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"\n",[[(NSDictionary *)obj objectForKey:@"data"] objectAtIndex:index]]];
                    }
                }
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:[(NSDictionary *)obj objectForKey:@"errMessage"] message:str preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:sure];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }else{
        [MBProgressHUD showInfoMessage:@"请先添加需要盘点的商品"];
    }
    
}

- (void)tijiaoAction{
    NSMutableArray *arrItem = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.arr_data.count; i ++) {
        InventoryEntity *entity = [self.arr_data objectAtIndex:i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:entity.name forKey:@"name"];
        [dic setObject:entity.skuId forKey:@"skuId"];
        if (entity.inventoryNum > 0) {
            [dic setObject:[NSNumber numberWithInt:entity.inventoryNum] forKey:@"inventoryNum"];
        }else{
            [MBProgressHUD showInfoMessage:@"请填入盘点数"];
            [arrItem removeAllObjects];
            return;
        }
        [arrItem addObject:dic];
    }
    if (arrItem.count > 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定提交盘点单？" message:@"提交后盘点数量会覆盖库存数量" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *again = [UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [InventoryHandler addInventoryWithTitle:nil status:[NSNumber numberWithInt:1] wares:arrItem prepare:^{
                
            } success:^(id obj) {
                if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0 ) {
                    [MBProgressHUD showInfoMessage:@"提交成功"];
                    [self performSelector:@selector(addInventoryFinishAction) withObject:nil afterDelay:1.5];
                }else if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 1001){
                    NSString *str = @"";
                    for (int i = 0; i < [[(NSDictionary *)obj objectForKey:@"data"] count]; i++) {
                        int index = [[[(NSDictionary *)obj objectForKey:@"data"] objectAtIndex:i] intValue];
                        if (i == 0) {
                            str = [NSString stringWithFormat:@"%@",[[(NSDictionary *)obj objectForKey:@"data"] objectAtIndex:index]];
                        }else{
                            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"\n",[[(NSDictionary *)obj objectForKey:@"data"] objectAtIndex:index]]];
                        }
                    }
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[(NSDictionary *)obj objectForKey:@"errMessage"] message:str preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:sure];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                else{
                    [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
                }
            } failed:^(NSInteger statusCode, id json) {
                [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
            }];
        }];
        [alert addAction:forgetPassword];
        [alert addAction:again];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [MBProgressHUD showInfoMessage:@"请先添加需要盘点的商品"];
    }
}

- (void)getResult{
    int inventoryNum = 0;
    for (InventoryEntity *entity in self.arr_data) {
        inventoryNum = inventoryNum + entity.inventoryNum;
    }
    [self.bottom.lab_totalNum setText:[NSString stringWithFormat:@"%d",inventoryNum]];
}

- (void)addInventoryFinishAction{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.addInventoryFinish) {
        self.addInventoryFinish();
    }
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
