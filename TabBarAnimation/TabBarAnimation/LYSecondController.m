//
//  LYSecondController.m
//  TabBarAnimation
//
//  Created by liyang on 16/11/21.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "LYSecondController.h"

@interface LYSecondController ()

@end

@implementation LYSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.title = @"second";
    
    self.view.backgroundColor = kRandomColor;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
