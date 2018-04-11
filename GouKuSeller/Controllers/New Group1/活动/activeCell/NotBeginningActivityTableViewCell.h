//
//  NotBeginningActivityTableViewCell.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotBeginningActivityTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel             *lab_activeName;
@property (nonatomic ,strong)UILabel             *lab_activeTime;
@property (nonatomic ,strong)UILabel             *lab_activeStatus;
@property (nonatomic ,strong)UILabel             *lab_activeType;
@property (nonatomic ,strong)UIButton            *btn_edit;
@property (nonatomic ,strong)UIButton            *btn_stop;

@end
