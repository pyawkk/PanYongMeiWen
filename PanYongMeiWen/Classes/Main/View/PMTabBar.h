//
//  PMTabBar.h
//  PanYongMeiWen
//
//  Created by panyong on 14-1-29.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMTabBar;
@protocol  PMTabBarDelegate <NSObject>

@optional
/**
 * PMTabBar里面的代理方法
 *
 *  @param tabBar 被点中的PMTabBar
 *  @param from   原来按钮的位置
 *  @param to     选择按钮的位置
 */
-(void)tabBar:(PMTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;

@end

@interface PMTabBar : UIView



/**
 *  通过一个Item来添加一个tabBarButton
 */
-(void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem;

//设置代理属性
@property (nonatomic,weak) id<PMTabBarDelegate> delegate;

@end
