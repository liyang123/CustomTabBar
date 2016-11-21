//
//  LYTabBarViewController.m
//  TabBarAnimation
//
//  Created by liyang on 16/11/21.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "LYTabBarViewController.h"
#import "LYNavigationController.h"

#import "LYFirstController.h"
#import "LYSecondController.h"
#import "LYThirdController.h"
#import "LYForthController.h"
#import "LYFifthController.h"

#import "LYTabBar.h"

@interface LYTabBarViewController ()<LYTabBarDelegate>

/** btnItmes */
@property (nonatomic, strong) NSMutableArray *btnItems;
/** LYTabBar */
@property (nonatomic, strong) LYTabBar *customTabBar;

@end

@implementation LYTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    
    [self setupTabBar];
}
#pragma mark - get方法
- (NSMutableArray *)btnItems
{
    if (!_btnItems) {
        _btnItems = [NSMutableArray array];
    }
    return _btnItems;
}

#pragma mark - 初始化子控制器
- (void)setupChildViewControllers
{
    [self addChildViewController:[[LYFirstController alloc] init] title:@"微信" image:[UIImage imageNamed:@"tabbar_mainframe"] selectImage:[UIImage LYImageGetOriginalImgWithImageName:@"tabbar_mainframeHL"]];
    [self addChildViewController:[[LYSecondController alloc] init] title:@"通讯录" image:[UIImage imageNamed:@"tabbar_contacts"] selectImage:[UIImage LYImageGetOriginalImgWithImageName:@"tabbar_contactsHL"]];
    [self addChildViewController:[[LYThirdController alloc] init] title:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] selectImage:[UIImage LYImageGetOriginalImgWithImageName:@"tabbar_discoverHL"]];
    [self addChildViewController:[[LYForthController alloc] init] title:@"我" image:[UIImage imageNamed:@"tabbar_me"] selectImage:[UIImage LYImageGetOriginalImgWithImageName:@"tabbar_meHL"]];
    [self addChildViewController:[[LYFifthController alloc] init] title:@"微信" image:[UIImage imageNamed:@"tabbar_mainframe"] selectImage:[UIImage LYImageGetOriginalImgWithImageName:@"tabbar_mainframeHL"]];
}

- (void)addChildViewController:(UIViewController *)childVc title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
    LYNavigationController *nc = [[LYNavigationController alloc] initWithRootViewController:childVc];
    nc.tabBarItem.title = title;
    nc.tabBarItem.image = image;
    nc.tabBarItem.selectedImage = selectImage;
    [self addChildViewController:nc];
    
    // 收集系统的item到数组中
    [self.btnItems addObject:nc.tabBarItem];
}

#pragma mark - 自定义TabBar
- (void)setupTabBar
{
    // 移除系统的TabBar，移除后，并不会马上消失，一般在下一次循环时，判断这个对象有没有强引用，没有的话，才销毁
    [self.tabBar removeFromSuperview];
    // 自定义的
    LYTabBar *tabBar = [[LYTabBar alloc] init];
    tabBar.frame = CGRectMake(0, kScreenHeight-64, kScreenWidth, 64);
    tabBar.delegate = self;
    tabBar.items = self.btnItems;
    [self.view addSubview:tabBar];
    self.customTabBar = tabBar;
}
#pragma mark - 在视图刚出现的时候，移除掉不是我们的tabBarItem
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 把系统的tabBar上的按钮干掉
    for (UIView *childView in self.tabBar.subviews) {
        [childView removeFromSuperview];
    }
}

#pragma mark - LYTabBarDelegate代理方法
- (void)tabBar:(LYTabBar *)tabBar didClickIndex:(NSUInteger)index
{
    self.selectedIndex = index;
}

@end
