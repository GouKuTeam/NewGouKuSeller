//
//  EditAddressViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressEntity.h"

typedef enum : int {
    AddressEnterFormNormal,
    AddressEnterFromConfirmOrder
}AddressEnterFormType;

typedef void(^SelectAddressComplete)(AddressEntity *addressEntity);

@interface EditAddressViewController : BaseViewController

@property (nonatomic ,assign)AddressEnterFormType      addressEnterFromType;
@property (nonatomic ,  copy)SelectAddressComplete     selectAddressComplete;

@end
