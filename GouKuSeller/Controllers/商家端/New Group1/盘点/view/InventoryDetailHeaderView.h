//
//  InventoryDetailHeaderView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryDetailHeaderView : UIView

@property (nonatomic ,strong)UILabel       *lab_createTime;
@property (nonatomic ,strong)UILabel       *lab_submitTime;

@property (nonatomic ,strong)UILabel        *lab_name;
@property (nonatomic ,strong)UILabel        *lab_stock;
@property (nonatomic ,strong)UILabel        *lab_inventoryNum;

@end
