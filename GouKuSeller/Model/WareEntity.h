//
//  WareEntity.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface WareEntity : BaseEntity

@property (nonatomic,strong)NSNumber    *skuId;        //商品SKUID
@property (nonatomic,strong)NSNumber    *skuUnitId;    //商品单位项ID(可以为空)
@property (nonatomic,strong)NSString    *wareName;     //商品名称
@property (nonatomic,strong)NSString    *warePicurl;   //商品图片
@property (nonatomic,strong)NSString    *unitName;     //商品单位名称
@property (nonatomic,assign)NSInteger   wareCount;     //商品数量
@property (nonatomic,assign)double      warePrice;     //商品价格

+ (NSArray *)parseWareListWithJson:(id)json;
+ (WareEntity *)parseWareEntityWithJson:(id)json;

@end
