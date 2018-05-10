//
//  HYTopBar.m
//  标签栏视图
//
//  Created by Sekorm on 2017/6/29.
//  Copyright © 2017年 HY. All rights reserved.
//

#import "HYTopBar.h"
#import "PrefixHeader.pch"

static CGFloat const topBarItemMargin = 20; ///标题之间的间距
static CGFloat const topBarHeight = 44; //顶部标签条的高度

@interface HYTopBar()
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIView   *v_line;

@end

@implementation HYTopBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.selectedIndex = 999;
        
        self.v_line = [[UIView alloc]initWithFrame:CGRectZero];
        [self.v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self addSubview:self.v_line];
        [self.v_line setHidden:YES];
    }
    return self;
}

- (void)addTitleBtn:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(itemSelectedChange:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.btnArray addObject:btn];
}

- (void)itemSelectedChange:(UIButton *)btn {
    
    NSInteger index = [self.btnArray indexOfObject:btn];
    if ([self.topBarDelegate respondsToSelector:@selector(HYTopBarChangeSelectedItem:selectedIndex:)]) {
        if (self.selectedIndex != index) {
            [self setSelectedItem:index];
            [self.topBarDelegate HYTopBarChangeSelectedItem:self selectedIndex:index];
        }
    }
    
}

- (void)setSelectedItem:(NSInteger)index {
    [self.v_line setHidden:NO];
    if (self.selectedIndex != index) {
        self.selectedIndex = (int)index;
        UIButton *btn = self.btnArray[index];
        if ([self.topBarDelegate respondsToSelector:@selector(HYTopBarChangeSelectedItem:selectedIndex:)]) {
            [self.topBarDelegate HYTopBarChangeSelectedItem:self selectedIndex:index];
        }
        [UIView animateWithDuration:0.25 animations:^{
            
            btn.selected = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
            if (btn.left == 0) {
                [self.v_line setFrame:CGRectMake(btn.left + 15, 42, btn.width, 2)];
            }else{
                [self.v_line setFrame:CGRectMake(btn.left, 42, btn.width, 2)];
            }
            self.selectedBtn.selected = NO;
            self.selectedBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            self.selectedBtn = btn;
            
            // 计算偏移量
            CGFloat offsetX = btn.center.x - HYScreenW * 0.5;
            if (offsetX < 0) offsetX = 0;
            // 获取最大滚动范围
            CGFloat maxOffsetX = self.contentSize.width - HYScreenW;
            if (offsetX > maxOffsetX) offsetX = maxOffsetX;
            
            if (self.contentSize.width > [UIScreen mainScreen].bounds.size.width) {
                // 滚动标题滚动条
                [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            }
        }];
    }
}

- (NSMutableArray *)btnArray{
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

    CGFloat btnH = topBarHeight;
    CGFloat btnX = topBarItemMargin;
    for (int i = 0 ; i < self.btnArray.count; i++) {

        UIButton *btn = self.btnArray[i];
        if (i == 0) {
            btn.frame = CGRectMake(15, 0, btn.frame.size.width, btnH);
        }else{
            btn.frame = CGRectMake(btnX, 0, btn.frame.size.width, btnH);
        }
        btnX += btn.frame.size.width + topBarItemMargin;
    }
    self.contentSize = CGSizeMake(btnX + 50, 0);
}

@end
