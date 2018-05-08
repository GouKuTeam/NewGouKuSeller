//
//  OrderListTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailEntity.h"

@interface OrderListTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView        *img_pay;
@property (nonatomic ,strong)UILabel            *lab_price;
@property (nonatomic ,strong)UILabel            *lab_payStatus;
@property (nonatomic ,strong)UILabel            *lab_payTime;

- (void)contentCellWithOrderListEntity:(OrderDetailEntity *)entity;
@end
