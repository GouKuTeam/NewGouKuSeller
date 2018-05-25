//
//  ChangeAddressViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressEntity.h"
typedef void(^changeAddressComplete)(void);
@interface ChangeAddressViewController : BaseViewController

@property (nonatomic ,strong)AddressEntity    *addressEntity;

@property (nonatomic ,copy)changeAddressComplete changeAddressComplete;


@end
