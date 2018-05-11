//
//  CustomerManagerTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerManagerEntity.h"

@interface CustomerManagerTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView       *img_touxiang;
@property (nonatomic ,strong)UILabel           *lab_shopName;
@property (nonatomic ,strong)UILabel           *lab_personName;

- (void)contentCellWithCustomerManagerEntity:(CustomerManagerEntity *)entity;

@end
