//
//  AddInventoryViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^addInventoryFinish)(void);
@interface AddInventoryViewController : BaseViewController

@property (nonatomic, copy) addInventoryFinish  addInventoryFinish;


@end
