//
//  AddNewCommodityViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityFromCodeEntity.h"
typedef void(^changeEntity)(void);
@interface AddNewCommodityViewController : BaseViewController

@property (nonatomic ,strong)NSString       *comeFrom;
@property (nonatomic ,strong)NSNumber       *barcode;
@property (nonatomic ,strong)CommodityFromCodeEntity    *entityInformation;
@property (nonatomic, copy) changeEntity  changeEntity;
@end
