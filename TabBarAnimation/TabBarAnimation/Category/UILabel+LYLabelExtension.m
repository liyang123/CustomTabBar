//
//  UILabel+LYLabelExtension.m
//  JDChat
//
//  Created by liyang on 16/8/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "UILabel+LYLabelExtension.h"

@implementation UILabel (LYLabelExtension)

- (CGSize)labelBoundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

/**
 *  自定义的label初始化方法
 *
 *  @param text      label的文字
 *  @param textColor label的文字颜色
 *  @param labelFont label的文字大小
 *
 *  @return label
 */
+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)labelFont
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:labelFont];
    label.numberOfLines = 0;
    return label;
}
- (CGSize)labelSize
{
    CGRect rect = [self textRectForBounds:CGRectMake(0, 0, 999, 999) limitedToNumberOfLines:0];
    return rect.size;
}
@end
