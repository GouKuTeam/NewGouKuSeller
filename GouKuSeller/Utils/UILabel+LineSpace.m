//
//  UILabel+LineSpace.m
//  juliye-C-iphone
//
//  Created by lixiao on 16/8/17.
//  Copyright © 2016年 juliye. All rights reserved.
//

#import "UILabel+LineSpace.h"
#import "NSString+Size.h"
#import <CoreText/CoreText.h>

@implementation UILabel (LineSpace)

-(void)alignTop {
    CGSize fontSize =[self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n "];
}

-(void)alignBottom {
    CGSize fontSize =[self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[NSString stringWithFormat:@" \n%@",self.text];
}

- (CGFloat)getSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width{
    if (str_text.length == 0) {
        str_text = @"";
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.lineSpacing = 0;
    paraStyle.maximumLineHeight = self.font.pointSize;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0
                          };
    if ([self getSpaceHeightWithText:str_text withWidth:width] > self.font.pointSize) {
        paraStyle.lineSpacing = 5;
    }else{
        paraStyle.lineSpacing = 0;
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str_text attributes:dic];
    self.attributedText = attributeStr;
    self.numberOfLines = 0;
    CGSize size = CGSizeMake(width, 500000);
    CGSize labelSize = [self sizeThatFits:size];
    return labelSize.height;
}

- (void)setSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width{
    if (str_text.length == 0) {
        str_text = @"";
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.lineSpacing = 0;
    paraStyle.maximumLineHeight = self.font.pointSize;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0
                          };
    if ([self getSpaceHeightWithText:str_text withWidth:width] > self.font.pointSize) {
        paraStyle.lineSpacing = 5;
    }else{
        paraStyle.lineSpacing = 0;
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str_text attributes:dic];
    self.attributedText = attributeStr;
    self.numberOfLines = 0;
}

- (CGFloat)getSpaceHeightWithText:(NSString*)str_text withWidth:(CGFloat)width{
    if (str_text.length == 0) {
        str_text = @"";
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.lineSpacing = 0;
    paraStyle.maximumLineHeight = self.font.pointSize;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str_text attributes:dic];
    self.attributedText = attributeStr;
    self.numberOfLines = 0;
    CGSize size = CGSizeMake(width, 500000);
    CGSize labelSize = [self sizeThatFits:size];
    return labelSize.height;
}

- (void)setSpaceLabelHeightWithText:(NSString*)str_text Color:(UIColor *)color{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paraStyle.lineSpacing = 5;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.maximumLineHeight = self.font.pointSize;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str_text attributes:dic];
    NSArray *strAry = [str_text componentsSeparatedByString:@":"];

    NSString *string = strAry[0];
    if ([str_text rangeOfString:@":"].location != NSNotFound) {
        NSRange rangeStr = NSMakeRange(0, string.length+1);
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:rangeStr];
        NSRange range = [string rangeOfString:@"回复"];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_TEXT_HARDGRAY] range:range];
    }

    self.attributedText = attributeStr;
    self.numberOfLines = 0;
}

+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

- (NSArray *)getSeparatedLinesFromLabel {
    NSString *text = [self text];
    UIFont *font = [self font];
    CGRect rect = [self frame];
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

- (CGFloat)getSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width withFont:(UIFont *)font withRange:(NSRange)range{
    if (str_text.length == 0) {
        str_text = @"";
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.lineSpacing = 0;
    paraStyle.alignment = NSTextAlignmentJustified;
    paraStyle.maximumLineHeight = self.font.pointSize + 2;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0
                          };
    if ([self getSpaceHeightWithText:str_text withWidth:width] > self.font.pointSize) {
        paraStyle.lineSpacing = 5;
    }else{
        paraStyle.lineSpacing = 0;
    }
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str_text attributes:dic];
    [attributeStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attributeStr;
    self.numberOfLines = 0;
    CGSize size = CGSizeMake(width, 500000);
    CGSize labelSize = [self sizeThatFits:size];
    return labelSize.height;
}


@end
