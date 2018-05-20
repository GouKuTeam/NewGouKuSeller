//
//  PurchaseOrderDetailViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "PurchaseOrderEntity.h"

typedef void(^ReloadStatus)(PurchaseOrderEntity *entity);

@interface PurchaseOrderDetailViewController : BaseViewController

@property (nonatomic,strong)NSNumber       *orderId;
@property (nonatomic ,copy)ReloadStatus reloadStatus;

@end
