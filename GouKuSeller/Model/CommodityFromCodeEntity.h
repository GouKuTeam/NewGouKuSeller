//
//  CommodityFromCodeEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"
#import "wareCategory.h"

@interface CommodityFromCodeEntity : BaseEntity

@property (nonatomic ,strong)NSNumber       *shopId;             //商品id
@property (nonatomic ,strong)NSNumber       *barcode;            //商品条形码
@property (nonatomic ,strong)wareCategory   *wareCategory;       //商品类目
@property (nonatomic ,strong)NSString       *name;
@property (nonatomic ,strong)NSString       *detail;
@property (nonatomic ,strong)NSString       *pkey;               // 图片路径
@property (nonatomic ,strong)NSNumber       *shopWareCategoryId; // 门店分类id
@property (nonatomic ,strong)NSNumber       *price;
@property (nonatomic ,strong)NSNumber       *stock;
@property (nonatomic ,strong)NSNumber       *wid;                //商品编码
@property (nonatomic ,strong)NSString       *standards;          //规格名称

+ (NSDictionary *)parseCommodityFromCodeListWithJson:(id)json;
+ (CommodityFromCodeEntity *)parseCommodityFromCodeEntityWithJson:(id)json;

@end

