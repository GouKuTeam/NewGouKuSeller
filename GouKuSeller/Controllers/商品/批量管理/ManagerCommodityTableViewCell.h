//
//  ManagerCommodityTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityInformationEntity.h"
@interface ManagerCommodityTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView     *img_CommodityHeadPic;        // 商品头像
@property (nonatomic ,strong)UILabel         *lab_CommodityName;           // 商品名称
@property (nonatomic ,strong)UILabel         *lab_CommodityStock;          // 商品库存
@property (nonatomic ,strong)UILabel         *lab_CommoditySalesVolume;    // 商品销量
@property (nonatomic ,strong)UILabel         *lab_CommodityPrice;          // 商品价格
@property (nonatomic ,strong)UIButton        *btn_select;                    
@property (nonatomic ,strong)UIImageView     *img_line;

- (void)contentCellWithCommodityInformationEntity:(CommodityInformationEntity *)commodityInformationEntity;

@end
