//
//  ScheduleTableViewCell.m
//  GouKuSeller
//
//  Created by lixiao on 2018/6/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ScheduleTableViewCell.h"

@implementation ScheduleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lb_time = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 55, 30)];
        [self.lb_time setFont:[UIFont systemFontOfSize:14]];
        [self.lb_time setTextColor:[UIColor blackColor]];
        [self addSubview:self.lb_time];
        
        self.lb_schedule = [[UILabel alloc]initWithFrame:CGRectMake(self.lb_time.right, 0, SCREEN_WIDTH - 70, 30)];
        [self.lb_schedule setFont:[UIFont systemFontOfSize:14]];
        [self.lb_schedule setTextColor:[UIColor blackColor]];
        [self addSubview:self.lb_schedule];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
