//
//  LYFirstController.m
//  TabBarAnimation
//
//  Created by liyang on 16/11/21.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "LYFirstController.h"

@interface LYFirstController ()

@end

@implementation LYFirstController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if (self.titleBlock) {
//        self.titleBlock(@"first");
//    }
    self.navigationItem.title = @"fist";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
