//
//  SelectFisstCatagoryViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopClassificationEntity.h"

typedef void(^goBackFirst)(ShopClassificationEntity *commodityCatagoryEntity);

@interface SelectFisstCatagoryViewController : BaseViewController

@property (nonatomic, copy) goBackFirst  goBackFirst;

@end
