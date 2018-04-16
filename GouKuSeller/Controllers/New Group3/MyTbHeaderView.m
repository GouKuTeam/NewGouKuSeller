//
//  MyTbHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "MyTbHeaderView.h"

@implementation MyTbHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithHexString:@"#38393E"]];
        self.imgHead = [[UIImageView alloc]init];
        [self addSubview:self.imgHead];
        self.imgHead.layer.cornerRadius = 3.0f;
        self.imgHead.layer.masksToBounds = YES;
        
        self.lab_name = [[UILabel alloc]init];
        [self addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor whiteColor]];
        [self.lab_name setFont:[UIFont systemFontOfSize:18]];
        if (SafeAreaTopHeight == 88) {
            [self.imgHead setFrame:CGRectMake(15, 90, 60, 60)];
            [self.lab_name setFrame:CGRectMake(88, 48 + 44, SCREEN_WIDTH - 108, 25)];
        }else{
            [self.imgHead setFrame:CGRectMake(15, 66, 60, 60)];
            [self.lab_name setFrame:CGRectMake(88, 48 + 20, SCREEN_WIDTH - 108, 25)];
        }
        
        
    }
    return self;
}

@end
