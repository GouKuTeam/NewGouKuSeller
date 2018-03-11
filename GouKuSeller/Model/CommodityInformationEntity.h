//
//  CommodityInformationEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface CommodityInformationEntity : BaseEntity

@property (nonatomic ,strong)NSString       *name;
@property (nonatomic ,strong)NSString       *pictureKey;
@property (nonatomic ,assign)double          price;
@property (nonatomic ,strong)NSNumber       *stock;
@property (nonatomic ,strong)NSNumber       *saleAmountMonth;

+ (NSArray *)parseCommodityInformationListWithJson:(id)json;

+ (CommodityInformationEntity *)parseCommodityInformationEntityWithJson:(id)json;




@end




