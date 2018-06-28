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

typedef enum : int {
    SearchTypeInWareHouse = 2,
    SearchTypeInShop = 3,
    SearchTypeInNetShop = 4
}SearchType;

typedef void(^searchSelectCommodity)(CommodityFromCodeEntity *entity);
@interface SearchCommodityViewController : BaseViewController

@property (nonatomic,assign)EnterFormType   enterFormType;
@property (nonatomic,assign)SearchType      searchType;
@property (nonatomic,copy)searchSelectCommodity   selectCommodity;

@end
