//
//  SearchCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchCommodityViewController.h"
#import "BaseTableView.h"
#import "SearchWithNameTableViewCell.h"
#import "SearchWithCodeTableViewCell.h"
#import "CommodityHandler.h"
#import "LoginStorage.h"
#import "MoreEditView.h"
#import "AddNewCommodityViewController.h"
#import "CommodityViewController.h"
#import "CommodityTableViewCell.h"
#import "PublishCommodityViewController.h"
#import "MoreEditCommodityChildView.h"
#import "CommodityChildViewController.h"

#define NULLROW    999

@interface SearchCommodityViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic, strong) UITextField           *tf_search;
@property (nonatomic, strong) BaseTableView         *tb_search;
@property (nonatomic, strong) NSMutableArray        *arr_search;
@property (nonatomic, strong) NSString              *str_search;

@property (nonatomic ,assign)int               showIndex;
@property (nonatomic ,strong)MoreEditView                             *v_moreEdit;
@property (nonatomic ,strong)MoreEditCommodityChildView               *v_moreChildEdit;

@end

@implementation SearchCommodityViewController
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
    self.tb_search.rowHeight = 129;
    self.tb_search.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tb_search setBackgroundColor:[UIColor whiteColor]];
    
    if (self.searchType == SearchTypeInWareHouse) {
        self.v_moreEdit = [[MoreEditView alloc]initWithFrame:CGRectMake(0, 0, 120, 132)];
        [self.v_moreEdit.btn_mendian addTarget:self action:@selector(btn_mendianAction) forControlEvents:UIControlEventTouchUpInside];
        [self.v_moreEdit.btn_wangdian addTarget:self action:@selector(btn_wangdianAction) forControlEvents:UIControlEventTouchUpInside];
        [self.v_moreEdit.btn_delege addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.v_moreEdit];
        [self.v_moreEdit setHidden:YES];
    }else{
        self.v_moreChildEdit = [[MoreEditCommodityChildView alloc]initWithFrame:CGRectMake(0, 0, 120, 88)];
        [self.v_moreChildEdit.btn_delege addTarget:self action:@selector(v_moreEditdeleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.v_moreChildEdit.btn_edit addTarget:self action:@selector(v_moreEditbtn_editAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.v_moreChildEdit];
        [self.v_moreChildEdit setHidden:YES];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.str_search = toBeString;
    if (![self.str_search isEqualToString:@""]) {
        [self.tb_search requestDataSource];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{

    [CommodityHandler getCommodityListWithtype:[NSNumber numberWithInt:self.searchType] firstCategoryId:nil status:[NSNumber numberWithInt:999] keyword:self.str_search pageNum:(int)pageNum prepare:^{
        
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
    static NSString *CellIdentifier = @"PotentialStoreTableViewCell";
    CommodityTableViewCell *cell = (CommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[CommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:indexPath.row];
    if (self.searchType == SearchTypeInWareHouse) {
        
        [cell contentCellWithCommodityInformationEntity:entity];
    }
    if (self.searchType == SearchTypeInShop) {
        [cell contentCellInShopWithCommodityInformationEntity:entity];
    }
    if (self.searchType == SearchTypeInNetShop) {
        [cell contentCellInNetShopWithCommodityInformationEntity:entity];
    }
    cell.btn_more.tag = indexPath.row;
    cell.btn_edit.tag = indexPath.row;
    [cell.btn_more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_edit addTarget:self action:@selector(edtiAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.showIndex = NULLROW;
    [self.v_moreEdit setHidden:YES];
}

- (void)moreAction:(UIButton *)btn_sender{
    CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:btn_sender.tag];

    if (self.searchType == SearchTypeInWareHouse) {
        if ((int)btn_sender.tag == self.showIndex) {
            [self.v_moreEdit setHidden:YES];
            self.showIndex = NULLROW;
        }else{
            [self.v_moreEdit setHidden:NO];
            self.showIndex = (int)btn_sender.tag;
        }
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        CGRect rect = [btn_sender convertRect:self.view.bounds toView:window];
        if (entity.storeUsing == NO && entity.onlineStoreUsing == NO) {
            [self.v_moreEdit.btn_wangdian setHidden:NO];
            [self.v_moreEdit.btn_mendian setHidden:NO];
            [self.v_moreEdit.btn_delege setHidden:NO];
            [self.v_moreEdit.btn_mendian setFrame:CGRectMake(0, 0, 120, 44)];
            [self.v_moreEdit.btn_wangdian setFrame:CGRectMake(0, 44, 120, 44)];
            [self.v_moreEdit.btn_delege setFrame:CGRectMake(0, 88, 120, 44)];
            [self.v_moreEdit setFrame:CGRectMake(SCREEN_WIDTH - 16 - 120, rect.origin.y + 28, 120, 132)];
        }
        else if (entity.storeUsing == NO && entity.onlineStoreUsing == YES) {
            [self.v_moreEdit.btn_wangdian setHidden:YES];
            [self.v_moreEdit.btn_mendian setHidden:NO];
            [self.v_moreEdit.btn_delege setHidden:NO];
            [self.v_moreEdit.btn_mendian setFrame:CGRectMake(0, 0, 120, 44)];
            [self.v_moreEdit.btn_delege setFrame:CGRectMake(0, 44, 120, 44)];
            [self.v_moreEdit setFrame:CGRectMake(SCREEN_WIDTH - 16 - 120, rect.origin.y + 28, 120, 88)];
        }
        else if (entity.storeUsing == YES && entity.onlineStoreUsing == NO) {
            [self.v_moreEdit.btn_wangdian setHidden:NO];
            [self.v_moreEdit.btn_mendian setHidden:YES];
            [self.v_moreEdit.btn_delege setHidden:NO];
            [self.v_moreEdit.btn_wangdian setFrame:CGRectMake(0, 0, 120, 44)];
            [self.v_moreEdit.btn_delege setFrame:CGRectMake(0, 44, 120, 44)];
            [self.v_moreEdit setFrame:CGRectMake(SCREEN_WIDTH - 16 - 120, rect.origin.y + 28, 120, 88)];
        }
        else{
            [self.v_moreEdit.btn_wangdian setHidden:YES];
            [self.v_moreEdit.btn_mendian setHidden:YES];
            [self.v_moreEdit.btn_delege setHidden:NO];
            [self.v_moreEdit.btn_delege setFrame:CGRectMake(0, 0, 120, 44)];
            [self.v_moreEdit setFrame:CGRectMake(SCREEN_WIDTH - 16 - 120, rect.origin.y + 28, 120, 44)];
        }
    }else{
        if (entity.status == 1) {
            [self.v_moreChildEdit.btn_edit setTitle:@"下架" forState:UIControlStateNormal];
        }else if (entity.status == 2) {
            [self.v_moreChildEdit.btn_edit setTitle:@"下架" forState:UIControlStateNormal];
        }else if (entity.status == 3) {
            [self.v_moreChildEdit.btn_edit setTitle:@"上架" forState:UIControlStateNormal];
        }
        if (self.searchType == 3) {
            [self.v_moreChildEdit.btn_delege setTitle:@"从门店移除" forState:UIControlStateNormal];
        }
        if (self.searchType == 4){
            [self.v_moreChildEdit.btn_delege setTitle:@"从网店移除" forState:UIControlStateNormal];
        }
        if ((int)btn_sender.tag == self.showIndex) {
            [self.v_moreChildEdit setHidden:YES];
            self.showIndex = NULLROW;
        }else{
            [self.v_moreChildEdit setHidden:NO];
            self.showIndex = (int)btn_sender.tag;
        }
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        CGRect rect = [btn_sender convertRect:self.view.bounds toView:window];
        
        [self.v_moreChildEdit setFrame:CGRectMake(SCREEN_WIDTH - 16 - 120, rect.origin.y + 28, 120, 88)];
    }
    
}

- (void)edtiAction:(UIButton *)btn_sender{
    CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:btn_sender.tag];
    if (self.searchType == SearchTypeInWareHouse) {
        AddNewCommodityViewController *vc = [[AddNewCommodityViewController alloc]init];
        vc.comeFrom = @"编辑商品";
        vc.entityInformation = entity;
        [self.navigationController pushViewController:vc animated:YES];
        vc.changeEntity = ^(CommodityFromCodeEntity *entity){
            [self.arr_search replaceObjectAtIndex:btn_sender.tag withObject:entity];
            [self.tb_search reloadData];
        };
    }else{
        if (self.searchType == SearchTypeInShop) {
            //进入门店编辑模式
            PublishCommodityViewController *vc = [[PublishCommodityViewController alloc]init];
            vc.publishCommodityFormType = PublishCommodityFormEdit;
            vc.publishCommodityToShopType = PublishCommodityToShop;
            vc.entityInformation = entity;
            [self.navigationController pushViewController:vc animated:YES];
            vc.changeChildEntity = ^(CommodityFromCodeEntity *entity) {
                [self.arr_search replaceObjectAtIndex:btn_sender.tag withObject:entity];
                [self.tb_search reloadData];
            };
        }
        if (self.searchType == SearchTypeInNetShop) {
            //进入网店编辑模式
            PublishCommodityViewController *vc = [[PublishCommodityViewController alloc]init];
            vc.publishCommodityFormType = PublishCommodityFormEdit;
            vc.publishCommodityToShopType = PublishCommodityToNetShop;
            vc.entityInformation = entity;
            [self.navigationController pushViewController:vc animated:YES];
            vc.changeChildEntity = ^(CommodityFromCodeEntity *entity) {
                [self.arr_search replaceObjectAtIndex:btn_sender.tag withObject:entity];
                [self.tb_search reloadData];
            };
        }
    }
}
#pragma - 商品库商品more按钮操作

- (void)btn_wangdianAction{
    CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:self.showIndex];
    PublishCommodityViewController *vc = [[PublishCommodityViewController alloc]init];
    vc.entityInformation = entity;
    vc.publishCommodityToShopType = PublishCommodityToNetShop;
    [self.navigationController pushViewController:vc animated:YES];
    [self.v_moreEdit setHidden:YES];
}

- (void)btn_mendianAction{
    CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:self.showIndex];
    PublishCommodityViewController *vc = [[PublishCommodityViewController alloc]init];
    vc.entityInformation = entity;
    vc.publishCommodityToShopType = PublishCommodityToShop;
    vc.publishCommodityFormType = PublishCommodityFormPublish;
    [self.navigationController pushViewController:vc animated:YES];
    [self.v_moreEdit setHidden:YES];
}

- (void)deleteAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"被删除的商品会从所有商品库移除，无法恢复。确定要删除所选商品吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.v_moreEdit setHidden:YES];
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:self.showIndex];
        [CommodityHandler commoditydeleteWithCommodityId:[NSString stringWithFormat:@"%@",entity.skuId] prepare:^{
            
        } success:^(id obj) {
            [self.arr_search removeObjectAtIndex:self.showIndex];
            [self.tb_search reloadData];
            self.showIndex = NULLROW;
            [self.v_moreEdit setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma - 门店网店商品more按钮操作


- (void)v_moreEditdeleteAction{
    
    CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:self.showIndex];
    [CommodityHandler wareSkuRemoveWareWithSkuId:entity.skuId releaseType:self.searchType - 2 prepare:^{
        
    } success:^(id obj) {
        [self.arr_search removeObjectAtIndex:self.showIndex];
        [self.tb_search reloadData];
        self.showIndex = NULLROW;
        [self.v_moreEdit setHidden:YES];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)v_moreEditbtn_editAction{
    CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:self.showIndex];
    if (entity.status == 1 || entity.status == 2) {
        //下架方法
        [CommodityHandler wareSkuUpdateStatusWithSkuId:entity.skuId releaseType:self.searchType - 2 status:[NSNumber numberWithInt:3] prepare:^{
            
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
        [CommodityHandler wareSkuUpdateStatusWithSkuId:entity.skuId releaseType:self.searchType - 2 status:[NSNumber numberWithInt:1] prepare:^{
            
        } success:^(id obj) {
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
    if (self.enterFormType == EnterFromActice) {
        CommodityFromCodeEntity *entity = [self.arr_search objectAtIndex:indexPath.row];
        if (self.selectCommodity) {
            self.selectCommodity(entity);
        }
        NSArray *arr_vc = self.navigationController.viewControllers;
        for (NSUInteger index = arr_vc.count - 1; arr_vc >= 0; index--) {
            UIViewController *vc = [arr_vc objectAtIndex:index];
            if (![vc isKindOfClass:[SearchCommodityViewController class]] && ![vc isKindOfClass:[CommodityChildViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
    }
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of onany resources that can be recreated.
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

