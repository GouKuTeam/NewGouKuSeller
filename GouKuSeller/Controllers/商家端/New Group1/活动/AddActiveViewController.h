//
//  AddActiveViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
typedef enum : int {
    ActiceFormManJian,
    ActiceFormZheKou,
    ActiceFormTeJia,
    ActiceFormJianJia,
} ActiceFormType;

@interface AddActiveViewController : BaseViewController

@property (nonatomic ,strong)NSString                  *titleType;
@property (nonatomic ,assign)ActiceFormType            activeType;

@end
