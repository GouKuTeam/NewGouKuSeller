//
//  ActiveZhouViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^goBack)(NSMutableArray *arr_week);

@interface ActiveZhouViewController : BaseViewController

@property (nonatomic,strong)NSMutableArray   *arr_selectedWeek;
@property (nonatomic, copy) goBack           goBack;

@end
