//
//  CreateAddressViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^addAddressComplete)(void);

@interface CreateAddressViewController : BaseViewController

@property (nonatomic ,copy)addAddressComplete addAddressComplete;

@end
