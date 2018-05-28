//
//  SupplierShopViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierShopViewController.h"
#import "SupplierHeaderView.h"
#import "SupplierCommodityTableViewCell.h"
#import "CategoryTableViewCell.h"
#import "CommodityHandler.h"
#import "ShopClassificationEntity.h"
#import "SupplierCommodityHeaderView.h"
#import "PurchaseHandler.h"
#import "SupplierCommodityEndity.h"
#import "SupplierInformationViewController.h"
#import "SearchCommodityInSupplierShopViewController.h"
#import "SupplierCommodityInformationViewController.h"
#import "SelectUnitView.h"
#import "PurchaseHandler.h"
#import "NSString+Size.h"

@interface SupplierShopViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BaseTableViewDelagate>

@property (nonatomic,strong)BaseTableView   *tb_left;
@property (nonatomic,strong)BaseTableView   *tb_right;
@property (nonatomic,strong)UIBarButtonItem *btn_attention;
@property (nonatomic,strong)NSMutableArray  *arr_category;
@property (nonatomic,strong)NSMutableArray  *arr_data;
@property (nonatomic,assign)int              selectedFirst;
@property (nonatomic,strong)SupplierCommodityHeaderView  *v_supplierCommodityHeader;
@property (nonatomic,strong)UIView          *v_line;
@property (nonatomic,strong)SelectUnitView  *selectUnitView;

@end

@implementation SupplierShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    self.arr_category = [NSMutableArray array];
    self.arr_data = [NSMutableArray array];
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

- (void)onCreate{
    
    SupplierHeaderView *v_header = [[SupplierHeaderView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 66)];
    [v_header.iv_avatar sd_setImageWithURL:[NSURL URLWithString:self.storeEntity.logo] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [v_header.lb_name setText:self.storeEntity.name];
    CGFloat width = [self.storeEntity.name fittingLabelWidthWithHeight:28 andFontSize:[UIFont systemFontOfSize:20]];
    [v_header.img_jiantou setFrame:CGRectMake(width + 76, v_header.lb_name.top + 2, 24, 24)];
    if (width > SCREEN_WIDTH - 76 - 14) {
        [v_header.lb_name setFrame:CGRectMake(v_header.iv_avatar.right + 10, 3, SCREEN_WIDTH - 76 - 24, 28)];
        [v_header.img_jiantou setFrame:CGRectMake(SCREEN_WIDTH - 36, v_header.lb_name.top + 2, 24, 24)];
    }
//    [v_header.img_jiantou setBackgroundColor:[UIColor redColor]];
    [v_header.lb_startPrice setText:[NSString stringWithFormat:@"%d元起送",(int)self.storeEntity.takeOffPrice]];
    [self.view addSubview:v_header];
    UITapGestureRecognizer *vHeaderTgp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoShopDetailAction)];
    [v_header addGestureRecognizer:vHeaderTgp];
    
    self.v_supplierCommodityHeader = [[SupplierCommodityHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 85, 34)];
    self.v_supplierCommodityHeader.clipsToBounds = YES;
    WS(weakSelf);
    self.v_supplierCommodityHeader.selectItem = ^{
        [weakSelf.tb_right requestDataSource];
    };
    
    self.tb_left = [[BaseTableView alloc]initWithFrame:CGRectMake(0,v_header.bottom,85,SCREEN_HEIGHT - v_header.bottom - SafeAreaBottomHeight - SafeAreaTopHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_left.delegate = self;
    self.tb_left.dataSource = self;
    self.tb_left.tableFooterView = [UIView new];
    self.tb_left.separatorColor = [UIColor clearColor];
    self.tb_left.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tb_left];
    
    self.tb_right = [[BaseTableView alloc]initWithFrame:CGRectMake(85,self.tb_left.top,SCREEN_WIDTH - 85,self.tb_left.height) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_right.delegate = self;
    self.tb_right.dataSource = self;
    self.tb_right.tableViewDelegate = self;
    self.tb_right.tableFooterView = [UIView new];
    self.tb_right.rowHeight = 96;
    self.tb_right.backgroundColor = [UIColor whiteColor];
    self.tb_right.separatorColor = [UIColor clearColor];
    self.tb_right.tableHeaderView = self.v_supplierCommodityHeader;
    [self.view addSubview:self.tb_right];
    
    self.v_line = [[UIView alloc]initWithFrame:CGRectMake(85, self.tb_left.top, 1,self.tb_left.height)];
    [self.v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [self.view addSubview:self.v_line];
    
    UIBarButtonItem *btn_search = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_white"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    self.btn_attention = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shoucang-white"] style:UIBarButtonItemStyleDone target:self action:@selector(attentionAction)];
    if (self.storeEntity.isAttention == YES) {
        UIImage *image = [UIImage imageNamed:@"shocuang-orange"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_btn_attention setImage:image];
    }
    self.navigationItem.rightBarButtonItems = @[self.btn_attention,btn_search];
    
    self.selectUnitView = [[SelectUnitView alloc]init];
    [self.selectUnitView setHidden:YES];
    [self.selectUnitView.btn_confirm addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self.selectUnitView];
    [self.selectUnitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self loadData];
}

- (void)searchAction{
    SearchCommodityInSupplierShopViewController *vc = [[SearchCommodityInSupplierShopViewController alloc]init];
    vc.shopId = self.storeEntity.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)attentionAction{
    if (self.storeEntity.isAttention == NO) {
        //未关注
        [PurchaseHandler addSupplierAttentionWithSid:self.storeEntity.shopId name:self.storeEntity.name prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                UIImage *image = [UIImage imageNamed:@"shocuang-orange"];
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [_btn_attention setImage:image];
                self.storeEntity.isAttention = YES;
            }else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
    if (self.storeEntity.isAttention == YES) {
        //已关注
        [PurchaseHandler cancelSupplierAttentionWithSid:self.storeEntity.shopId name:self.storeEntity.name prepare:^{
            
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                UIImage *image = [UIImage imageNamed:@"shoucang-white"];
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [_btn_attention setImage:image];
                self.storeEntity.isAttention = NO;
            }else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
        }];
    }
}

- (void)loadData{
    [CommodityHandler getCommodityCategoryWithShopId:[self.storeEntity.shopId stringValue] prepare:^{
        [MBProgressHUD showActivityMessageInView:nil];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        NSArray *arr_data = (NSArray *)obj;
        [self.arr_category removeAllObjects];
        [self.arr_category addObjectsFromArray:arr_data];
        if (self.arr_category.count > 0) {
            self.selectedFirst = 0;
            [self.tb_left reloadData];
            [self reloadSupplierCommodityHeaderView];
            [self.tb_right requestDataSource];
        }
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    ShopClassificationEntity *entity = [[ShopClassificationEntity alloc]init];
    entity = [self.arr_category objectAtIndex:self.selectedFirst];
    if (entity.childList.count > 0) {
        entity = [entity.childList objectAtIndex:self.v_supplierCommodityHeader.selectedSecond];
    }
    [PurchaseHandler getWareWithShopId:self.storeEntity.shopId keyword:nil status:nil firstCategoryId:[NSNumber numberWithInteger:entity._id] page:pageNum prepare:^{
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_data removeAllObjects];
        }
        [self.arr_data addObjectsFromArray:(NSArray *)obj];
        [self.tb_right reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_data.count == 0) {
            self.tb_right.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_right.frame withDefaultImage:nil withNoteTitle:@"暂未数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)reloadSupplierCommodityHeaderView{
    if (self.arr_category.count > 0) {
        ShopClassificationEntity *entity = [self.arr_category objectAtIndex:self.selectedFirst];
        if (entity.childList.count > 0) {
            CGFloat  height = 0.00;
            if (entity.childList.count % 3 == 0) {
                height = 30 + entity.childList.count/3*34 + (entity.childList.count/3 - 1)*7;
            }else{
                height = 30 + (entity.childList.count/3 + 1)*34 + (entity.childList.count/3 + 1 - 1)*7;
            }
            [self.v_supplierCommodityHeader setFrame:CGRectMake(0,0, self.v_supplierCommodityHeader.width, height)];
            [self.v_supplierCommodityHeader.collectionView setFrame:CGRectMake(7, 15, self.v_supplierCommodityHeader.width - 7, self.v_supplierCommodityHeader.height - 30)];
        }else{
            [self.v_supplierCommodityHeader setFrame:CGRectMake(0, 0, self.v_supplierCommodityHeader.width, 12)];
        }
        self.v_supplierCommodityHeader.selectedSecond = 0;
        self.v_supplierCommodityHeader.arr_data = entity.childList;
        [self.tb_right setTableHeaderView:self.v_supplierCommodityHeader];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tb_left){
        return self.arr_category.count;
    }else{
        return self.arr_data.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tb_left == tableView) {
        static NSString *CellIdentifier = @"SupplierCommodityTableViewCell";
        CategoryTableViewCell *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ShopClassificationEntity *entity = [self.arr_category objectAtIndex:indexPath.row];
        if (indexPath.row == self.selectedFirst) {
            cell.lb_name.textColor = [UIColor blackColor];
        }else{
            cell.lb_name.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        }
        cell.lb_name.text = entity.name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"SupplierCommodityTableViewCell";
        SupplierCommodityTableViewCell *cell = (SupplierCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[SupplierCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        SupplierCommodityEndity *entity = [self.arr_data objectAtIndex:indexPath.row];
        [cell contentCellWithWareEntity:entity];
        cell.btn_addCommodity.tag = indexPath.row;
        [cell.btn_addCommodity addTarget:self action:@selector(addCommityAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_left) {
        return 0.01;
    }else{
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_left) {
        return nil;
    }else{
        
        UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(7, 0, self.tb_right.width - 14, 20)];
        [lb_title setTextColor:[UIColor blackColor]];
        [lb_title setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        
        if (self.arr_category.count > 0) {
            ShopClassificationEntity *entity = [[ShopClassificationEntity alloc]init];
            entity = [self.arr_category objectAtIndex:self.selectedFirst];
            if (entity.childList.count > 0) {
                entity = [entity.childList objectAtIndex:self.v_supplierCommodityHeader.selectedSecond];
            }
            [lb_title setText:[NSString stringWithFormat:@"   %@",entity.name]];
        }
        return lb_title;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tb_left && self.selectedFirst != indexPath.row) {
        self.selectedFirst = (int)indexPath.row;
        [self reloadSupplierCommodityHeaderView];
        [self.tb_left reloadData];
        [self.tb_right requestDataSource];
    }
    if (tableView == self.tb_right) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self changeNavigationOriginal];
        SupplierCommodityEndity *sentity = [self.arr_data objectAtIndex:indexPath.row];
        self.navigationController.navigationBar.translucent = YES;
        SupplierCommodityInformationViewController *vc = [[SupplierCommodityInformationViewController alloc]init];
        vc.supplierCommodityEndity = sentity;
        vc.shopId = self.storeEntity.shopId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)addCommityAction:(UIButton *)btn_sender{
    SupplierCommodityEndity *entity = [self.arr_data objectAtIndex:btn_sender.tag];
    [self.selectUnitView contentViewWithSupplierCommodityEndity:entity];
    [self.selectUnitView setHidden:NO];
}

- (void)confirmAction{
    NSDictionary *dic = [self.selectUnitView.supplierCommodityEndity.saleUnits objectAtIndex:self.selectUnitView.selectIndex];
    [PurchaseHandler addCommodityToShoppingCarWithSkuId:self.selectUnitView.supplierCommodityEndity.skuId skuUnitId:[dic objectForKey:@"id"] count:[NSNumber numberWithInt:[self.selectUnitView.tf_count.text intValue]] prepare:^{
        [MBProgressHUD showActivityMessageInView:nil];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        [self.selectUnitView setHidden:YES];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == self.tb_left) {
//        if (self.tb_left.top <= 66 && self.tb_left.top > 0  && scrollView.contentOffset.y
//             > 0) {
//            CGFloat heightTop = self.tb_left.top - scrollView.contentOffset.y;
//            if (heightTop < 0) {
//                heightTop = 0;
//            }
//            [self.tb_left setFrame:CGRectMake(self.tb_left.left,heightTop, self.tb_left.width, SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
//            [self.tb_left setContentOffset:CGPointMake(0, 0)];
//            [self.tb_right setFrame:CGRectMake(self.tb_right.left,self.tb_left.top, self.tb_right.width,self.tb_left.height)];
//        }else if (self.tb_left.top <= 66 && scrollView.contentOffset.y < 0){
//            CGFloat heightTop = self.tb_left.top - scrollView.contentOffset.y;
//            if (heightTop > 66) {
//                heightTop = 66;
//            }
//            [self.tb_left setFrame:CGRectMake(self.tb_left.left,heightTop,self.tb_left.width, SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
//            [self.tb_left setContentOffset:CGPointMake(0, 0)];
//            [self.tb_right setFrame:CGRectMake(self.tb_right.left,self.tb_left.top, self.tb_right.width,self.tb_left.height)];
//        }
//    }
     if (scrollView == self.tb_right){
        if (self.tb_right.top <= 66 && self.tb_left.top > 0 && scrollView.contentOffset.y
            > 0) {
            CGFloat heightTop = self.tb_right.top - scrollView.contentOffset.y;
            if (heightTop < 0) {
                heightTop = 0;
            }
            [self.tb_right setFrame:CGRectMake(self.tb_right.left,heightTop, self.tb_right.width,SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
            [self.tb_right setContentOffset:CGPointMake(0, 0)];
            [self.tb_left setFrame:CGRectMake(self.tb_left.left, self.tb_right.top, self.tb_left.width, self.tb_right.height)];
        }else if (self.tb_right.top <= 66 && scrollView.contentOffset.y < 0){
            CGFloat heightTop = self.tb_right.top - scrollView.contentOffset.y;
            if (heightTop > 66) {
                heightTop = 66;
            }
            [self.tb_right setFrame:CGRectMake(self.tb_right.left,heightTop, self.tb_right.width,SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
            [self.tb_right setContentOffset:CGPointMake(0, 0)];
            [self.tb_left setFrame:CGRectMake(self.tb_left.left, self.tb_right.top, self.tb_left.width,self.tb_right.height)];
        }
        [self.v_line setFrame:CGRectMake(85, self.tb_left.top, 1,self.tb_left.height)];
    }
}

- (void)gotoShopDetailAction{
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;
    SupplierInformationViewController *vc = [[SupplierInformationViewController alloc]init];
    vc.storeEntity = self.storeEntity;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
