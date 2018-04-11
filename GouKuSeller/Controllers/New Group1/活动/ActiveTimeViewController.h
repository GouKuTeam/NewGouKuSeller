//
//  ActiveTimeViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^goBackFromTime)(NSMutableArray *arr_time);
@interface ActiveTimeViewController : BaseViewController
@property (nonatomic ,strong)NSMutableArray          *arr_selectTime;
@property (nonatomic, copy) goBackFromTime           goBackFromTime;
@end
