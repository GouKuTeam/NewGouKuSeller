//
//  ImageCollectionViewCell.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.iv_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.iv_image setContentMode:UIViewContentModeScaleAspectFill];
        [self.iv_image setClipsToBounds:YES];
        [self addSubview:self.iv_image];
    }
    return self;
}
@end
