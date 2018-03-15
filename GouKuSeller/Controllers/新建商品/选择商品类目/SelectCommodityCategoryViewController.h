//
//  SelectCommodityCategoryViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityCatagoryEntity.h"

typedef void(^goBack)(CommodityCatagoryEntity *commodityCatagoryEntity);

@interface SelectCommodityCategoryViewController : BaseViewController

@property (nonatomic, copy) goBack  goBackCategory;

@end
