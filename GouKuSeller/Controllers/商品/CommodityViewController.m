//
//  CommodityViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityViewController.h"
#import "BtnTop.h"
#import "ManagementClassificationViewController.h"
#import "BaseTableView.h"
#import "CommodityHandler.h"
#import "CommodityInformationEntity.h"
#import "ShopClassificationEntity.h"
#import "StoreCategoryTableViewCell.h"
#import "CommodityTableViewCell.h"
#import "AddNewCommodityViewController.h"
#import "LoginStorage.h"
#import "RTHttpClient.h"
#import "CommodityBottomView.h"
#import "ManagerCommodityTableViewCell.h"
#import "MoveCommodityView.h"
#import "SearchCommodityViewController.h"

#define NULLROW    999

@interface CommodityViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

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
//@property (nonatomic ,strong)MoveCommodityView             *v_moveCommodity;

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.btn_top = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 44)];
    [self.btn_top setTitle:@"出售中" forState:UIControlStateNormal];
    [self.btn_top setImage:[UIImage imageNamed:@"triangle_down"] forState:UIControlStateNormal];
    [self.btn_top setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn_top.imageView.frame.size.width, 0, self.btn_top.imageView.frame.size.width)];
    [self.btn_top setImageEdgeInsets:UIEdgeInsetsMake(0, self.btn_top.titleLabel.bounds.size.width + 10, 0, -self.btn_top.titleLabel.bounds.size.width)];
    self.navigationItem.titleView = self.btn_top;
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(searchBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"home_search"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;

    /*****************************            批量管理注掉的
    self.btn_navright_search = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.btn_navright_search setImage:[UIImage imageNamed:@"search_press"] forState:UIControlStateNormal];
    [self.btn_navright_search addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];

//    self.btn_navright_more = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [self.btn_navright_more setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
//    [self.btn_navright_more addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    
//    self.btn_navright_search.frame = CGRectMake(0, 0, 20, 20);
//    self.btn_navright_more.frame=CGRectMake(0, 0, 22, 6);
    
//    self.lb_selectedNum = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH - 100, 44)];
//    [self.lb_selectedNum setTextAlignment:NSTextAlignmentCenter];
//    [self.lb_selectedNum setFont:[UIFont systemFontOfSize:18]];
//    [self.lb_selectedNum setTextColor:[UIColor whiteColor]];
    
//    self.v_coverLeft = [[UIView alloc]initWithFrame:self.tb_left.frame];
//    [self.v_coverLeft setBackgroundColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.3]];
//    [self.view addSubview:self.v_coverLeft];
    [self setNavUI];
     ***********/
    
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
    [self.btn_buildCommodity addTarget:self action:@selector(btn_buildCommodityAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tb_left = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 50) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_left.dataSource = self;
    self.tb_left.delegate = self;
    self.tb_left.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    self.tb_left.tableViewDelegate = self;
    [self.view addSubview:self.tb_left];
    
    self.tb_right = [[BaseTableView alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight,SCREEN_WIDTH - 100, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaTopHeight - 50) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_right.dataSource = self;
    self.tb_right.delegate = self;
    self.tb_right.tableViewDelegate = self;
    self.tb_right.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.tb_right];
    /****
    self.btn_batchManager = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 136, SafeAreaTopHeight, 120, 44)];
    [self.view addSubview:self.btn_batchManager];
    [self.btn_batchManager setTitle:@"批量管理" forState:UIControlStateNormal];
    self.btn_batchManager.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_batchManager setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];
    [self.btn_batchManager setHidden:YES];
    self.btn_batchManager.clipsToBounds = YES;
    self.btn_batchManager.layer.cornerRadius = 3;
    self.btn_batchManager.layer.masksToBounds = YES;
    self.btn_batchManager.layer.borderColor = [[UIColor colorWithHexString:@"#d8d8d8"] CGColor];
    self.btn_batchManager.layer.borderWidth = 0.5;
    [self.btn_batchManager addTappedWithTarget:self action:@selector(btn_batchManagerAction)];
    
    self.v_bottom_manager = [[CommodityBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 49, SCREEN_WIDTH, 49)];
    [self.v_bottom_manager setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.v_bottom_manager];
    [self.v_bottom_manager setHidden:YES];
    [self.v_bottom_manager.btn_bottom_allSelect addTarget:self action:@selector(btn_bottom_allSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottom_manager.btn_bottom_xiajia addTarget:self action:@selector(btn_bottom_xiajia) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottom_manager.btn_bottom_move addTarget:self action:@selector(btn_bottom_move) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottom_manager.btn_bottom_delete addTarget:self action:@selector(btn_bottom_delete) forControlEvents:UIControlEventTouchUpInside];
    
    //移动商品选择分类界面
    self.v_moveCommodity = [[MoveCommodityView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.v_moveCommodity];
    [self.v_moveCommodity setHidden:YES];
    [self.v_moveCommodity.btn_move addTarget:self action:@selector(moveVBtnAction) forControlEvents:UIControlEventTouchUpInside];
     ****/
    
    [self loadData];
    
    CommodityInformationEntity *entity = [[CommodityInformationEntity alloc]init];
    entity.price = 3.5;
    entity.name = @"脉动橙子";
    entity.stock = [NSNumber numberWithInt:100];
    entity.saleAmountMonth = [NSNumber numberWithInt:90];
    [self.arr_commodity addObject:entity];

}

- (void)btn_managementClassificationAction{
    ManagementClassificationViewController *vc
    = [[ManagementClassificationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn_buildCommodityAction{
    AddNewCommodityViewController *vc = [[AddNewCommodityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData{
        [CommodityHandler getCommodityCategoryWithShopId:[[LoginStorage GetShopId] stringValue] prepare:nil success:^(id obj) {
            NSArray *arr_data = (NSArray *)obj;
            [self.arr_category addObjectsFromArray:arr_data];
            [self.tb_left reloadData];
//            self.v_moveCommodity.arr_moveCatagary = self.arr_category;
        } failed:^(NSInteger statusCode, id json) {

        }];
}

#pragma uitableview

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
        if (self.selectedSection == section && self.selectedRow == NULLROW) {
            [img_shu setHidden:NO];
            [lab_categoryName setTextColor:[UIColor colorWithHexString:@"#4167b2"]];
        }else{
            [img_shu setHidden:YES];
            [lab_categoryName setTextColor:[UIColor colorWithHexString:@"#616161"]];
        }
        
        if (self.selectedSection == section){
            [v_header setBackgroundColor:[UIColor whiteColor]];
        }else{
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
            CommodityInformationEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
            [cell contentCellWithCommodityInformationEntity:entity];
            if ([self.arr_selected containsObject:[NSNumber numberWithInt:(int)indexPath.row]]) {
                cell.btn_select.selected = YES;
            }else{
                cell.btn_select.selected = NO;
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"PotentialStoreTableViewCell";
            CommodityTableViewCell *cell = (CommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell){
                cell = [[CommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            CommodityInformationEntity *entity = [self.arr_commodity objectAtIndex:indexPath.row];
            [cell contentCellWithCommodityInformationEntity:entity];
            cell.btn_more.tag = indexPath.row;
            [cell.btn_more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn_delege.tag = indexPath.row;
            [cell.btn_delege addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn_xiajia.tag = indexPath.row;
            [cell.btn_xiajia addTarget:self action:@selector(xiaJiaAction:) forControlEvents:UIControlEventTouchUpInside];
            if (self.showIndex == indexPath.row) {
                [cell.v_back setHidden:NO];
            }else{
                [cell.v_back setHidden:YES];
            }
            return cell;
        }
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tb_left) {
        self.selectedSection = (int)indexPath.section;
        self.selectedRow = (int)indexPath.row;
        [self.tb_left reloadData];
        //加载右边数据
    }else if (tableView == self.tb_right){
        NSNumber *number = [NSNumber numberWithInt:(int)indexPath.row];
        if ([self.arr_selected containsObject:number]) {
            [self.arr_selected removeObject:number];
        }else{
            [self.arr_selected addObject:number];
        }
        [self.tb_right reloadData];
        /**  -----注掉批量管理注掉的
        self.lb_selectedNum.text = [NSString stringWithFormat:@"已选择%ld件商品",self.arr_selected.count];
        self.v_bottom_manager.btn_bottom_allSelect.selected = NO;
         */
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tb_right) {
        if (self.showIndex != NULLROW) {
            self.showIndex = NULLROW;
            [self.tb_right reloadData];
        }
    }
}

- (void)selectCategory:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    self.selectedSection = (int)v_sender.tag;
    self.selectedRow = NULLROW;
    ShopClassificationEntity *entity = [self.arr_category objectAtIndex:v_sender.tag];
    entity.isShow = !entity.isShow;
    [self.arr_category replaceObjectAtIndex:v_sender.tag withObject:entity];
    [self.tb_left reloadData];
    //加载右边数据
    
}


- (void)moreAction:(UIButton *)btn_sender{
    if (btn_sender.tag == self.showIndex) {
        self.showIndex = NULLROW;
    }else{
        self.showIndex = (int)btn_sender.tag;
    }
    [self.tb_right reloadData];
}

- (void)deleteAction:(UIButton *)btn_sender{
    CommodityInformationEntity *entity = [self.arr_commodity objectAtIndex:btn_sender.tag];

}

- (void)xiaJiaAction:(UIButton *)btn_sender{
    CommodityInformationEntity *entity = [self.arr_commodity objectAtIndex:btn_sender.tag];
    
}
-(void)searchBarAction{
    SearchCommodityViewController *vc = [[SearchCommodityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/********注掉批量管理功能



-(void)moreAction{
    [self.btn_batchManager setHidden:!self.btn_batchManager.isHidden];
}

- (void)confirmAction{
    [self btn_batchManagerAction];
//    [self.v_moveCommodity setHidden:YES];
}

-(void)btn_batchManagerAction{
    self.editStatus = !self.editStatus;
    if (self.editStatus == YES) {
        [self.v_bottom_manager setHidden:NO];
    }else{
        [self.v_bottom_manager setHidden:YES];
    }
    [self.btn_batchManager setHidden:YES];
    [self.arr_selected removeAllObjects];
    [self setNavUI];
    [self.tb_right reloadData];
}

#pragma view_bottom mark
- (void)btn_bottom_allSelect{
    self.v_bottom_manager.btn_bottom_allSelect.selected = !self.v_bottom_manager.btn_bottom_allSelect.isSelected;
    if (self.v_bottom_manager.btn_bottom_allSelect.isSelected == YES) {
        [self.arr_selected removeAllObjects];
        for (int i = 0; i < self.arr_category.count; i++) {
            [self.arr_selected addObject:[NSNumber numberWithInt:i]];
        }
    }else{
        [self.arr_selected removeAllObjects];
    }
    self.lb_selectedNum.text = [NSString stringWithFormat:@"已选择%ld件商品",self.arr_selected.count];
    [self.tb_right reloadData];
}

- (void)btn_bottom_xiajia{
    
}

- (void)btn_bottom_move{
    self.v_moveCommodity.lab_title.text = [NSString stringWithFormat:@"已选择%ld件商品",self.arr_selected.count];
    [self.v_moveCommodity setHidden:NO];
}

- (void)btn_bottom_delete{

}

移动分类按钮方法
- (void)moveVBtnAction{
    if (self.v_moveCommodity.selectedSection == NULLROW) {
        [MBProgressHUD showInfoMessage:@"请选择分类"];
        return;
    }
    ShopClassificationEntity *entity = [[ShopClassificationEntity alloc]init];
    entity = [self.v_moveCommodity.arr_moveCatagary objectAtIndex:self.v_moveCommodity.selectedSection];
    if (self.v_moveCommodity.selectedRow != NULLROW) {
        entity = [entity.childList objectAtIndex:self.v_moveCommodity.selectedRow];
    }

}
 
 *****/

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

@end
