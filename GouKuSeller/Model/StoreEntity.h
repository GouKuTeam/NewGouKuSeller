//
//  StoreEntity.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface StoreEntity : BaseEntity
@property (nonatomic,strong)NSNumber     *shopId;    //供应商门店ID
@property (nonatomic,strong)NSString     *shopName;  //供应商门店名称
@property (nonatomic,strong)NSString     *shopPicurl;//供应商门店LOGO
@property (nonatomic,assign)double       shopTakeOffPrice; //供应商门店起送价格
@property (nonatomic,assign)double       orderPrice; //供应商门店订单总价
@property (nonatomic,assign)double       freightPrice; //供应商门店运费
@property (nonatomic,strong)NSArray      *shoppingCatItems;//供应商门店订单商品

+ (NSArray *)parseStoreListWithJson:(id)json;
+ (StoreEntity *)parseStoreEntityWithJson:(id)json;

@end
