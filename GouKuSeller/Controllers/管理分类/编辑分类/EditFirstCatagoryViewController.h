//
//  EditFirstCatagoryViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopClassificationEntity.h"

typedef void(^updateCategory)(void);
@interface EditFirstCatagoryViewController : BaseViewController

@property (nonatomic ,strong)ShopClassificationEntity    *entity;
@property (nonatomic, copy) updateCategory  updateCategory;

@end
