//
//  ShopClassificationViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopClassificationEntity.h"

typedef void(^goBackShop)(ShopClassificationEntity *shopClassificationEntity);

@interface ShopClassificationViewController : BaseViewController

@property (nonatomic, copy) goBackShop  goBackShop;

@end
