//
//  PasswordAlertView.m
//  24hotline-official
//
//  Created by lixiao on 2018/4/9.
//  Copyright © 2018年 juliye. All rights reserved.
//

#import "PasswordAlertView.h"

@interface PasswordAlertView () <UITextFieldDelegate>
{
    PasswordAlertBtnType buttonType;
}

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *alertView;

@end
@implementation PasswordAlertView

- (instancetype)initWithPrice:(double)price title:(NSString *)title delegate:(id)delegate{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.double_price = price;
        self.title = title;
    }
    return self;
}

- (void)show
{
    [self initAlert];
    if (self) {
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    }
    [self showAnimation];
}

- (void)dismiss{
    [self hideAnimation];
}

- (void)initAlert {
    self.frame = [self mainScreenFrame];
    self.opaque = YES;
    self.backgroundColor = [UIColor clearColor];
    
    [self makeBackgroundBlur];
    [self makeAlertPopupView];
    
    [self setUI];
}

- (void)setUI{
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.width, 53)];
    [lb_title setText:@"输入登录密码"];
    [lb_title setTextAlignment:NSTextAlignmentCenter];
    [lb_title setFont:[UIFont boldSystemFontOfSize:18]];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.alertView addSubview:lb_title];
    
    UIView *v_line1 = [[UIView alloc]initWithFrame:CGRectMake(0, lb_title.bottom, self.alertView.width, 0.5)];
    [v_line1 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    [self.alertView addSubview:v_line1];
    
    UILabel *lb_withdraw = [[UILabel alloc]initWithFrame:CGRectMake(0, v_line1.bottom + 17.5, self.alertView.width ,22)];
    [lb_withdraw setFont:[UIFont systemFontOfSize:16]];
    [lb_withdraw setTextColor:[UIColor blackColor]];
    [lb_withdraw setTextAlignment:NSTextAlignmentCenter];
    [lb_withdraw setText:self.title];
    [self.alertView addSubview:lb_withdraw];
    
    UILabel *lb_price = [[UILabel alloc]initWithFrame:CGRectMake(15,lb_withdraw.bottom + 8, self.alertView.width - 30, 38)];
    [lb_price setFont:[UIFont boldSystemFontOfSize:34]];
    [lb_price setText:[NSString stringWithFormat:@"￥%.2f",self.double_price]];
    [lb_price setTextAlignment:NSTextAlignmentCenter];
    [self.alertView addSubview:lb_price];
    
    self.tf_password = [[UITextField alloc]initWithFrame:CGRectMake(15, lb_price.bottom + 16, self.alertView.width - 30, 32)];
    self.tf_password.layer.borderColor = [[UIColor colorWithHexString:@"#c2c2c2"] CGColor];
    self.tf_password.layer.borderWidth = 1;
    self.tf_password.font = [UIFont systemFontOfSize:15];
    self.tf_password.delegate = self;
    self.tf_password.textAlignment = NSTextAlignmentCenter;
    [self.alertView addSubview:self.tf_password];
    [self.tf_password becomeFirstResponder];
    self.tf_password.secureTextEntry = YES;
    
    UIView *v_line2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.tf_password.bottom + 18, self.alertView.width, 0.5)];
    [v_line2 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    [self.alertView addSubview:v_line2];
    
    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, v_line2.bottom,self.alertView.width/2, 44)];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self
                       action:@selector(pressAlertButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:self.cancelBtn];
    
    self.confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.width/2, v_line2.bottom,self.alertView.width/2, 44)];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.confirmBtn setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self
                        action:@selector(pressAlertButton:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:self.confirmBtn];
    
    UIView *v_line3 = [[UIView alloc]initWithFrame:CGRectMake(self.alertView.width/2, self.cancelBtn.top, 0.5, self.cancelBtn.height)];
    [v_line3 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    [self.alertView addSubview:v_line3];
    
    
    self.alertView.frame = CGRectMake(self.alertView.frame.origin.x, self.alertView.frame.origin.y, CGRectGetWidth(self.alertView.frame),self.confirmBtn.bottom);
    self.alertView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
}

#pragma mark - Button Methods
- (void)pressAlertButton:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        if ([button isEqual:self.confirmBtn]) {
//            NSLog(@"Pressed Button is confirmButton");
            buttonType = PasswordAlertBtnConfirm;
        } else {
//            NSLog(@"Pressed Button is CancelButton");
            buttonType = PasswordAlertBtnCancel;
        }
    }
    
    [self dismiss];
}

#pragma mark - View Layout Methods
- (void)makeBackgroundBlur {
    self.backgroundView = [[UIImageView alloc]initWithFrame:[self mainScreenFrame]];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.42];
    self.backgroundView.alpha = 0.0;
    [self addSubview:self.backgroundView];
}

- (void)makeAlertPopupView {
    CGRect screen = [self mainScreenFrame];
    CGRect frame = CGRectMake(38, 0, screen.size.width - 76, 200);
    
    self.alertView = [[UIView alloc]initWithFrame:frame];
    [self.alertView.layer setCornerRadius:12.0];
    [self.alertView.layer setBorderWidth:1.0];
    [self.alertView.layer setBorderColor:[UIColor clearColor].CGColor];
    self.alertView.layer.masksToBounds = YES;
    self.alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.alertView];
}

- (void)showAnimation
{
    self.backgroundView.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.backgroundView.alpha = 1.0;
    }];
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.505824;
    animation.fillMode = kCAFillModeBoth;
    animation.keyTimes = @[@0.1f, @0.5f];
    animation.values = [NSMutableArray arrayWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.26f, 1.26f, 1.0)],[NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //    animation.delegate = self;
    [self.alertView.layer addAnimation:animation forKey:nil];
}

- (void)hideAnimation
{
    self.backgroundView.alpha = 1.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundView.alpha = 0.0;
            self.alertView.transform = CGAffineTransformMakeScale(0.35, 0.35);
            self.alertView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:buttonType:passwordStr:)]) {
                [self.delegate alertView:self buttonType:buttonType passwordStr:self.tf_password.text];
            }
            [self removeFromSuperview];
        }];
    }];
}

#pragma mark - Util Methods
- (CGRect)mainScreenFrame
{
    return [UIScreen mainScreen].bounds;
}

- (void)setShadowLayer:(CALayer *)layer
{
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowRadius = 0.6;
    layer.shadowOpacity = 0.3;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

#pragma UITextViewDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2-80);
    }];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    }];
    return YES;
}
@end
