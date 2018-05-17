//
//  ConfirmOrderViewController.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressEntity.h"

@interface ConfirmOrderViewController : BaseViewController

@property (nonatomic,strong)NSMutableArray   *arr_selectedData;
@property (nonatomic,strong)AddressEntity    *addressEntity;

@end
