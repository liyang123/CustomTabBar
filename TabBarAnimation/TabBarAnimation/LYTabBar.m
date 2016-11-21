//
//  LYTabBar.m
//  TabBarAnimation
//
//  Created by liyang on 16/11/21.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "LYTabBar.h"

#define custom_w  kScreenWidth/5
#define custom_h  64

@interface LYTabBar ()

/** lastNorImg */
@property (nonatomic, strong) UIImageView *lastnorImg;
/** lastselectImg */
@property (nonatomic, strong) UIImageView *lastselectImg;

@end

@implementation LYTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
// 先默认设置64的高度
- (void)setItems:(NSArray *)items
{
    _items = items;
    for (int i = 0; i<items.count; i++) {
        UITabBarItem *item = items[i];
        
        LYCustomTabBarView *custom = [[LYCustomTabBarView alloc] initWithTitle:item.title imgName:item.image selectImgName:item.selectedImage];
        custom.frame = CGRectMake(custom_w*i, 0, custom_w, custom_h);
        [custom.norImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(norImgTapAction:)]];
        [custom.selectImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImgTapAction:)]];
        [self addSubview:custom];
    }
}

#pragma mark - 动作按钮事件
- (void)norImgTapAction:(UITapGestureRecognizer *)sender
{
    UIImageView *nor = (UIImageView *)[sender view];
    UIImageView *select = [nor.superview viewWithTag:2001];
    [UIView animateWithDuration:0.25 animations:^{
        if (self.lastnorImg&&self.lastselectImg) {
            self.lastselectImg.alpha = 0;
            self.lastnorImg.alpha = 1;
            self.lastselectImg.frame = CGRectMake((custom_w-25)/2, custom_h-20-25, 25, 23);
            self.lastnorImg.frame = CGRectMake((custom_w-25)/2, custom_h-20-25, 25, 23);
        }
        nor.alpha = 0;
        select.alpha = 1;
        select.frame = CGRectMake((custom_w-37.5)/2, 0, 37.5, 34.5);
        nor.frame = select.frame;
        
        self.lastnorImg = nor;
        self.lastselectImg = select;
    }];
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickIndex:)]) {
        NSUInteger count = [self.subviews indexOfObject:nor.superview];
        [self.delegate tabBar:self didClickIndex:count];
    }
    
}

- (void)selectImgTapAction:(UITapGestureRecognizer *)sender
{
    UIImageView *select = (UIImageView *)[sender view];
    UIImageView *nor = [select.superview viewWithTag:2000];
    [UIView animateWithDuration:0.25 animations:^{
        if (self.lastnorImg&&self.lastselectImg) {
            self.lastselectImg.alpha = 0;
            self.lastnorImg.alpha = 1;
            self.lastselectImg.frame = CGRectMake((custom_w-25)/2, custom_h-20-25, 25, 23);
            self.lastnorImg.frame = CGRectMake((custom_w-25)/2, custom_h-20-25, 25, 23);
        }
        nor.alpha = 1;
        select.alpha = 0;
        self.lastnorImg = nor;
        self.lastselectImg = select;
    }];
}

@end


#pragma mark - 自定义控件
@implementation LYCustomTabBarView
// 先默认设置64的高度
- (instancetype)initWithTitle:(NSString *)title imgName:(UIImage *)norImg selectImgName:(UIImage *)selectImg
{
    self = [super init];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title.length?title:@"微信";
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0, custom_h-20, custom_w, 20);
        [self addSubview:titleLabel];
        self.title = titleLabel;
        
        UIImageView *norImgView = [[UIImageView alloc] init];
        norImgView.image = norImg;
        norImgView.userInteractionEnabled = YES;
        norImgView.tag = 2000;
        norImgView.frame = CGRectMake((custom_w-25)/2, self.title.ly_y-25, 25, 23);
        norImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:norImgView];
        self.norImg = norImgView;
        
        UIImageView *selectImgView = [[UIImageView alloc] init];
        selectImgView.image = selectImg;
        selectImgView.userInteractionEnabled = YES;
        selectImgView.alpha = 0;
        selectImgView.tag = 2001;
        selectImgView.frame = CGRectMake((custom_w-25)/2, self.title.ly_y-25, 25, 23);
        selectImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:selectImgView];
        self.selectImg = selectImgView;
    }
    return self;
}

@end
