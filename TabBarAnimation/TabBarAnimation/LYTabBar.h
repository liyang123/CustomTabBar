//
//  LYTabBar.h
//  TabBarAnimation
//
//  Created by liyang on 16/11/21.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTabBar;
@protocol LYTabBarDelegate <NSObject>

- (void)tabBar:(LYTabBar *)tabBar didClickIndex:(NSUInteger)index;

@end

@interface LYTabBar : UIView

// 模型数组(UITabBarItem)
@property (nonatomic, strong) NSArray *items;

/** 代理 */
@property (nonatomic, assign) id<LYTabBarDelegate> delegate;

@end


#pragma mark - 自定义控件
@interface LYCustomTabBarView : UIView

/** title */
@property (nonatomic, strong) UILabel *title;

/** norImg */
@property (nonatomic, strong) UIImageView *norImg;

/** select */
@property (nonatomic, strong) UIImageView *selectImg;

- (instancetype)initWithTitle:(NSString *)title imgName:(UIImage *)norImg selectImgName:(UIImage *)selectImg;

@end
