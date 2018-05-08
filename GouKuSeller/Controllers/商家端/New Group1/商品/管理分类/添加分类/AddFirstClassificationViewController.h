//
//  AddFirstClassificationViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^addCategory)(void);

@interface AddFirstClassificationViewController : BaseViewController

@property (nonatomic, copy) addCategory  addCateGory;

@end
