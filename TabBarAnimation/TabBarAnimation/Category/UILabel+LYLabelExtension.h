//
//  UILabel+LYLabelExtension.h
//  JDChat
//
//  Created by liyang on 16/8/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LYLabelExtension)


/**
 *  自定义的label初始化方法
 *
 *  @param text      label的文字
 *  @param textColor label的文字颜色
 *  @param labelFont label的文字大小
 *
 *  @return label
 */
+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)labelFont;

/** 注意：label必须现有text值了，才调用下面的这个方法 */
- (CGSize)labelSize;


@end
