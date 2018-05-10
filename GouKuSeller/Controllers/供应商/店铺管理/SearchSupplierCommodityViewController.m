//
//  SearchSupplierCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchSupplierCommodityViewController.h"
#import "MoreEditView.h"
#import "CommodityHandler.h"
#import "SearchWithCodeTableViewCell.h"
#import "SearchWithNameTableViewCell.h"
#import "AddSupplierCommodityViewController.h"

#define NULLROW    999

@interface SearchSupplierCommodityViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic, strong) UITextField           *tf_search;
@property (nonatomic, strong) BaseTableView         *tb_search;
@property (nonatomic, strong) NSMutableArray        *arr_search;
@property (nonatomic, strong) NSString              *str_search;
@property (nonatomic ,assign)int               showIndex;
@property (nonatomic ,strong)MoreEditView                  *v_moreEdit;

@end

@implementation SearchSupplierCommodityViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_search = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)onCreate{
    self.showIndex = NULLROW;
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
    self.tf_search.placeholder = @"输入商品名称、条形码";
    self.tf_search.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
    self.tf_search.textColor = [UIColor blackColor];
    [self.tf_search.layer setCornerRadius:5];
    self.tf_search.layer.masksToBounds = YES;
    self.tf_search.delegate = self;
    self.tf_search.returnKeyType = UIReturnKeySearch;
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
    
    self.tb_search = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain hasHeaderRefreshing:NO hasFooterRefreshing:YES];
    
    [self.view addSubview:self.tb_search];
    self.tb_search.dataSource = self;
    self.tb_search.delegate = self;
    self.tb_search.tableViewDelegate = self;
    self.tb_search.rowHeight = 149;
    self.tb_search.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tb_search setBackgroundColor:[UIColor whiteColor]];
    
    self.v_moreEdit = [[MoreEditView alloc]initWithFrame:CGRectMake(0, 0, 120, 88)];
    [self.v_moreEdit.btn_delege addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_moreEdit.btn_xiajia addTarget:self action:@selector(xiaJiaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v_moreEdit];
    [self.v_moreEdit setHidden:YES];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.str_search = toBeString;
    [self.tb_search requestDataSource];
    return YES;
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{

    [CommodityHandler selectSupplierCommodityListWithKeyword:self.str_search status:nil firstCategoryId:nil page:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        NSArray *arrdata = (NSArray *)obj;
        if (arrdata.count > 0) {
            
            [self.arr_search removeAllObjects];
        }
        [self.arr_search addObjectsFromArray:arrdata];
        [self.tb_search reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_search.count == 0) {
            self.tb_search.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_search.frame withDefaultImage:nil withNoteTitle:@"未找到相关商品" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_search.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SupplierCommodityEndity *entity = [self.arr_search objectAtIndex:indexPath.row];
    if (entity.hitType == 1 || entity.hitType == 2) {
        
        static NSString *CellIdentifier = @"SearchWithCodeTableViewCell";
        SearchWithCodeTableViewCell *cell = (SearchWithCodeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[SearchWithCodeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.lab_CommodityUnit setHidden:NO];
        cell.btn_more.tag = indexPath.row;
        [cell.btn_more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn_edit.tag = indexPath.row;
        [cell.btn_edit addTarget:self action:@selector(edtiAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell contentCellWithSupplierCommodityEndity:entity];
        
        return cell;
    }
    if (entity.hitType == 3) {
        static NSString *CellIdentifier = @"SearchWithNameTableViewCell";
        SearchWithNameTableViewCell *cell = (SearchWithNameTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[SearchWithNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.lab_CommodityUnit setHidden:NO];
        cell.btn_more.tag = indexPath.row;
        [cell.btn_more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn_edit.tag = indexPath.row;
        [cell.btn_edit addTarget:self action:@selector(edtiAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell contentCellWithSupplierCommodityEndity:entity];
        
        return cell;
    }
    
    return NULL;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.showIndex = NULLROW;
    [self.v_moreEdit setHidden:YES];
}

- (void)moreAction:(UIButton *)btn_sender{
    SupplierCommodityEndity *entity = [self.arr_search objectAtIndex:btn_sender.tag];
    if (entity.status == 1) {
        [self.v_moreEdit.btn_xiajia setTitle:@"下架" forState:UIControlStateNormal];
    }else if (entity.status == 2) {
        [self.v_moreEdit.btn_xiajia setTitle:@"下架" forState:UIControlStateNormal];
    }else if (entity.status == 3) {
        [self.v_moreEdit.btn_xiajia setTitle:@"上架" forState:UIControlStateNormal];
    }
    if ((int)btn_sender.tag == self.showIndex) {
        [self.v_moreEdit setHidden:YES];
        self.showIndex = NULLROW;
    }else{
        [self.v_moreEdit setHidden:NO];
        self.showIndex = (int)btn_sender.tag;
    }
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [btn_sender convertRect:self.view.bounds toView:window];
    
    [self.v_moreEdit setFrame:CGRectMake(SCREEN_WIDTH - 16 - 120, rect.origin.y + 28, 120, 88)];
}

- (void)edtiAction:(UIButton *)btn_sender{
    SupplierCommodityEndity *entityDemo = [self.arr_search objectAtIndex:btn_sender.tag];
    AddSupplierCommodityViewController *vc = [[AddSupplierCommodityViewController alloc]init];
    vc.comeFrom = @"编辑商品";
    vc.hitType = entityDemo.hitType;
    vc.skuId = entityDemo.skuId;
    [self.navigationController pushViewController:vc animated:YES];
    vc.changeEntity = ^(SupplierCommodityEndity *entity) {
        [self.arr_search replaceObjectAtIndex:btn_sender.tag withObject:entity];
        [self.tb_search reloadData];
    };
}

- (void)deleteAction{
    SupplierCommodityEndity *entity = [self.arr_search objectAtIndex:self.showIndex];
    [CommodityHandler deleteSupplierCommodityWithCommodityId:entity.skuId prepare:^{
        
    } success:^(id obj) {
        [self.arr_search removeObjectAtIndex:self.showIndex];
        [self.tb_search reloadData];
        self.showIndex = NULLROW;
        [self.v_moreEdit setHidden:YES];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)xiaJiaAction{
    SupplierCommodityEndity *entity = [self.arr_search objectAtIndex:self.showIndex];
    if (entity.status == 1 || entity.status == 2) {
        //下架方法
        [CommodityHandler updateSupplierCommodityStatusWithCommodityId:entity.skuId type:[NSNumber numberWithInt:0] prepare:^{
            
        } success:^(id obj) {
            [self.arr_search removeObjectAtIndex:self.showIndex];
            [self.tb_search reloadData];
            self.showIndex = NULLROW;
            [self.v_moreEdit setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }else if (entity.status == 3){
        //上架方法
        [CommodityHandler updateSupplierCommodityStatusWithCommodityId:entity.skuId type:[NSNumber numberWithInt:1] prepare:^{
            
        } success:^(id obj) {
            [self.arr_search removeObjectAtIndex:self.showIndex];
            [self.tb_search reloadData];
            self.showIndex = NULLROW;
            [self.v_moreEdit setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tf_search resignFirstResponder];
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
