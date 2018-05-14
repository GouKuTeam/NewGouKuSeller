//
//  SupplierCommodityTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupplierCommodityEndity.h"

@interface SupplierCommodityTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView        *img_pic;
@property (nonatomic ,strong)UILabel            *lab_name;
@property (nonatomic ,strong)UILabel            *lab_price;
@property (nonatomic ,strong)UILabel            *lab_priceGuiGe;
@property (nonatomic ,strong)UIButton           *btn_addCommodity;

- (void)contentCellWithWareEntity:(SupplierCommodityEndity *)wareEntity;

@end
