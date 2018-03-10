//
//  UILabel+LineSpace.h
//  juliye-C-iphone
//
//  Created by lixiao on 16/8/17.
//  Copyright © 2016年 juliye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpace)

- (void)setSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;

- (void)setSpaceLabelHeightWithText:(NSString*)str_text Color:(UIColor *)color;

- (CGFloat)getSpaceHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;
- (CGFloat)getSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;

- (CGFloat)getSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width withFont:(UIFont *)font withRange:(NSRange)range;

//获得行数和行内容
+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label;

-(NSArray *)getSeparatedLinesFromLabel;

-(void)alignTop;

-(void)alignBottom;

@end
