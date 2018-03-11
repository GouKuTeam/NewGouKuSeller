//
//  ShopClassificationEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface ShopClassificationEntity : BaseEntity

@property (nonatomic ,strong)NSString       *name;
@property (nonatomic ,assign)int            Pid;
@property (nonatomic ,assign)long           shopId;
@property (nonatomic ,strong)NSArray        *childList;

@property (nonatomic ,assign)BOOL           isShow;

+ (NSArray *)parseShopClassificationListWithJson:(id)json;

+ (ShopClassificationEntity *)parseShopClassificationEntityWithJson:(id)json;


@end
