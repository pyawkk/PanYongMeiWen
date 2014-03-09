//
//  PMTabBar.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-29.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMTabBar.h"
#import "PMTabBarButton.h"
@interface PMTabBar()
{
    PMTabBarButton *_selectBtn;
    int _selectTag;
}
@end
@implementation PMTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置tabBar的背景色，将图片转为颜色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"tabbar_background"]];

    }
    return self;
}


-(void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem
{
    //1.创建按钮
    PMTabBarButton *btn = [[PMTabBarButton alloc] init];
    //2.设置frame
    CGFloat btnW = self.frame.size.width / 4;
    CGFloat btnH = self.frame.size.height;
    btn.frame = CGRectMake(btnW * _selectTag, 0, btnW, btnH);
    
    //3.设置图片和标题
    btn.item = tabBarItem;
    
    //4.设置监听
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //5.添加到视图
    [self addSubview:btn];
    
    //6.设置默认选中按钮
    btn.tag = _selectTag;
    if (_selectTag == 0) {
        _selectBtn = btn;
        btn.selected = YES;
    }
    _selectTag ++;
}

//监听方法，
-(void)btnClick:(PMTabBarButton *)btn
{
    //0.通知代理方法
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [_delegate tabBar:self didSelectButtonFrom:_selectBtn.tag to:btn.tag];
    }
    
    //1.改变选中状态
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
}






@end
