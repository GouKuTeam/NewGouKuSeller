//
//  EditSecondCatagoryViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopClassificationEntity.h"

typedef void(^updateSecondCategory)(void);

@interface EditSecondCatagoryViewController : BaseViewController

@property (nonatomic ,strong)ShopClassificationEntity    *entity;
@property (nonatomic ,strong)ShopClassificationEntity    *sml_entity;

@property (nonatomic, copy) updateSecondCategory updateSecondCategory;

@end
