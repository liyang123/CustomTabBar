//
//  UIBarButtonItem+LYExtension.m
//  BaiSi
//
//  Created by liyang on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "UIBarButtonItem+LYExtension.h"

@implementation UIBarButtonItem (LYExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}
@end
