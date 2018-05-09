//
//  SupplierCommodityListTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupplierCommodityEndity.h"

@interface SupplierCommodityListTableViewCell : UITableViewCell


@property (nonatomic ,strong)UIImageView     *img_CommodityHeadPic;        // 商品头像
@property (nonatomic ,strong)UILabel         *lab_CommodityStatus;         // 商品状态
@property (nonatomic ,strong)UILabel         *lab_CommodityName;           // 商品名称
@property (nonatomic ,strong)UILabel         *lab_CommodityStock;          // 商品库存
@property (nonatomic ,strong)UILabel         *lab_CommoditySalesVolume;    // 商品销量
@property (nonatomic ,strong)UILabel         *lab_CommodityPrice;          // 商品价格
@property (nonatomic ,strong)UILabel         *lab_CommodityUnit;           // 商品单位
@property (nonatomic ,strong)UIButton        *btn_edit;                    // 编辑按钮
@property (nonatomic ,strong)UIButton        *btn_more;                    // ...按钮
@property (nonatomic ,strong)UIImageView     *img_line;

- (void)contentCellWithSupplierCommodityEndity:(SupplierCommodityEndity *)supplierCommodityEndity;

@end
