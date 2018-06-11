//
//  ShopOrderManagerSectionHeaderView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderEntity.h"

@interface ShopOrderManagerSectionHeaderView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UIView                *v_top;
@property (nonatomic ,strong)UIView                *v_numAndStatus;
@property (nonatomic ,strong)UILabel               *lab_orderNum;
@property (nonatomic ,strong)UILabel               *lab_orderStatus;
@property (nonatomic ,strong)UILabel               *lab_shopName;
@property (nonatomic ,strong)UILabel               *lab_shopAddress;
@property (nonatomic ,strong)UIButton              *btn_tell;
@property (nonatomic ,strong)UIButton              *btn_DetailTell;
@property (nonatomic ,strong)UIImageView           *img_line1;
@property (nonatomic ,strong)UIImageView           *img_line2;
@property (nonatomic ,strong)UILabel               *lab_remarkTitle;
@property (nonatomic ,strong)UILabel               *lab_remarkDetail;
@property (nonatomic ,strong)UILabel               *lab_commodityTitle;
@property (nonatomic ,strong)UIButton              *btn_zhankai;

@property (nonatomic ,strong)UITableView           *tb_schedule;
@property (nonatomic ,strong)UILabel               *lb_title;
@property (nonatomic ,strong)UIButton              *btn_phone;
@property (nonatomic ,strong)UIButton              *btn_showSchedule;
@property (nonatomic ,strong)UIImageView           *img_line3;
@property (nonatomic ,strong)NSMutableArray        *arr_schedule;


- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity;

- (CGFloat)getHeightWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity;

@end
