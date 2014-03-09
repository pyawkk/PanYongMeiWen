//
//  PMNavigationController.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-28.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMNavigationController.h"

@interface PMNavigationController ()

@end

@implementation PMNavigationController

/**
 *  初始化时调用一次
 */
+(void)initialize
{
    //获取当前导航控制器的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    if (!ios7) {
        //设置当前导航栏的背景
        [navBar setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        //设置状态栏
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    //设置导航栏的标题
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UIColor blackColor] forKey:UITextAttributeTextColor];
    [dic setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [navBar setTitleTextAttributes:dic];
}


/**
 *  重写了navigation的push方法
 *
 *  @param viewController 要push的控制器
 *  @param animated       是否动画
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
