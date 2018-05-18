//
//  PasswordAlertView.h
//  24hotline-official
//
//  Created by lixiao on 2018/4/9.
//  Copyright © 2018年 juliye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PasswordAlertBtnType) {
    PasswordAlertBtnConfirm,
    PasswordAlertBtnCancel
};

@class PasswordAlertView;

@protocol PasswordAlertViewDelegate <NSObject>

- (void)alertView:(PasswordAlertView *)alertView buttonType:(PasswordAlertBtnType)btnType passwordStr:(NSString *)password;

@end

@interface PasswordAlertView : UIView

@property(nonatomic,assign)id<PasswordAlertViewDelegate> delegate;

@property(nonatomic,strong)UIButton*            confirmBtn;
@property(nonatomic,strong)UIButton*            cancelBtn;
@property(nonatomic,strong)UITextField          *tf_password;
@property(nonatomic,assign)double               double_price;
@property(nonatomic,strong)NSString             *title;

- (instancetype)initWithPrice:(double)price title:(NSString *)title delegate:(id)delegate;

- (void)show;
- (void)dismiss;
@end
