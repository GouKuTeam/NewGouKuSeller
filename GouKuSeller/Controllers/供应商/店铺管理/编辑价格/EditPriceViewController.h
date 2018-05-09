//
//  EditPriceViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^GoBackAddSupplierCommodity)(NSDictionary *dic);
@interface EditPriceViewController : BaseViewController

@property (nonatomic ,copy)GoBackAddSupplierCommodity   goBackAddSupplierCommodity;

@property (nonatomic ,assign)double          defaultPrice;      //默认价格
@property (nonatomic ,assign)BOOL            defaultUnit;
@property (nonatomic ,strong)NSMutableArray          *arr_data;

@end
