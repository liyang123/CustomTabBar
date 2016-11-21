//
//  UIBarButtonItem+LYExtension.h
//  BaiSi
//
//  Created by liyang on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LYExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
