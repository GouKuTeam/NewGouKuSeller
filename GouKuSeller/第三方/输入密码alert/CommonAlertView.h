//
//  CommonAlertView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttoKeyboardView.h"

typedef NS_ENUM(NSInteger, CommonAlertBtnType) {
    CommonAlertBtnConfirm,
    CommonAlertBtnCancel
};

@class CommonAlertView;

@protocol CommonAlertViewDelegate <NSObject>

- (void)alertView:(CommonAlertView *)alertView buttonType:(CommonAlertBtnType)btnType textFiledText:(NSString *)text;

@end

@interface CommonAlertView : UIView

@property(nonatomic,assign)id<CommonAlertViewDelegate> delegate;

@property(nonatomic,strong)UIButton*            confirmBtn;
@property(nonatomic,strong)UIButton*            cancelBtn;
@property(nonatomic,strong)OttoTextField     *doubleTextField;
@property(nonatomic,strong)NSString             *title_type;

- (instancetype)initWithTitleType:(NSString *)titleType delegate:(id)delegate;

- (void)show;
- (void)dismiss;

@end
