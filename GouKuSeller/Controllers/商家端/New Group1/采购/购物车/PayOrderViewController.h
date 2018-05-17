//
//  PayOrderViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressEntity.h"

@interface PayOrderViewController : BaseViewController

@property (nonatomic,strong)NSMutableArray   *arr_selectedData;
@property (nonatomic,strong)AddressEntity    *addressEntity;
@property (nonatomic,assign)double            total;
@property (nonatomic,assign)double            accountPrice;
@property (nonatomic,strong)NSString         *orderId;

@end
