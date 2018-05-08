//
//  ShoppingCarEntity.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface ShoppingCarEntity : BaseEntity

@property (nonatomic,strong)NSNumber     *userId;            //用户ID
@property (nonatomic,assign)double       orderPrice;         //购物车总价
@property (nonatomic,assign)NSInteger    items;              //购物车项数
@property (nonatomic,strong)NSArray      *shoppingCarShops;  //供应商订单
@property (nonatomic,strong)NSArray      *invalidItems;      //失效商品

+ (ShoppingCarEntity *)parseShoppingCarEntityWithJson:(id)json;

@end
