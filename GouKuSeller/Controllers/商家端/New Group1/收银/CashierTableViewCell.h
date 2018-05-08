//
//  CashierTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashierCommodityEntity.h"
#import "ItemsEntity.h"

@interface CashierTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel        *lab_name;
@property (nonatomic ,strong)UILabel        *lab_num;
@property (nonatomic ,strong)UILabel        *lab_price_yingfu;
@property (nonatomic ,strong)UILabel        *lab_price_yuanjia;
@property (nonatomic ,strong)UILabel        *lab_heng;
-(void)contentWithCashierCommodity:(CashierCommodityEntity *)entity;

-(void)contentWithItemEntity:(ItemsEntity *)entity;
@end
