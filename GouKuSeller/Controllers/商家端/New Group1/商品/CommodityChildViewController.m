//
//  CommodityChildViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityChildViewController.h"
#import "CommodityStatusView.h"
#import "MoreEditCommodityChildView.h"
#import "CommodityHandler.h"
#import "ShopClassificationEntity.h"
#import "StoreCategoryTableViewCell.h"
#import "CommodityTableViewCell.h"
#import "ManagerCommodityTableViewCell.h"
#import "CommodityChildBottomView.h"
#import "CommodityBottomView.h"
#import "PublishCommodityViewController.h"
#import "NSString+Size.h"
#import "SearchCommodityViewController.h"

#define NULLROW    999
@interface CommodityChildViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate,UITextFieldDelegate>

@property (nonatomic ,strong)UIView           *v_top;
@property (nonatomic ,strong)UIButton         *btn_top;
@property (nonatomic ,strong)UIButton         *btn_search;
@property (nonatomic ,strong)UIButton         *btn_more;
@property (nonatomic ,strong)UIButton         *confirm;
@property (nonatomic ,strong)UIButton         *btn_batchManager;
@property (nonatomic ,strong)NSNumber         *btnIndex;
@property (nonatomic ,strong)UILabel          *lb_selectedNum;
@property (nonatomic ,strong)UIView           *v_coverLeft;
@property (nonatomic ,strong)UISegmentedControl *segmentedControl;
@property (nonatomic ,assign)BOOL              editStatus;

@property (nonatomic ,strong)NSMutableArray   *arr_category;
@property (nonatomic ,strong)NSMutableArray   *arr_selected;
@property (nonatomic ,strong)NSMutableArray   *arr_commodity;
@property (nonatomic ,strong)NSMutableArray   *commodityArr;


@property (nonatomic ,strong)BaseTableView    *tb_left;
@property (nonatomic ,strong)BaseTableView    *tb_right;

@property (nonatomic ,assign)int               selectedSection;
@property (nonatomic ,assign)int               selectedRow;
@property (nonatomic ,assign)int               showIndex;

@property (nonatomic ,strong)CommodityStatusView           *v_commodityStatusView;
@property (nonatomic ,strong)MoreEditCommodityChildView    *v_moreEdit;
@property (nonatomic ,strong)CommodityChildBottomView      *v_bottom_manager;

@property (nonatomic ,assign)int               commodityType;

@end

@implementation CommodityChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 200, 44)];
    [v_header setBackgroundColor:[UIColor clearColor]];
    UILabel *lab_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, v_header.frame.size.width, 44)];
    [lab_title setTextColor:[UIColor whiteColor]];
    [lab_title setFont:[UIFont boldSystemFontOfSize:18]];
    lab_title.textAlignment = NSTextAlignmentCenter;
    [v_header addSubview:lab_title];
    [lab_title setText:@"门店商品"];
    
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"网店商品",@"门店商品",nil];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH - 160, 30);
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.layer.masksToBounds = YES;
    self.segmentedControl.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.segmentedControl.layer.borderWidth = 1;
    self.segmentedControl.layer.cornerRadius = 4;
    self.segmentedControl.tintColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4167b2"]} forState:UIControlStateSelected];
    [self.segmentedControl setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#38393e"]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segmentedControl setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#ffffff"]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:)forControlEvents:UIControlEventValueChanged];
    if (self.commodityChildEnterFormController == CommodityChildEnterFormCommodity) {
        
        self.navigationItem.titleView = self.segmentedControl;
    }else{
        self.navigationItem.titleView = v_header;
    }
    if (self.commodityChildFormType == CommodityChildFormNetShop) {
        self.segmentedControl.selectedSegmentIndex = 0;
    }
    if (self.commodityChildFormType == CommodityChildFormShop) {
        self.segmentedControl.selectedSegmentIndex = 1;
    }
//    if (self.commodityChildEnterFormController == CommodityChildEnterFormActive) {
//        segmentedControl.enabled = NO;
//    }else{
//        segmentedControl.enabled = YES;
//    }

}

- (void)onCreate{
    
    if (self.commodityChildFormType == CommodityChildFormShop) {
        self.commodityType = 3;
    }
    if (self.commodityChildFormType == CommodityChildFormNetShop) {
        self.commodityType = 4;
    }
    self.selectedRow = NULLROW;
    self.selectedSection = NULLROW;
    self.showIndex = NULLROW;
    
    self.arr_category = [NSMutableArray array];
    self.arr_commodity = [NSMutableArray array];
    self.arr_selected = [NSMutableArray array];
    self.commodityArr = [NSMutableArray array];
    
    self.v_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
    [self.view addSubview:self.v_top];
    [self.v_top setBackgroundColor:[UIColor colorWithHexString:COLOR_Main]];
    
    self.btn_search = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 55 - 24, 9.5, 24, 24)];
    [self.v_top addSubview:self.btn_search];
    [self.btn_search setBackgroundImage:[UIImage imageNamed:@"search_white"] forState:UIControlStateNormal];
    [self.btn_search addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_more = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 24 - 13, 9.5, 24, 24)];
    [self.v_top addSubview:self.btn_more];
    [self.btn_more setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.btn_more addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 13, 9.5, 40, 24)];
    [self.v_top addSubview:self.confirm];
    [self.confirm setTitle:@"完成" forState:UIControlStateNormal];
    [self.confirm addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.confirm.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.confirm setHidden:YES];
    
    self.btn_top = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2, 9.5, 100, 25)];
    [self.v_top addSubview:self.btn_top];
    [self.btn_top setTitle:@"全部商品" forState:UIControlStateNormal];
    [self.btn_top setImage:[UIImage imageNamed:@"triangle_down_white"] forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    self.navigationItem.titleView = self.btn_top;
    [self.btn_top addTarget:self action:@selector(btn_topAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tb_left = [[BaseTableView alloc]initWithFrame:CGRectMake(0,self.v_top.bottom, 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 43) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_left.dataSource = self;
    self.tb_left.delegate = self;
    self.tb_left.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_left.tableViewDelegate = self;
    self.tb_left.hideErrorBackView = YES;
    [self.view addSubview:self.tb_left];
    
    self.tb_right = [[BaseTableView alloc]initWithFrame:CGRectMake(100, self.v_top.bottom,SCREEN_WIDTH - 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 43) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_right.dataSource = self;
    self.tb_right.delegate = self;
    self.tb_right.tableViewDelegate = self;
    self.tb_right.hideErrorBackView = YES;
    self.tb_right.separatorColor = [UIColor clearColor];
    self.tb_right.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tb_right];
    
    self.v_commodityStatusView = [[CommodityStatusView alloc]initWithFrame:CGRectMake(0, self.v_top.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight)];
    [self.view addSubview:self.v_commodityStatusView];
    [self.v_commodityStatusView.btn_chushou addTarget:self action:@selector(btn_chushouAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView.btn_shouwan addTarget:self action:@selector(btn_shouwanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView.btn_xiajia addTarget:self action:@selector(btn_xiajiaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView.btn_all addTarget:self action:@selector(btn_allAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_commodityStatusView setHidden:YES];
    
    self.v_moreEdit = [[MoreEditCommodityChildView alloc]initWithFrame:CGRectMake(0, 0, 120, 88)];
    [self.v_moreEdit.btn_delege addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_moreEdit.btn_edit addTarget:self action:@selector(btn_editAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v_moreEdit];
    [self.v_moreEdit setHidden:YES];
    
    self.btn_batchManager = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 136, self.v_top.bottom, 120, 44)];
    [self.view addSubview:self.btn_batchManager];
    [self.btn_batchManager setTitle:@"批量操作" forState:UIControlStateNormal];
    self.btn_batchManager.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_batchManager setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];
    [self.btn_batchManager setHidden:YES];
    self.btn_batchManager.clipsToBounds = YES;
    self.btn_batchManager.layer.cornerRadius = 3;
    self.btn_batchManager.layer.masksToBounds = YES;
    self.btn_batchManager.layer.borderColor = [[UIColor colorWithHexString:@"#d8d8d8"] CGColor];
    [self.btn_batchManager setBackgroundColor:[UIColor whiteColor]];
    self.btn_batchManager.layer.borderWidth = 0.5;
    [self.btn_batchManager addTappedWithTarget:self action:@selector(btn_batchManagerAction)];
    
    self.btnIndex = [NSNumber numberWithInt:999];
    [self loadData];
    
//    self.lb_selectedNum = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH - 100, 44)];
//    [self.lb_selectedNum setTextAlignment:NSTextAlignmentCenter];
//    [self.lb_selectedNum setFont:[UIFont systemFontOfSize:18]];
//    [self.lb_selectedNum setTextColor:[UIColor whiteColor]];
    
//    self.v_coverLeft = [[UIView alloc]initWithFrame:self.tb_left.frame];
//    [self.v_coverLeft setBackgroundColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.3]];
//    [self.view addSubview:self.v_coverLeft];
    
    self.v_bottom_manager = [[CommodityChildBottomView alloc]initWithFrame:CGRectMake(0, self.tb_right.bottom -  49, SCREEN_WIDTH, 49)];
    [self.view addSubview:self.v_bottom_manager];
    [self.v_bottom_manager setBackgroundColor:[UIColor whiteColor]];
    [self.v_bottom_manager setHidden:YES];
    [self.v_bottom_manager.btn_bottom_allSelect addTarget:self action:@selector(btn_bottom_allSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottom_manager.btn_bottom_yichu addTarget:self action:@selector(btn_bottom_yichuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottom_manager.btn_bottom_shangjia addTarget:self action:@selector(btn_bottom_shangjia) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottom_manager.btn_bottom_xiajia addTarget:self action:@selector(btn_bottom_xiajia) forControlEvents:UIControlEventTouchUpInside];
    if (self.commodityType == 3) {
        [self.v_bottom_manager.btn_bottom_yichu setTitle:@"从门店移除" forState:UIControlStateNormal];
    }
    if (self.commodityType == 4) {
        [self.v_bottom_manager.btn_bottom_yichu setTitle:@"从网店移除" forState:UIControlStateNormal];
    }
    
    [self setNavUI];
}

//门店分类列表
- (void)loadData{
    
//    [CommodityHandler getCommodityCategoryWithShopId:[LoginStorage GetShopId] prepare:nil success:^(id obj) {
//        NSArray *arr_data = (NSArray *)obj;
//        [self.arr_category removeAllObjects];
//        [self.arr_category addObjectsFromArray:arr_data];
//        self.selectedSection = 0;
//        self.selectedRow = NULLROW;
//        [self.tb_left reloadData];
//        [self.tb_right requestDataSource];
//    } failed:^(NSInteger statusCode, id json) {
//
//        [MBProgressHUD showErrorMessage:(NSString *)json];
//
//    }];
//
    [CommodityHandler getCommodityCategoryWithType:self.commodityType - 2 prepare:^{
        
    } success:^(id obj) {
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

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    if (self.arr_category.count <= self.selectedSection) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        return;
    }
    //    ShopClassificationEntity *entity = [self.arr_category objectAtIndex:self.selectedSection];
    //    if (self.selectedRow != NULLROW) {
    //        entity = [entity.childList objectAtIndex:self.selectedRow];
    //    }
    ShopClassificationEntity *entity = [self.arr_category objectAtIndex:self.selectedSection];
    if (self.selectedRow != NULLROW) {
        entity = [entity.childList objectAtIndex:self.selectedRow];
    }
    
    [CommodityHandler getCommodityListWithtype:[NSNumber numberWithInt:self.commodityType] firstCategoryId:[NSNumber numberWithInteger:entity._id] status:self.btnIndex keyword:nil pageNum:(int)pageNum prepare:^{
        
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

#pragma mark - UISegmentedControl
- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    if (self.commodityChildEnterFormController == CommodityChildEnterFormCommodity) {
        if (sender.selectedSegmentIndex == 0) {
            NSLog(@"网店商品");
            self.commodityType = 4;
        } else {
            NSLog(@"门店商品");
            self.commodityType = 3;
        }
        if (self.editStatus == YES) {
            if (self.commodityType == 3) {
                [self.v_bottom_manager.btn_bottom_yichu setTitle:@"从门店移除" forState:UIControlStateNormal];
            }
            if (self.commodityType == 4) {
                [self.v_bottom_manager.btn_bottom_yichu setTitle:@"从网店移除" forState:UIControlStateNormal];
            }
        }
        if (self.editStatus == YES) {
            [self.arr_selected removeAllObjects];
            self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
        }
        [self loadData];
    }
}

#pragma mark - UITableviewDelege

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
        
        if(self.selectedSection == section && self.selectedRow == NULLROW){
            [img_shu setHidden:NO];
            [lab_categoryName setTextColor:[UIColor colorWithHexString:@"#4167b2"]];
            [v_header setBackgroundColor:[UIColor whiteColor]];
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
            CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
            CGFloat width = SCREEN_WIDTH - 100 - 86;
            CGFloat nameHeight = [entity.name fittingLabelHeightWithWidth:width andFontSize:[UIFont boldSystemFontOfSize:16]];
            CGFloat stockHeight = [[NSString stringWithFormat:@"库存%@",entity.stock] fittingLabelHeightWithWidth:width andFontSize:[UIFont systemFontOfSize:13]];
            CGFloat priceHeight = [[NSString stringWithFormat:@"￥%.2f",[entity.price doubleValue]] fittingLabelHeightWithWidth:width andFontSize:[UIFont systemFontOfSize:16]];
            return 12 + nameHeight +7 + stockHeight  +7 + priceHeight + 10 + 28 + 10;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(self.tb_right == tableView){
        if (self.editStatus == YES) {
            static NSString *CellIdentifier = @"ManagerCommodityTableViewCell";
            ManagerCommodityTableViewCell *cell = (ManagerCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell){
                cell = [[ManagerCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
            if (self.commodityType == 3) {
                [cell contentCellInShopCommodityWithCommodityInformationEntity:entity];
            }
            if (self.commodityType == 4) {
                [cell contentCellInShopNetCommodityWithCommodityInformationEntity:entity];
            }
            if ([self.arr_selected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]) {
                cell.btn_select.selected = YES;
            }else{
                cell.btn_select.selected = NO;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *CellIdentifier = @"PotentialStoreTableViewCell";
            CommodityTableViewCell *cell = (CommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell){
                cell = [[CommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
            if (self.commodityType == 3) {
                [cell contentCellInShopWithCommodityInformationEntity:entity];
            }
            if (self.commodityType == 4) {
                [cell contentCellInNetShopWithCommodityInformationEntity:entity];
            }
            cell.btn_more.tag = indexPath.row;
            cell.btn_edit.tag = indexPath.row;
            [cell.btn_more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn_edit addTarget:self action:@selector(edtiAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        if (self.editStatus == YES) {
            [self.arr_selected removeAllObjects];
            self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
        }
        [self.tb_right requestDataSource];
    }else if (tableView == self.tb_right){
        
        if (self.commodityChildEnterFormController == CommodityChildEnterFormActive) {
            if (self.selectCommodity) {
                CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
                self.selectCommodity(entity);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
        NSNumber *number = [NSNumber numberWithInt:(int)indexPath.row];
        if ([self.arr_selected containsObject:number]) {
            [self.arr_selected removeObject:number];
        }else{
            [self.arr_selected addObject:number];
        }
        [self.tb_right reloadData];
        self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tb_right) {
        self.showIndex = NULLROW;
        [self.v_moreEdit setHidden:YES];
    }
}

- (void)selectCategory:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    ShopClassificationEntity *entity = [self.arr_category objectAtIndex:v_sender.tag];self.selectedSection = (int)v_sender.tag;
    self.selectedRow = NULLROW;
    entity.isShow = !entity.isShow;
    [self.arr_category replaceObjectAtIndex:v_sender.tag withObject:entity];
    [self.tb_left reloadData];
    if (self.editStatus == YES) {
        [self.arr_selected removeAllObjects];
        self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
    }
    [self.tb_right requestDataSource];
}

#pragma mark - MoreEditViewAction
//从门店/网店移除
- (void)deleteAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"移除后该商品将从该销售渠道删除。恢复商品需要重新发布。确定要移除吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.v_moreEdit setHidden:YES];
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:self.showIndex];
        [CommodityHandler wareSkuRemoveWareWithSkuId:entity.skuId releaseType:self.commodityType - 2 prepare:^{
            
        } success:^(id obj) {
            [self.arr_commodity removeObjectAtIndex:self.showIndex];
            if (self.arr_commodity.count > 0) {
                [self.tb_right reloadData];
            }else{
                [self loadData];
            }
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
//从门店/网店 上下架
- (void)btn_editAction{
    CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:self.showIndex];
    if (entity.status == 1 || entity.status == 2) {
        //下架方法
        [CommodityHandler wareSkuUpdateStatusWithSkuId:entity.skuId releaseType:self.commodityType - 2 status:[NSNumber numberWithInt:3] prepare:^{
            
        } success:^(id obj) {
            if ([self.btnIndex intValue] == 999) {
                entity.status = 3;
                [self.arr_commodity replaceObjectAtIndex:self.showIndex withObject:entity];
                [self.tb_right reloadData];
            }
            if ([self.btnIndex intValue] == 1 || [self.btnIndex intValue] == 2) {
                //出售中
                [self.arr_commodity removeObjectAtIndex:self.showIndex];
                [self.tb_right reloadData];
            }
            self.showIndex = NULLROW;
            [self.v_moreEdit setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
           [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }else if (entity.status == 3){
        //上架方法
        [CommodityHandler wareSkuUpdateStatusWithSkuId:entity.skuId releaseType:self.commodityType - 2 status:[NSNumber numberWithInt:1] prepare:^{
            
        } success:^(id obj) {
            if ([self.btnIndex intValue] == 999) {
                if ([entity.stock intValue] == 0) {
                    entity.status = 2;
                }else{
                    entity.status = 1;
                }
                [self.arr_commodity replaceObjectAtIndex:self.showIndex withObject:entity];
                [self.tb_right reloadData];
            }
            if ([self.btnIndex intValue] == 3) {
                //已下架商品
                [self.arr_commodity removeObjectAtIndex:self.showIndex];
                [self.tb_right reloadData];
            }
            self.showIndex = NULLROW;
            [self.v_moreEdit setHidden:YES];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
}

#pragma mark - RightTableViewCell BtnAction

- (void)moreAction:(UIButton *)btn_sender{
    CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:btn_sender.tag];
    if (entity.status == 1) {
        [self.v_moreEdit.btn_edit setTitle:@"下架" forState:UIControlStateNormal];
    }else if (entity.status == 2) {
        [self.v_moreEdit.btn_edit setTitle:@"下架" forState:UIControlStateNormal];
    }else if (entity.status == 3) {
        [self.v_moreEdit.btn_edit setTitle:@"上架" forState:UIControlStateNormal];
    }
    if (self.commodityType == 3) {
        [self.v_moreEdit.btn_delege setTitle:@"从门店移除" forState:UIControlStateNormal];
    }else{
        [self.v_moreEdit.btn_delege setTitle:@"从网店移除" forState:UIControlStateNormal];
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
    
    [self.v_moreEdit setFrame:CGRectMake(SCREEN_WIDTH - 16 - 120,rect.origin.y + 28 - 64, 120, 88)];
    
}

- (void)edtiAction:(UIButton *)btn_sender{
    CommodityFromCodeEntity *entityDemo = [self.arr_commodity objectAtIndex:btn_sender.tag];
    PublishCommodityViewController *vc = [[PublishCommodityViewController alloc]init];
    vc.publishCommodityFormType = PublishCommodityFormEdit;
    if (self.commodityType == 3) {
        vc.publishCommodityToShopType = PublishCommodityToShop;
    }
    if (self.commodityType == 4) {
        vc.publishCommodityToShopType = PublishCommodityToNetShop;
    }
    vc.entityInformation = entityDemo;
    [self.navigationController pushViewController:vc animated:YES];
    vc.changeChildEntity = ^(CommodityFromCodeEntity *entity) {
        if ([self.btnIndex intValue] == 2) {
            //已售完
            ShopClassificationEntity *shopClassificationEntity = [self.arr_category objectAtIndex:self.selectedSection];
            if (self.selectedRow != NULLROW) {
                shopClassificationEntity = [shopClassificationEntity.childList objectAtIndex:self.selectedRow];
            }
            if (([entity.firstCategoryId longValue] == [entityDemo.firstCategoryId longValue]) || (shopClassificationEntity._id == 0)) {
                if (entityDemo.stock > 0) {
                    [self.arr_commodity removeObjectAtIndex:btn_sender.tag];
                    if (self.arr_commodity.count > 0) {
                        [self.tb_right reloadData];
                    }else{
                        [self loadData];
                    }
                }else{
                    [self.arr_commodity replaceObjectAtIndex:btn_sender.tag withObject:entity];
                    [self.tb_right reloadData];
                }
            }else{
                [self.arr_commodity removeObjectAtIndex:btn_sender.tag];
                if (self.arr_commodity.count > 0) {
                    [self.tb_right reloadData];
                }else{
                    [self loadData];
                }
            }
        }else{
            ShopClassificationEntity *shopClassificationEntity = [self.arr_category objectAtIndex:self.selectedSection];
            if (self.selectedRow != NULLROW) {
                shopClassificationEntity = [shopClassificationEntity.childList objectAtIndex:self.selectedRow];
            }
            if (([entity.firstCategoryId longValue] == [entityDemo.firstCategoryId longValue]) || (shopClassificationEntity._id == 0)) {
                [self.arr_commodity replaceObjectAtIndex:btn_sender.tag withObject:entity];
                [self.tb_right reloadData];
            }else{
                [self.arr_commodity removeObjectAtIndex:btn_sender.tag];
                if (self.arr_commodity.count > 0) {
                    [self.tb_right reloadData];
                }else{
                    [self loadData];
                }
            }
        }
    };

}


#pragma mark - self.v_top Action

- (void)searchAction{
    SearchCommodityViewController *vc = [[SearchCommodityViewController alloc]init];
    if (self.commodityChildEnterFormController == CommodityChildEnterFormActive) {
        vc.enterFormType = EnterFromActice;
    }else{
        vc.enterFormType = EnterFormNormal;
    }
    if (self.commodityType == 3) {
        vc.searchType = SearchTypeInShop;
    }
    if (self.commodityType == 4) {
        vc.searchType = SearchTypeInNetShop;
    }
    [self.navigationController pushViewController:vc animated:YES];
    vc.selectCommodity = ^(CommodityFromCodeEntity *entity) {
        self.selectCommodity(entity);
    };
}

-(void)moreAction{
    [self.btn_batchManager setHidden:!self.btn_batchManager.isHidden];
    [self.v_moreEdit setHidden:YES];
}

- (void)confirmAction{
    [self btn_batchManagerAction];
    self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
}

-(void)btn_batchManagerAction{
    if (self.commodityType == 3) {
        [self.v_bottom_manager.btn_bottom_yichu setTitle:@"从门店移除" forState:UIControlStateNormal];
    }
    if (self.commodityType == 4) {
        [self.v_bottom_manager.btn_bottom_yichu setTitle:@"从网店移除" forState:UIControlStateNormal];
    }
    self.editStatus = !self.editStatus;
    if (self.editStatus == YES) {
        [self.v_bottom_manager setHidden:NO];
//        [self.lb_selectedNum setHidden:NO];
//        [self.btn_top setHidden:YES];
    }else{
        [self.v_bottom_manager setHidden:YES];
//        [self.lb_selectedNum setHidden:YES];
//        [self.btn_top setHidden:NO];
    }
    [self.btn_batchManager setHidden:YES];
    [self.arr_selected removeAllObjects];
    [self setNavUI];
    [self.tb_right reloadData];
}

- (void)setNavUI{
    if (self.editStatus == NO) {
//        [self.btn_top setHidden:NO];
        [self.btn_search setHidden:NO];
        [self.btn_more setHidden:NO];
        [self.confirm setHidden:YES];
//        [self.v_coverLeft setHidden:YES];
        [self.tb_left setFrame:CGRectMake(0, self.v_top.bottom,SCREEN_WIDTH - 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 43)];
        [self.tb_right setFrame:CGRectMake(100, self.v_top.bottom,SCREEN_WIDTH - 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 43)];
    }else{
//        self.lb_selectedNum.text = [NSString stringWithFormat:@"已选择%ld件商品",self.arr_selected.count];
//        [self.v_top addSubview:self.lb_selectedNum];
//        [self.btn_top setHidden:YES];
        [self.btn_search setHidden:YES];
        [self.btn_more setHidden:YES];
        [self.confirm setHidden:NO];
        [self.tb_left setFrame:CGRectMake(0, self.v_top.bottom,SCREEN_WIDTH - 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 43 - 44)];
        [self.tb_right setFrame:CGRectMake(100, self.v_top.bottom,SCREEN_WIDTH - 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 43 - 44)];
//        [self.v_coverLeft setHidden:NO];
    }
}

-(void)btn_topAction{
    [self.v_moreEdit setHidden:YES];
    [self.v_commodityStatusView setHidden:!self.v_commodityStatusView.isHidden];
}

//商品状态选择

- (void)btn_allAction{
    [self.arr_selected removeAllObjects];
    self.v_bottom_manager.btn_bottom_allSelect.selected = !self.v_bottom_manager.btn_bottom_allSelect.isSelected;
    self.btnIndex = [NSNumber numberWithInt:999];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"全部商品" forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    if (self.editStatus == YES) {
        [self.arr_selected removeAllObjects];
        self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
    }
    [self.tb_right requestDataSource];
    
}

- (void)btn_chushouAction{
    self.v_bottom_manager.btn_bottom_allSelect.selected = !self.v_bottom_manager.btn_bottom_allSelect.isSelected;
    [self.arr_selected removeAllObjects];
    self.btnIndex = [NSNumber numberWithInt:1];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"出售中" forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    if (self.editStatus == YES) {
        [self.arr_selected removeAllObjects];
        self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
    }
    [self.tb_right requestDataSource];
    
}

- (void)btn_shouwanAction{
    [self.arr_selected removeAllObjects];
    self.v_bottom_manager.btn_bottom_allSelect.selected = !self.v_bottom_manager.btn_bottom_allSelect.isSelected;
    self.btnIndex = [NSNumber numberWithInt:2];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"已售罄" forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    if (self.editStatus == YES) {
        [self.arr_selected removeAllObjects];
        self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
    }
    [self.tb_right requestDataSource];
}

- (void)btn_xiajiaAction{
    [self.arr_selected removeAllObjects];
    self.v_bottom_manager.btn_bottom_allSelect.selected = !self.v_bottom_manager.btn_bottom_allSelect.isSelected;
    self.btnIndex = [NSNumber numberWithInt:3];
    [self.v_commodityStatusView setHidden:YES];
    [self.btn_top setTitle:@"已下架" forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    [self.v_commodityStatusView.btn_all setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_chushou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.v_commodityStatusView.btn_shouwan setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    if (self.editStatus == YES) {
        [self.arr_selected removeAllObjects];
        self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
    }
    [self.tb_right requestDataSource];
}

#pragma mark - view_bottom
- (void)btn_bottom_allSelect{
    self.v_bottom_manager.btn_bottom_allSelect.selected = !self.v_bottom_manager.btn_bottom_allSelect.isSelected;
    if (self.v_bottom_manager.btn_bottom_allSelect.isSelected == YES) {
        [self.arr_selected removeAllObjects];
        for (int i = 0; i < self.arr_commodity.count; i++) {
            [self.arr_selected addObject:[NSNumber numberWithInt:i]];
        }
    }else{
        [self.arr_selected removeAllObjects];
    }
//    self.lb_selectedNum.text = [NSString stringWithFormat:@"已选择%ld件商品",self.arr_selected.count];
    [self.tb_right reloadData];
}

#pragma mark - CommodityChildBottomView

- (void)btn_bottom_yichuAction{
    if (self.arr_selected.count > 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"移除后该商品将从该销售渠道删除。恢复商品需要重新发布。确定要移除吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.v_moreEdit setHidden:YES];
        }];
        UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.commodityArr removeAllObjects];
            for ( NSNumber * i in self.arr_selected) {
                CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:[i intValue]];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:entity.skuId forKey:@"skuId"];
                [dic setValue:[NSNumber numberWithInt:self.commodityType - 2] forKey:@"releaseType"];
                [self.commodityArr addObject:dic];
            }
            [CommodityHandler wareSkuRemoveWareListWithCommodityArr:self.commodityArr prepare:^{
                
            } success:^(id obj) {
                NSDictionary *dic = (NSDictionary *)obj;
                NSString *str = @"";
                if (self.commodityType == 3) {
                    str = [NSString stringWithFormat:@"已将%@个商品从门店移除",[dic objectForKey:@"data"]];
                }
                if (self.commodityType == 4) {
                    str = [NSString stringWithFormat:@"已将%@个商品从网店店移除",[dic objectForKey:@"data"]];
                }
                [self loadData];
                [MBProgressHUD showInfoMessage:str];
            } failed:^(NSInteger statusCode, id json) {
                [MBProgressHUD showErrorMessage:(NSString *)json];
            }];
        }];
        [alert addAction:forgetPassword];
        [alert addAction:again];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        [MBProgressHUD showErrorMessage:@"请选择商品"];
    }
}

- (void)btn_bottom_shangjia{
    if (self.arr_selected.count > 0) {
        [self.commodityArr removeAllObjects];
        for ( NSNumber * i in self.arr_selected) {
            CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:[i intValue]];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:entity.skuId forKey:@"skuId"];
            [dic setValue:[NSNumber numberWithInt:self.commodityType - 2] forKey:@"releaseType"];
            [dic setValue:[NSNumber numberWithInt:1] forKey:@"status"];
            [self.commodityArr addObject:dic];
        }
        
        [CommodityHandler wareSkuUpdateStatusListWithCommodityArr:self.commodityArr prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [NSString stringWithFormat:@"已将%@个商品上架成功",[dic objectForKey:@"data"]];
            [self loadData];
            [MBProgressHUD showInfoMessage:str];
//            [self confirmAction];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
        
    }else{
        [MBProgressHUD showErrorMessage:@"请选择商品"];
    }
}

- (void)btn_bottom_xiajia{
    if (self.arr_selected.count > 0) {
        [self.commodityArr removeAllObjects];
        for ( NSNumber * i in self.arr_selected) {
            CommodityFromCodeEntity *entity = [self.arr_commodity objectAtIndex:[i intValue]];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:entity.skuId forKey:@"skuId"];
            [dic setValue:[NSNumber numberWithInt:self.commodityType - 2] forKey:@"releaseType"];
            [dic setValue:[NSNumber numberWithInt:3] forKey:@"status"];
            [self.commodityArr addObject:dic];
        }
        [CommodityHandler wareSkuUpdateStatusListWithCommodityArr:self.commodityArr prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [NSString stringWithFormat:@"已将%@个商品下架成功",[dic objectForKey:@"data"]];
            [self loadData];
            [MBProgressHUD showInfoMessage:str];
//            [self confirmAction];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
        
    }else{
        [MBProgressHUD showErrorMessage:@"请选择商品"];
    }
}


- (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_Main] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;
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
