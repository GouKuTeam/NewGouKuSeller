//
//  SearchCommodityViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityFromCodeEntity.h"


typedef enum : int {
    EnterFormNormal,
    EnterFromActice
}EnterFormType;

typedef void(^searchSelectCommodity)(CommodityFromCodeEntity *entity);
@interface SearchCommodityViewController : BaseViewController
@property (nonatomic,assign)EnterFormType   enterFormType;
@property (nonatomic,copy)searchSelectCommodity   selectCommodity;

@end
