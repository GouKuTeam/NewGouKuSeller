//
//  MoveCommodityView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopClassificationEntity.h"
#import "CommodityHandler.h"
#import "LoginStorage.h"
#import "ShopClassificationTableViewCell.h"

#define NULLROW    999

@interface MoveCommodityView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UIView                *v_backGround;
@property (nonatomic ,strong)UIView                *v_back;
@property (nonatomic ,strong)UILabel               *lab_title;
@property (nonatomic ,strong)UITableView           *tab_cagatory;
@property (nonatomic ,strong)UIButton              *btn_cancel;
@property (nonatomic ,strong)UIButton              *btn_move;
@property (nonatomic ,strong)UIImageView           *img_line_title;
@property (nonatomic ,strong)UIImageView           *img_line_btntop;
@property (nonatomic ,strong)UIImageView           *img_line_btnmid;

@property (nonatomic ,strong)NSMutableArray        *arr_moveCatagary;

@property (nonatomic ,assign)int               selectedSection;
@property (nonatomic ,assign)int               selectedRow;

@end
