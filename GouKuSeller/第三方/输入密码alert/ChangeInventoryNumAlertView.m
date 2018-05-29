//
//  ChangeInventoryNumAlertView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ChangeInventoryNumAlertView.h"

@interface ChangeInventoryNumAlertView () <UITextFieldDelegate>


@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int      count;

@property (nonatomic ,strong)UIButton        *btn_cha;
@property (nonatomic ,strong)UILabel         *lab_name;
@property (nonatomic ,strong)UILabel         *lab_detail;
@property (nonatomic ,strong)UITextField     *tf_count;
@property (nonatomic ,strong)UIImageView     *img_heng1;
@property (nonatomic ,strong)UIButton        *btn_jian;
@property (nonatomic ,strong)UIButton        *btn_jia;
@end

@implementation ChangeInventoryNumAlertView

- (instancetype)initWithName:(NSString *)name commodirtyCount:(int)commodirtyCount{
    self = [super init];
    if (self) {
        self.name = name;
        self.count = commodirtyCount;
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
    self.backgroundView.alpha = 1.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundView.alpha = 0.0;
            self.alertView.transform = CGAffineTransformMakeScale(0.35, 0.35);
            self.alertView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];}

- (void)initAlert {
    self.frame = [self mainScreenFrame];
    self.opaque = YES;
    self.backgroundColor = [UIColor clearColor];
    
    [self makeBackgroundBlur];
    [self makeAlertPopupView];
    
    [self setUI];
}

- (void)setUI{
    
    self.btn_cha = [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.width - 15 - 18, 15, 18, 18)];
    [self.alertView addSubview:self.btn_cha];
    [self.btn_cha setBackgroundImage:[UIImage imageNamed:@"close_grey"] forState:UIControlStateNormal];
    [self.btn_cha addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, self.alertView.width - 30, 20)];
    [self.alertView addSubview:self.lab_name];
    [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.lab_name setFont:[UIFont systemFontOfSize:18]];
    self.lab_name.textAlignment = NSTextAlignmentCenter;
    [self.lab_name setText:self.name];
    
    self.lab_detail = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, self.alertView.width - 30, 22)];
    [self.alertView addSubview:self.lab_detail];
    [self.lab_detail setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [self.lab_detail setFont:[UIFont systemFontOfSize:16]];
    self.lab_detail.textAlignment = NSTextAlignmentCenter;
    [self.lab_detail setText:@"修改盘点数量"];
    
    self.btn_jian = [[UIButton alloc]initWithFrame:CGRectMake(20, 122, 73, 46)];
    [self.alertView addSubview:self.btn_jian];
    [self.btn_jian setBackgroundImage:[UIImage imageNamed:@"reduce_1"] forState:UIControlStateNormal];
    [self.btn_jian addTarget:self action:@selector(jianAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btn_jia = [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.width - 20 - 73, 122, 73, 46)];
    [self.alertView addSubview:self.btn_jia];
    [self.btn_jia setBackgroundImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
    [self.btn_jia addTarget:self action:@selector(jiaAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.img_heng1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 198,self.alertView.width - 40, 0.5)];
    [self.alertView addSubview:self.img_heng1];
    [self.img_heng1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    
    self.tf_count = [[UITextField alloc]initWithFrame:CGRectMake(self.btn_jian.right, 122,self.alertView.width - 76 * 2 - 34.5, 46)];
    [self.alertView addSubview:self.tf_count];
    [self.tf_count setTextColor:[UIColor blackColor]];
    [self.tf_count  setFont:[UIFont systemFontOfSize:18]];
    [self.tf_count setTextAlignment:NSTextAlignmentCenter];
    self.tf_count.layer.borderWidth = 1.0f;
    self.tf_count.delegate = self;
    self.tf_count.layer.borderColor = [[UIColor colorWithHexString:@"#D8D8D8"] CGColor];
    self.tf_count.keyboardType = UIKeyboardTypeNumberPad;
    self.tf_count.text = [NSString stringWithFormat:@"%d",self.count];
     [self.tf_count addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.btn_delete = [[UIButton alloc]initWithFrame:CGRectMake(20, 226.5, self.alertView.width - 40, 46)];
    [self.alertView addSubview:self.btn_delete];
    [self.btn_delete setTitle:@"删除商品" forState:UIControlStateNormal];
    [self.btn_delete setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
    self.btn_delete.titleLabel.font = [UIFont systemFontOfSize:18];
    self.btn_delete.layer.cornerRadius = 3;
    self.btn_delete.layer.borderWidth = 1;
    self.btn_delete.layer.borderColor = [[UIColor colorWithHexString:@"#4167B2"] CGColor];
    self.btn_delete.layer.masksToBounds = YES;
    
    self.alertView.frame = CGRectMake(self.alertView.frame.origin.x, self.alertView.frame.origin.y, CGRectGetWidth(self.alertView.frame),self.btn_delete.bottom + 32);
    self.alertView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
}

- (void)jianAction{
    if ([self.tf_count.text intValue] > 0) {
        self.tf_count.text = [NSString stringWithFormat:@"%d",[self.tf_count.text intValue] - 1];
    }
}

- (void)jiaAction{
    self.tf_count.text = [NSString stringWithFormat:@"%d",[self.tf_count.text intValue] + 1];
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
    CGRect frame = CGRectMake(15, 0, screen.size.width - 30, 200);
    
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
            if (self.dismissAlertView) {
                self.dismissAlertView([self.tf_count.text intValue]);
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

- (void)textFieldDidChange:(UITextField *)textField
{
    
    NSInteger kMaxLength = 6;
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (int)convertToInt:(NSString *)strtemp//判断中英混合的的字符串长度
{
    int strlength = 0;
    for (int i=0; i< [strtemp length]; i++) {
        int a = [strtemp characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) { //判断是否为中文
            strlength += 2;
        }
    }
    return strlength;
}


@end
