//
//  SupplierPayViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^changAccountPrice)(NSString *price);

@interface SupplierPayViewController : BaseViewController

@property (nonatomic ,strong)NSString                 *payPrice;
@property (nonatomic ,strong)NSString                 *totalPrice;

@property (nonatomic, copy) changAccountPrice  changAccountPrice;


@end
