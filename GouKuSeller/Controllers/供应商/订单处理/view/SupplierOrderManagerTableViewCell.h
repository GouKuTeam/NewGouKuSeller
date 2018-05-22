//
//  SupplierOrderManagerTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupplierCommodityEndity.h"

@interface SupplierOrderManagerTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel           *lab_name;
@property (nonatomic ,strong)UILabel           *lab_count;
@property (nonatomic ,strong)UILabel           *lab_price;

- (void)contentCellWithSupplierCommodityEndity:(SupplierCommodityEndity *)supplierCommodityEndity;

@end
