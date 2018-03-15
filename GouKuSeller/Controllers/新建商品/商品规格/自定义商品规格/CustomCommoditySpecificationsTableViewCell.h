//
//  CustomCommoditySpecificationsTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/15.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCommoditySpecificationsTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel              *lab_name;
@property (nonatomic ,strong)UILabel              *lab_price;
@property (nonatomic ,strong)UILabel              *lab_stock;
@property (nonatomic ,strong)UIButton             *btn_delete;
@property (nonatomic ,strong)UIImageView          *img_line;
@end
