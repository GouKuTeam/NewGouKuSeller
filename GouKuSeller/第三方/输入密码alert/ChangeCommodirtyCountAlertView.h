//
//  ChangeCommodirtyCountAlertView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissAlertView)(int  count);

@interface ChangeCommodirtyCountAlertView : UIView

@property (nonatomic,copy)DismissAlertView  dismissAlertView;
@property (nonatomic ,strong)UIButton        *btn_delete;

- (instancetype)initWithName:(NSString *)name commodirtyCount:(int)commodirtyCount;

- (void)show;
- (void)dismiss;

@end
