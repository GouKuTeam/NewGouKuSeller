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

@property (nonatomic ,assign)int             hitType;        //1 商品条形码查出的结果 2 商品编码  3商品名称
@property (nonatomic ,strong)NSNumber       *shopId;             //商品id
@property (nonatomic ,strong)NSNumber       *barcode;            //商品条形码
@property (nonatomic ,strong)NSNumber       *categoryId;
@property (nonatomic ,strong)wareCategory   *wareCategory;       //商品类目
@property (nonatomic ,strong)NSString       *name;
@property (nonatomic ,strong)NSString       *categoryName;
@property (nonatomic ,strong)NSString       *detail;
@property (nonatomic ,strong)NSString       *pictures;               // 图片路径
@property (nonatomic ,strong)NSNumber       *shopWareCategoryId; // 门店分类id
@property (nonatomic ,strong)NSString       *shopWareCategoryName;  //门店分类名称
@property (nonatomic ,strong)NSNumber       *saleAmount;       
@property (nonatomic ,strong)NSNumber       *saleAmountMonth;
@property (nonatomic ,strong)NSNumber       *price;
@property (nonatomic ,strong)NSNumber       *xprice;           //进货价
@property (nonatomic ,strong)NSNumber       *stock;
@property (nonatomic ,strong)NSNumber       *wid;                //商品编码
@property (nonatomic ,strong)NSNumber       *itemId;                //商品编码
@property (nonatomic ,strong)NSNumber       *skuId;                //商品编码
@property (nonatomic ,strong)NSString       *standards;          //规格名称
@property (nonatomic ,strong)NSString       *standardReplace;          //规格名称(前端显示)
//@property (nonatomic ,strong)NSNumber       *status;           //  1 销售中  2 已售罄   3 已下架
@property (nonatomic ,strong)NSString       *attrs;

@property (nonatomic,strong)NSString        *youhuiPrice;


+ (NSArray *)parseCommodityFromCodeListWithJson:(id)json;
+ (CommodityFromCodeEntity *)parseCommodityFromCodeEntityWithJson:(id)json;

@end

