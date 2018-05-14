//
//  EditInventoryViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^updateInventoryFinish)(void);

@interface EditInventoryViewController : BaseViewController

@property (nonatomic,strong)NSNumber *inventoryId;
@property (nonatomic, copy) updateInventoryFinish  updateInventoryFinish;


@end
