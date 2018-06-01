//
//  SupplierCommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierCommodityViewController.h"
#import "BtnTop.h"
#import "ManagementClassificationViewController.h"
#import "BaseTableView.h"
#import "CommodityHandler.h"
#import "ShopClassificationEntity.h"
#import "StoreCategoryTableViewCell.h"
#import "CommodityTableViewCell.h"
#import "AddSupplierCommodityViewController.h"
#import "LoginStorage.h"
#import "RTHttpClient.h"
#import "CommodityBottomView.h"
#import "ManagerCommodityTableViewCell.h"
#import "MoveCommodityView.h"
#import "CommodityStatusView.h"
#import "MoreEditView.h"
#import "MoreAddCommodityViewController.h"
#import "SupplierCommodityEndity.h"
#import "SupplierCommodityListTableViewCell.h"
#import "SearchSupplierCommodityViewController.h"

#define NULLROW    999

@interface SupplierCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate,UITextFieldDelegate>

@property (nonatomic ,strong)UIButton         *btn_top;
@property (nonatomic ,strong)UIView           *view_bottom;
@property (nonatomic ,strong)UIButton         *btn_managementClassification;
@property (nonatomic ,strong)UIButton         *btn_buildCommodity;
@property (nonatomic ,strong)UIImageView      *img_shu;

@property (nonatomic ,strong)BaseTableView    *tb_left;
@property (nonatomic ,strong)BaseTableView    *tb_right;
@property (nonatomic ,strong)NSMutableArray   *arr_category;
@property (nonatomic ,strong)NSMutableArray   *arr_commodity;

@property (nonatomic ,assign)int               selectedSection;
@property (nonatomic ,assign)int               selectedRow;

@property (nonatomic ,strong)UIButton         *btn_navright_search;
@property (nonatomic ,strong)UIButton         *btn_navright_more;
@property (nonatomic ,assign)int               showIndex;
@property (nonatomic ,strong)UIButton         *btn_batchManager;

@property (nonatomic ,strong)CommodityBottomView           *v_bottom_manager;
@property (nonatomic ,assign)BOOL              editStatus;
@property (nonatomic ,strong)NSMutableArray    *arr_selected;
@property (nonatomic ,strong)UILabel           *lb_selectedNum;
@property (nonatomic ,strong)UIView            *v_coverLeft;
@property (nonatomic ,strong)CommodityStatusView           *v_commodityStatusView;
@property (nonatomic ,strong)MoreEditView                  *v_moreEdit;

@property (nonatomic ,strong)NSNumber          *btnIndex;

@property (nonatomic ,strong)UIAlertController *alertController;

@end

@implementation SupplierCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.btn_top = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 44)];
    [self.btn_top setTitle:@"全部商品" forState:UIControlStateNormal];
    [self.btn_top setImage:[UIImage imageNamed:@"triangle_down_white"] forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    self.navigationItem.titleView = self.btn_top;
    [self.btn_top addTarget:self action:@selector(btn_topAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(searchBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"home_search"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)setNavUI{
    if (self.editStatus == NO) {
        self.navigationItem.titleView = self.btn_top;
        UIBarButtonItem *pulish = [[UIBarButtonItem alloc] initWithCustomView:self.btn_navright_search];
        UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:self.btn_navright_more];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:save, pulish,nil]];
        [self.v_coverLeft setHidden:YES];
    }else{
        self.lb_selectedNum.text = [NSString stringWithFormat:@"已选择%ld件商品",self.arr_selected.count];
        self.navigationItem.titleView = self.lb_selectedNum;
        UIBarButtonItem *confirm = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction)];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:confirm,nil]];
        [self.v_coverLeft setHidden:NO];
    }
}

- (void)onCreate{
    self.selectedRow = NULLROW;
    self.selectedSection = NULLROW;
    self.showIndex = NULLROW;
    
    self.arr_category = [NSMutableArray array];
    self.arr_commodity = [NSMutableArray array];
    self.arr_selected = [NSMutableArray array];
    
    self.view_bottom = [[UIView alloc]init];
    [self.view addSubview:self.view_bottom];
    [self.view_bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT - 50 - SafeAreaBottomHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    self.view_bottom.layer.shadowColor = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;//shadowColor阴影颜色
    self.view_bottom.layer.shadowOffset = CGSizeMake(0,-3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.view_bottom.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.view_bottom.layer.shadowRadius = 4;//阴影半径，默认3
    
    self.btn_managementClassification = [[UIButton alloc]init];
    [self.view_bottom addSubview:self.btn_managementClassification];
    [self.btn_managementClassification setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_managementClassification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
        make.height.mas_equalTo(50);
    }];
    [self.btn_managementClassification setTitle:@"管理分类" forState:UIControlStateNormal];
    [self.btn_managementClassification setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
    [self.btn_managementClassification setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    self.btn_managementClassification.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.btn_managementClassification addTarget:self action:@selector(btn_managementClassificationAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.img_shu = [[UIImageView alloc]init];
    [self.view_bottom addSubview:self.img_shu];
    [self.img_shu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
        make.height.equalTo(self.btn_managementClassification);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
    [self.img_shu setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    
    
    self.btn_buildCommodity = [[UIButton alloc]init];
    [self.view_bottom addSubview:self.btn_buildCommodity];
    [self.btn_buildCommodity setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_buildCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SCREEN_WIDTH / 2);
        make.width.mas_equalTo(SCREEN_WIDTH / 2 - 0.5);
        make.height.mas_equalTo(50);
    }];
    [self.btn_buildCommodity setTitle:@"新建商品" forState:UIControlStateNormal];
    [self.btn_buildCommodity setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.btn_buildCommodity setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    self.btn_buildCommodity.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.btn_buildCommodity addTarget:self action:@selector(btn_buildCommodityAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tb_left = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_left.dataSource = self;
    self.tb_left.delegate = self;
    self.tb_left.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_left.tableViewDelegate = self;
    self.tb_left.hideErrorBackView = YES;
    [self.view addSubview:self.tb_left];
    
    self.tb_right = [[BaseTableView alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight,SCREEN_WIDTH - 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    self.tb_right.dataSource = self;
    self.tb_right.delegate = self;
    self.tb_right.tableViewDelegate = self;
    self.tb_right.hideErrorBackView = YES;
    self.tb_right.separatorColor = [UIColor clearColor];
    self.tb_right.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tb_right];
    
    
    self.v_commodityStatusView = [[CommodityStatusView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight)];
    [self.view addSubview:self.v_commodityStatusView];
    [self.v_commodityStatusView.btn_all addTarget:self action:@selector(btn_allAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView.btn_chushou addTarget:self action:@selector(btn_chushouAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView.btn_shouwan addTarget:self action:@selector(btn_shouwanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView.btn_xiajia addTarget:self action:@selector(btn_xiajiaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView setHidden:YES];
    
    UITapGestureRecognizer *tgp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(statusViewDissmiss)];
    [self.v_commodityStatusView addGestureRecognizer:tgp];
    
    self.v_moreEdit = [[MoreEditView alloc]initWithFrame:CGRectMake(0, 0, 120, 88)];
    [self.v_moreEdit.btn_delege addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_moreEdit.btn_xiajia addTarget:self action:@selector(xiaJiaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v_moreEdit];
    [self.v_moreEdit setHidden:YES];
    
    self.btnIndex = [NSNumber numberWithInt:0];
    [self loadData];
    
}

- (void)btn_managementClassificationAction{
    ManagementClassificationViewController *vc
    = [[ManagementClassificationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.updateCateGory = ^{
        [self loadData];
    };
}

- (void)btn_buildCommodityAction{
    
    self.alertController = [UIAlertController alertControllerWithTitle:nil message:@"输入条形码" preferredStyle:UIAlertControllerStyleAlert];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = self.alertController.textFields.firstObject;
        NSLog(@"条形码 = %@",userNameTextField.text);
        if (![userNameTextField.text isEqualToString:@""]) {
            [CommodityHandler getCommodityInformationWithBarCode:userNameTextField.text prepare:nil success:^(id obj) {
                NSDictionary *dic = (NSDictionary *)obj;
                if ([[dic objectForKey:@"errCode"] intValue] == 0) {
                    CommodityFromCodeEntity *entity = [CommodityFromCodeEntity parseCommodityFromCodeEntityWithJson:[dic objectForKey:@"data"]];
                    AddSupplierCommodityViewController *vc = [[AddSupplierCommodityViewController alloc]init];
                    vc.comeFrom = @"新建商品";
                    vc.entityInformation = entity;
                    [self.navigationController pushViewController:vc animated:YES];
                    vc.addCommodityFinish = ^{
                        [self btn_buildCommodityAction];
                    };
                }else{
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showErrorMessage:[dic objectForKey:@"errMessage"]];
                    [self btn_buildCommodityAction];
                }
            } failed:^(NSInteger statusCode, id json) {
                [MBProgressHUD showErrorMessage:(NSString *)json];
            }];
        }else{
            [MBProgressHUD showInfoMessage:@"请输入条形码"];
        }
    }]];
    //定义第一个输入框；
    [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.delegate = self;
    }];
    [self presentViewController:self.alertController animated:true completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (![textField.text isEqualToString:@""]) {
        [self.alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
        [CommodityHandler getCommodityInformationWithBarCode:textField.text prepare:nil success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            if ([[dic objectForKey:@"errCode"] intValue] == 0) {
                CommodityFromCodeEntity *entity = [CommodityFromCodeEntity parseCommodityFromCodeEntityWithJson:[dic objectForKey:@"data"]];
                AddSupplierCommodityViewController *vc = [[AddSupplierCommodityViewController alloc]init];
                vc.comeFrom = @"新建商品";
                vc.entityInformation = entity;
                [self.navigationController pushViewController:vc animated:YES];
                vc.addCommodityFinish = ^{
                    [self btn_buildCommodityAction];
                };
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[dic objectForKey:@"errMessage"]];
                [self btn_buildCommodityAction];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }else{
        [MBProgressHUD showInfoMessage:@"请输入条形码"];
    }
    return YES;
}
//门店分类列表
- (void)loadData{
    
    [CommodityHandler getCommodityCategoryWithShopId:[[LoginStorage GetShopId] stringValue] prepare:nil success:^(id obj) {
        NSArray *arr_data = (NSArray *)obj;
        [self.arr_category removeAllObjects];
        [self.arr_category addObjectsFromArray:arr_data];
        self.selectedSection = 0;
        self.selectedRow = NULLROW;
        [self.tb_left reloadData];
        [self.tb_right requestDataSource];
    } failed:^(NSInteger statusCode, id json) {
        
        [MBProgressHUD showErrorMessage:(NSString *)json];
        
    }];
    
}

#pragma uitableview

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    if (self.arr_category.count <= self.selectedSection) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        return;
    }
    ShopClassificationEntity *entity = [self.arr_category objectAtIndex:self.selectedSection];
    if (self.selectedRow != NULLROW) {
        entity = [entity.childList objectAtIndex:self.selectedRow];
    }
    
    [CommodityHandler selectSupplierCommodityListWithKeyword:nil status:self.btnIndex firstCategoryId:[NSNumber numberWithInteger:entity._id] page:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_commodity removeAllObjects];
        }
        [self.arr_commodity addObjectsFromArray:(NSArray *)obj];
        [self.tb_right reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_commodity.count == 0) {
            self.tb_right.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_right.frame withDefaultImage:nil withNoteTitle:@"暂无数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_left) {
        return 55;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_left) {
        UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 55)];
        v_header.userInteractionEnabled = YES;
        v_header.tag = section;
        [v_header addTappedWithTarget:self action:@selector(selectCategory:)];
        UILabel  *lab_categoryName = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 55)];
        [v_header addSubview:lab_categoryName];
        lab_categoryName.font = [UIFont systemFontOfSize:14];
        [lab_categoryName setTextColor:[UIColor colorWithHexString:@"#616161"]];
        
        UIImageView *img_shu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 4, 55)];
        [v_header addSubview:img_shu];
        [img_shu setBackgroundColor:[UIColor colorWithHexString:@"#4167b2"]];
        
        UIImageView *iv_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(100 - 11 - 9, 55/2 - 11/2, 11, 7)];
        [v_header addSubview:iv_arrow];
        
        ShopClassificationEntity *entity = [self.arr_category objectAtIndex:section];
        lab_categoryName.text = entity.name;
        if (self.selectedSection == section && self.selectedRow == NULLROW && entity.childList.count == 0) {
            [img_shu setHidden:NO];
            [lab_categoryName setTextColor:[UIColor colorWithHexString:@"#4167b2"]];
            [v_header setBackgroundColor:[UIColor whiteColor]];
        }else{
            [img_shu setHidden:YES];
            [lab_categoryName setTextColor:[UIColor colorWithHexString:@"#616161"]];
            [v_header setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        }
        
        if (entity.isShow == YES) {
            [iv_arrow setImage:[UIImage imageNamed:@"up_icon"]];
        }else{
            UIImage *im_arrow = [UIImage imageNamed:@"up_icon"];
            [iv_arrow setImage:[self image:im_arrow rotation:UIImageOrientationDown]];
        }
        
        if (entity.childList.count == 0) {
            [iv_arrow setHidden:YES];
        }else{
            [iv_arrow setHidden:NO];
        }
        
        return v_header;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tb_left) {
        return 55;
    }else{
        if (self.editStatus == YES) {
            return 97;
        }else{
            return 142;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tb_left) {
        ShopClassificationEntity *entity = [self.arr_category objectAtIndex:section];
        if (entity.isShow == YES) {
            return entity.childList.count;
        }else{
            return 0;
        }
    }else if (tableView == self.tb_right){
        return self.arr_commodity.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tb_left) {
        return self.arr_category.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tb_left == tableView) {
        static NSString *CellIdentifier = @"StoreCategoryTableViewCell";
        StoreCategoryTableViewCell *cell = (StoreCategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[StoreCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ShopClassificationEntity *entity = [self.arr_category objectAtIndex:indexPath.section];
        ShopClassificationEntity *entity_small = [entity.childList objectAtIndex:indexPath.row];
        cell.lab_categoryName.text = entity_small.name;
        if (self.selectedRow == indexPath.row && self.selectedSection == indexPath.section) {
            [cell.img_shu setHidden:NO];
            cell.backgroundColor = [UIColor whiteColor];
            [cell.lab_categoryName setTextColor:[UIColor colorWithHexString:@"#4167b2"]];
        }else{
            [cell.img_shu setHidden:YES];
            cell.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
            [cell.lab_categoryName setTextColor:[UIColor colorWithHexString:@"#616161"]];
        }
        return cell;
    }else if(self.tb_right == tableView){
        if (self.editStatus == YES) {
            static NSString *CellIdentifier = @"ManagerCommodityTableViewCell";
            ManagerCommodityTableViewCell *cell = (ManagerCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell){
                cell = [[ManagerCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
            [cell contentCellWithCommodityInformationEntity:entity];
            if ([self.arr_selected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]) {
                cell.btn_select.selected = YES;
            }else{
                cell.btn_select.selected = NO;
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"PotentialStoreTableViewCell";
            SupplierCommodityListTableViewCell *cell = (SupplierCommodityListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell){
                cell = [[SupplierCommodityListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            SupplierCommodityEndity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
            [cell contentCellWithSupplierCommodityEndity:entity];
            cell.btn_more.tag = indexPath.row;
            cell.btn_edit.tag = indexPath.row;
            [cell.btn_more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn_edit addTarget:self action:@selector(edtiAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.showIndex = NULLROW;
    [self.v_moreEdit setHidden:YES];
    if (tableView == self.tb_left) {
        self.selectedSection = (int)indexPath.section;
        self.selectedRow = (int)indexPath.row;
        [self.tb_left reloadData];
        //加载右边数据
        [self.tb_right requestDataSource];
    }
}

- (void)selectCategory:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    ShopClassificationEntity *entity = [self.arr_category objectAtIndex:v_sender.tag];
    if (entity.childList.count == 0) {
        self.selectedSection = (int)v_sender.tag;
        self.selectedRow = NULLROW;
        entity.isShow = !entity.isShow;
        [self.arr_category replaceObjectAtIndex:v_sender.tag withObject:entity];
        [self.tb_left reloadData];
        //加载右边数据
        [self.tb_right requestDataSource];
    }else{
        entity.isShow = !entity.isShow;
        [self.arr_category replaceObjectAtIndex:v_sender.tag withObject:entity];
        [self.tb_left reloadData];
    }
}


- (void)moreAction:(UIButton *)btn_sender{
    SupplierCommodityEndity *entity = [self.arr_commodity objectAtIndex:btn_sender.tag];
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
    SupplierCommodityEndity *entityDemo = [self.arr_commodity objectAtIndex:btn_sender.tag];
    AddSupplierCommodityViewController *vc = [[AddSupplierCommodityViewController alloc]init];
    vc.comeFrom = @"编辑商品";
    vc.skuId = entityDemo.skuId;
    [self.navigationController pushViewController:vc animated:YES];
    vc.changeEntity = ^(SupplierCommodityEndity *entity){
        if ([self.btnIndex intValue] == 2) {
            //已售完
            ShopClassificationEntity *shopClassificationEntity = [self.arr_category objectAtIndex:self.selectedSection];
            if (self.selectedRow != NULLROW) {
                shopClassificationEntity = [shopClassificationEntity.childList objectAtIndex:self.selectedRow];
            }
            if (([entity.firstCategoryId longValue] == [entityDemo.firstCategoryId longValue]) || (shopClassificationEntity._id == 0)) {
                if (entityDemo.stock > 0) {
                    [self.arr_commodity removeObjectAtIndex:btn_sender.tag];
                }else{
                    [self.arr_commodity replaceObjectAtIndex:btn_sender.tag withObject:entity];
                }
            }else{
                [self.arr_commodity removeObjectAtIndex:btn_sender.tag];
            }
            [self.tb_right reloadData];
        }else{
            ShopClassificationEntity *shopClassificationEntity = [self.arr_category objectAtIndex:self.selectedSection];
            if (self.selectedRow != NULLROW) {
                shopClassificationEntity = [shopClassificationEntity.childList objectAtIndex:self.selectedRow];
            }
            if (([entity.firstCategoryId longValue] == [entityDemo.firstCategoryId longValue]) || (shopClassificationEntity._id == 0)) {
                [self.arr_commodity replaceObjectAtIndex:btn_sender.tag withObject:entity];
            }else{
                [self.arr_commodity removeObjectAtIndex:btn_sender.tag];
            }
            [self.tb_right reloadData];
        }
        
    };
}

//商品状态选择

- (void)btn_allAction{
    self.btnIndex = [NSNumber numberWithInt:0];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"全部商品" forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.tb_right requestDataSource];
    
}

- (void)btn_chushouAction{
    self.btnIndex = [NSNumber numberWithInt:1];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"出售中" forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.tb_right requestDataSource];
    
}

- (void)btn_shouwanAction{
    self.btnIndex = [NSNumber numberWithInt:2];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"已售罄" forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.tb_right requestDataSource];
}

- (void)btn_xiajiaAction{
    self.btnIndex = [NSNumber numberWithInt:3];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"已下架" forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.tb_right requestDataSource];
    
}
- (void)deleteAction{
    SupplierCommodityEndity *entity = [self.arr_commodity objectAtIndex:self.showIndex];
    [CommodityHandler deleteSupplierCommodityWithCommodityId:entity.skuId prepare:^{
        
    } success:^(id obj) {
        [self.arr_commodity removeObjectAtIndex:self.showIndex];
        [self.tb_right reloadData];
        self.showIndex = NULLROW;
        [self.v_moreEdit setHidden:YES];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)xiaJiaAction{
    SupplierCommodityEndity *entity = [self.arr_commodity objectAtIndex:self.showIndex];
    if (entity.status == 1 || entity.status == 2) {
        //下架方法
        [CommodityHandler updateSupplierCommodityStatusWithCommodityId:entity.skuId type:[NSNumber numberWithInt:0] prepare:^{
            
        } success:^(id obj) {
            [self.arr_commodity removeObjectAtIndex:self.showIndex];
            [self.tb_right reloadData];
            self.showIndex = NULLROW;
            [self.v_moreEdit setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }else if (entity.status == 3){
        //上架方法
        [CommodityHandler updateSupplierCommodityStatusWithCommodityId:entity.skuId type:[NSNumber numberWithInt:1] prepare:^{
            
        } success:^(id obj) {
            [self.arr_commodity removeObjectAtIndex:self.showIndex];
            [self.tb_right reloadData];
            self.showIndex = NULLROW;
            [self.v_moreEdit setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
}
-(void)searchBarAction{
    SearchSupplierCommodityViewController *vc = [[SearchSupplierCommodityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)btn_topAction{
    [self.v_commodityStatusView setHidden:!self.v_commodityStatusView.isHidden];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tb_right) {
        self.showIndex = NULLROW;
        [self.v_moreEdit setHidden:YES];
    }
}

- (void)statusViewDissmiss{
    [self.v_commodityStatusView setHidden:YES];
}



- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
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
