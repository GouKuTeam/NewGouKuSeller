//
//  CommodityViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityFromCodeEntity.h"

typedef enum : int {
    EnterFormNormal,
    EnterFromActice
}EnterFormType;

typedef void(^selectCommodity)(CommodityFromCodeEntity *entity);
@interface CommodityViewController : BaseViewController

@property (nonatomic,assign)EnterFormType   enterFormType;
@property (nonatomic,copy)selectCommodity   selectCommodity;
@end
