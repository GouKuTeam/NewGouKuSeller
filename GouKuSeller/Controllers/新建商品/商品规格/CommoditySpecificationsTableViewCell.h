//
//  CommoditySpecificationsTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/15.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoView.h"

@interface CommoditySpecificationsTableViewCell : UITableViewCell

@property(nonatomic ,strong)UILabel                *lab_title;
@property(nonatomic ,strong)UIImageView            *img_line;
@property(nonatomic ,strong)EditInfoView           *ev_price;
@property(nonatomic ,strong)EditInfoView           *ev_stock;
@property(nonatomic ,strong)EditInfoView           *ev_barcode;       //条形码
@property(nonatomic ,strong)EditInfoView           *ev_branchId;      //商品编码

@end
