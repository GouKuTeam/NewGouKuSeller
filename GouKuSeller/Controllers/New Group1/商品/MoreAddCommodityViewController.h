//
//  MoreAddCommodityViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^addCommodityMoreFinish)(void);

@interface MoreAddCommodityViewController : BaseViewController

@property (nonatomic, copy) addCommodityMoreFinish  addCommodityMoreFinish;


@end
