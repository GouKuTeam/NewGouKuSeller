//
//  ShoppingCartTableViewCell.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupplierCommodityEndity.h"

@interface ShoppingCartTableViewCell : UITableViewCell

@property (nonatomic,strong)UIButton      *btn_select;
@property (nonatomic,strong)UIImageView   *iv_image;
@property (nonatomic,strong)UILabel       *lb_name;
@property (nonatomic,strong)UILabel       *lb_price;
@property (nonatomic,strong)UILabel       *lb_specification;
@property (nonatomic,strong)UIButton      *btn_less;
@property (nonatomic,strong)UIButton      *btn_plus;
@property (nonatomic,strong)UITextField   *tf_number;

- (void)contentCellWithWareEntity:(SupplierCommodityEndity *)wareEntity;
@end
