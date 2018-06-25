//
//  CommodityChildViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : int {
    CommodityChildFormNetShop,
    CommodityChildFormShop,
} CommodityChildFormType;

@interface CommodityChildViewController : BaseViewController

@property (nonatomic ,assign)CommodityChildFormType   commodityChildFormType;

@end
