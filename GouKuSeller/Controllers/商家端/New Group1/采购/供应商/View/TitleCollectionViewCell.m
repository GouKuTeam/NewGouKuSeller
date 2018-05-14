//
//  TitleCollectionViewCell.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lb_title = [[UILabel alloc]initWithFrame:CGRectMake(7, 0, frame.size.width - 14, frame.size.height)];
        [self.lb_title setFont:[UIFont systemFontOfSize:13]];
        [self.lb_title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lb_title];
        
    }
    return self;
}

@end
