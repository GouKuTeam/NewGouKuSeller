//
//  ActiveDetailCommodityTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveRulesEntity.h"

@interface ActiveDetailCommodityTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel          *lab_name;
@property (nonatomic ,strong)UILabel          *lab_price;
@property (nonatomic ,strong)UILabel          *lab_active;

-(void)contentCellWithActiveEntity:(ActiveRulesEntity *)entity;


@end
