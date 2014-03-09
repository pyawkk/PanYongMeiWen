//
//  PMTabBarController.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-28.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMTabBarController.h"
#import "PMArticleViewController.h"
#import "PMSentenceViewController.h"
#import "PMRadioViewController.h"
#import "PMSettingViewController.h"
#import "PMNavigationController.h"
#import "PMTabBar.h"

@interface PMTabBarController ()<PMTabBarDelegate>
{
    PMTabBar *_customTabBar ;
}
@end

@implementation PMTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.添加自定义的tabBar(这一步一定要先，这样才能添加到tabBar上面)
    [self addCustTabBar];
    //2.添加所有的子控件
    [self addAllChildViewController];
}

/**
 *  自定义的TabBar
 */
-(void)addCustTabBar
{
    PMTabBar *custTabBar = [[PMTabBar alloc] init];
    custTabBar.delegate = self;
    custTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:custTabBar];
    _customTabBar = custTabBar;
}


/**
 *    实现切换tabBar页面的代理方法
 *
 *  @param tabBar 被点击的tabBar
 *  @param from   从那个控制页面
 *  @param to     选择的页面
 */
-(void)tabBar:(PMTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //移除之前的所有子控件
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


/**
 *  添加所有的子控件
 */
-(void)addAllChildViewController
{
    PMSentenceViewController *sentence = [[PMSentenceViewController alloc] init];
    [self addChildViewController:sentence title:@"美句" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    PMArticleViewController *article = [[PMArticleViewController alloc] init];
    [self addChildViewController:article title:@"美文" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    PMRadioViewController *radio = [[PMRadioViewController alloc] init];
    [self addChildViewController:radio title:@"电台" image:@"tabbar_music" selectedImage:@"tabbar_music_selected"];
    
    PMSettingViewController *setting = [[PMSettingViewController alloc] init];
    [self addChildViewController:setting title:@"设置" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];

}



/**
 *  tabBar添加一个子控制器
 *
 *  @param childController 自控制器
 *  @param title           控制器的标题
 *  @param image           图片
 *  @param selectedImage   选中图片
 */
-(void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //1、设置标题和图片
    childController.tabBarItem.title = title;
    UIImage *img = [UIImage imageWithNamed:image];
    childController.tabBarItem.image = img;
    UIImage *selectedImg = [UIImage imageWithNamed:selectedImage];
    //设置badgeValue
    childController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",arc4random_uniform(20)];
    //ios7有图片自动渲染功能，应该禁止
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        childController.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childController.tabBarItem.selectedImage = selectedImg;
    }
    
    //2、包装导航控制器
    PMNavigationController *nav = [[PMNavigationController alloc]initWithRootViewController:childController];
    childController.title = title ;
    
    //3.添加到tabBarController
    
    [self addChildViewController:nav];
    
    //4、添加一个按钮
    [_customTabBar addTabBarButtonWithItem:childController.tabBarItem];
    
}



@end
