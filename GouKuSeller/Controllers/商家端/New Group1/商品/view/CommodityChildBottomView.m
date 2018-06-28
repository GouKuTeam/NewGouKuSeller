//
//  CommodityChildBottomView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityChildBottomView.h"

@implementation CommodityChildBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = frame.size.height;
        self.btn_bottom_allSelect = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
        [self addSubview:self.btn_bottom_allSelect];
        [self.btn_bottom_allSelect setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [self.btn_bottom_allSelect setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [self.btn_bottom_allSelect setTitle:@"全选" forState:UIControlStateNormal];
        [self.btn_bottom_allSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn_bottom_allSelect.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_bottom_allSelect setImageEdgeInsets:UIEdgeInsetsMake(0.0, -8.5, 0.0, 0.0)];
        
        UIImageView *imgshu = [[UIImageView alloc]initWithFrame:CGRectMake(99, 0, 1, height)];
        [self addSubview:imgshu];
        [imgshu setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        CGFloat width = (SCREEN_WIDTH - 100) / 2;
        
        self.btn_bottom_yichu = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 100,height)];
        [self addSubview:self.btn_bottom_yichu];
//        [self.btn_bottom_yichu setTitle:@"发布到门店" forState:UIControlStateNormal];
        [self.btn_bottom_yichu setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_bottom_yichu.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *imgshu2 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 0, 1, height)];
        [self addSubview:imgshu2];
        [imgshu2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        
        self.btn_bottom_shangjia = [[UIButton alloc]initWithFrame:CGRectMake(200, 0,(SCREEN_WIDTH - 200) / 2,height)];
        [self addSubview:self.btn_bottom_shangjia];
        [self.btn_bottom_shangjia setTitle:@"上架" forState:UIControlStateNormal];
        [self.btn_bottom_shangjia setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_bottom_shangjia.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *imgshu3 = [[UIImageView alloc]initWithFrame:CGRectMake(200 + (SCREEN_WIDTH - 200) / 2, 0, 1, height)];
        [self addSubview:imgshu3];
        [imgshu3 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        
        self.btn_bottom_xiajia = [[UIButton alloc]initWithFrame:CGRectMake(201 + (SCREEN_WIDTH - 200) / 2, 0,(SCREEN_WIDTH - 200) / 2,height)];
        [self addSubview:self.btn_bottom_xiajia];
        [self.btn_bottom_xiajia setTitle:@"下架" forState:UIControlStateNormal];
        [self.btn_bottom_xiajia setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_bottom_xiajia.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

@end
