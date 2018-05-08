//
//  AddPriceViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^goBackFromAddPrice)(double price);
@interface AddPriceViewController : BaseViewController

@property (nonatomic, copy) goBackFromAddPrice           goBackFromAddPrice;

@end
