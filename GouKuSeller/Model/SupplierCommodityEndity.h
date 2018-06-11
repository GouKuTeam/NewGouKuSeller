//
//  SupplierCommodityEndity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface SupplierCommodityEndity : BaseEntity

@property (nonatomic ,assign)int             hitType;        //1 商品条形码查出的结果 2 商品编码  3商品名称

@property (nonatomic ,strong)NSNumber                      *shopId;       //供应商ID
@property (nonatomic ,strong)NSNumber                      *wareItemId;   //标准商品项ID
@property (nonatomic ,strong)NSNumber                      *skuId;        //商品SKUID
@property (nonatomic ,strong)NSString                      *categoryName;  //类目名称
@property (nonatomic ,strong)NSString                      *detail;       //商品描述
@property (nonatomic ,strong)NSString                      *barcode;      //商品条形码
@property (nonatomic ,strong)NSNumber                      *firstCategoryId;  //商品一级分类
@property (nonatomic ,strong)NSString                      *firstCategoryName;  //商品一级分类名称
@property (nonatomic ,strong)NSString                      *stock;             //商品库存
@property (nonatomic ,assign)double                        xprice;
@property (nonatomic ,strong)NSString                      *standards;         //规格详情
@property (nonatomic ,strong)NSString                      *name;              //商品名称
@property (nonatomic ,strong)NSString                      *pictures;          //商品图片
@property (nonatomic ,strong)NSString                      *attrs;             //商品属性
@property (nonatomic ,strong)NSString                      *defaultUnit;       //默认商品单位
@property (nonatomic ,assign)double                        defaultPrice;       //默认商品价格
@property (nonatomic ,assign)BOOL                          defaultUsing;       //默认商品单位是否启用
@property (nonatomic ,strong)NSArray                       *saleUnits;  //自定义单位数组
@property (nonatomic ,strong)NSNumber                      *saleAmount;         //销量
@property (nonatomic ,strong)NSNumber                      *saleAmountMonth;    //月销量
@property (nonatomic ,strong)NSString                      *unit;      //列表显示的默认单位名称
@property (nonatomic ,assign)double                        price;      //列表显示的默认单位价格
@property (nonatomic ,assign)NSInteger                     count;
@property (nonatomic ,strong)NSString                      *remark;
@property (nonatomic ,strong)NSNumber                      *skuUnitId;
@property (nonatomic ,strong)NSNumber                      *type;

+ (NSArray *)parseSupplierCommodityEndityListWithJson:(id)json;
+ (SupplierCommodityEndity *)parseSupplierCommodityEndityWithJson:(id)json;
/*
"saleUnits": [
              {
                  "id": <number>,             //商品单位ID
                  "shopWareSkuId": <number>,  //商品ID
                  "unitName": <String>,       //商品单位名称
                  "count": <number>,          //商品等于库存量
                  "price": <Decimal>          //商品单位价格
              }
              ],
 */

@end
