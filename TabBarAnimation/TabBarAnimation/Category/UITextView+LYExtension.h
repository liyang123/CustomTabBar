//
//  UITextView+LYExtension.h
//  新工程
//
//  Created by liyang on 16/8/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LYExtension)

/** 占位符的label属性 */
@property (nonatomic, readonly) UILabel *placeholderLabel;

/** 拿出占位符的颜色 */
+ (UIColor *)defaultPlaceholderColor;

/** 设置占位符 */
@property (nonatomic, strong) NSString *placeholder;
/** 设置占位符的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;



@end
