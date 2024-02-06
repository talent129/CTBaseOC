//
//  UILabel+string.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UILabel+string.h"
#import <CoreText/CoreText.h>

@implementation UILabel (string)

- (void)setText:(NSString *)text 
    lineSpacing:(CGFloat)lineSpacing {
    if (StrEmpty(text) || lineSpacing < 0.1) {
        self.text = text;
        return;
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpacing]; //设置行间距
    [style setLineBreakMode:self.lineBreakMode];
    [style setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
}


/// 创建label/默认单行
/// @param font font description
/// @param textColor textColor description
/// @param alignment alignment description
+ (instancetype)labelWithFont:(UIFont *)font 
                    textColor:(UIColor *)textColor
                    alignment:(NSTextAlignment)alignment {
    return [self labelWithFont:font textColor:textColor alignment:alignment numberOfLine:1 backgroundColor:[UIColor clearColor]];
}


/// 创建label
/// @param font font description
/// @param textColor textColor description
/// @param alignment alignment description
/// @param numberOfLine numberOfLine description
/// @param backgroundColor backgroundColor description
+ (instancetype)labelWithFont:(UIFont *)font 
                    textColor:(UIColor *)textColor
                    alignment:(NSTextAlignment)alignment
                 numberOfLine:(NSUInteger)numberOfLine
              backgroundColor:(UIColor *)backgroundColor {
    UILabel *label = [UILabel new];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.numberOfLines = numberOfLine;
    label.backgroundColor = backgroundColor;
    return label;
}


/// 创建label/默认单行
/// @param font font description
/// @param textColor textColor description
/// @param alignment alignment description
/// @param text text description
+ (instancetype)labelWithFont:(UIFont *)font 
                    textColor:(UIColor *)textColor
                    alignment:(NSTextAlignment)alignment
                         text:(NSString *)text {
    UILabel *label = [self labelWithFont:font textColor:textColor alignment:alignment];
    label.text = text;
    return label;
}


+ (NSArray <NSString *> *)getLinesArrayOfLabelRows:(CGFloat)labelWidth 
                                              text:(NSString *)text
                                              font:(UIFont *)font  {
    if (text == nil) {
        return nil;
    }
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:(NSString *)kCTFontAttributeName
                   value:(__bridge  id)myFont
                   range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,labelWidth,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

@end
