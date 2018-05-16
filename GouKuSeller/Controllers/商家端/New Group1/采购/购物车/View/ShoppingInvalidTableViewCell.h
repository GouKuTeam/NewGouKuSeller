//
//  ShoppingInvalidTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupplierCommodityEndity.h"

@interface ShoppingInvalidTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel       *lb_status;
@property (nonatomic,strong)UIImageView   *iv_image;
@property (nonatomic,strong)UILabel       *lb_name;
@property (nonatomic,strong)UILabel       *lb_reason;

- (void)contentCellWithWareEntity:(SupplierCommodityEndity *)wareEntity;

@end
