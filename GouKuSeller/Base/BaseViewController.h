//
//  BaseViewController.h
//  DocChat-C-iphone
//
//  Created by SeanLiu on 15/8/5.
//  Copyright (c) 2015年 juliye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,assign)BOOL isHideLeftBtn;
@property(nonatomic,assign)BOOL isShowRightBtn;

@property (nonatomic, strong) NSString *userId;

- (void)initLeftBarView;
- (void)onCreate;
- (void)leftBarAction:(id)sender;
- (void)rightBarAction:(id)sender;
- (void)networkErrorHandler;

//navgation变色
- (void)changeNavigationBarBackgroudColor:(UIColor *)backgroudColor TintColor:(UIColor *)tintColor TitleColor:(UIColor *)titleColor TitleFont:(CGFloat)titleFont;

- (void)changeNavigationOriginal;

@end
