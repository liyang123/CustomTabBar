//
//  LYSecondController.h
//  TabBarAnimation
//
//  Created by liyang on 16/11/21.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSecondController : UIViewController

/** 更改title  */
@property (nonatomic, copy) void(^titleBlock)(NSString *title);

@end
