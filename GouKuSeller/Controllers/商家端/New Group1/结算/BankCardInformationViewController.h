//
//  BankCardInformationViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/28.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : int {
    EnterFormJieSuan,
    EnterFromCard
}EnterFormType;

@interface BankCardInformationViewController : BaseViewController

@property (nonatomic ,assign)EnterFormType    enterFromType;

@end
