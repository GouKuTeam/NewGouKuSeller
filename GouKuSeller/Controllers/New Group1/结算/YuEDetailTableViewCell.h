//
//  YuEDetailTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/30.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountCashDetailEntity.h"

@interface YuEDetailTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel           *lab_title;
@property (nonatomic ,strong)UILabel           *lab_time;
@property (nonatomic ,strong)UILabel           *lab_price;

- (void)contentCellWithAccountCashDetailEntity:(AccountCashDetailEntity *)accountCashDetailEntity;

@end
