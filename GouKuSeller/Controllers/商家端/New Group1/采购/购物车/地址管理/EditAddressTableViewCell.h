//
//  EditAddressTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressEntity.h"

@interface EditAddressTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIView           *v_back;
@property (nonatomic ,strong)UILabel          *lab_name;
@property (nonatomic ,strong)UILabel          *lab_phone;
@property (nonatomic ,strong)UILabel          *lab_address;
@property (nonatomic ,strong)UIButton         *btn_morenAddress;
@property (nonatomic ,strong)UIButton         *btn_delete;

- (void)contentCellWithAddressEntity:(AddressEntity *)entity;

@end
