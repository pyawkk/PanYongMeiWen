//
//  PMTabBarButton.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-29.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMTabBarButton.h"
#import "UIImage+PM.h"
@interface PMTabBarButton()
{
    UIButton *_bageValueBtn;
}

@end

@implementation PMTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1、设置tabBar的图片和文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        //2.设置ios7中按钮字体的颜色
        if (ios7) {
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        //3.设置自定义的bagevalue
        _bageValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bageValueBtn setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
        _bageValueBtn.hidden = YES;
        _bageValueBtn.userInteractionEnabled = NO;
        _bageValueBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        //添加到按钮上
        [self addSubview:_bageValueBtn];

    }
    return self;
}


//覆盖父类的长按方法
-(void)setHighlighted:(BOOL)highlighted{}

#pragma mark - 覆盖父类的2个方法
#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    CGFloat titleY = image.size.height;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    return CGRectMake(0, titleY, self.bounds.size.width,  titleHeight);
}

#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    UIImage *image = [self imageForState:UIControlStateNormal];
    return CGRectMake(0, 0, contentRect.size.width, image.size.height + 5);
}

#pragma mark 通过UITabBarItem给模型付值
-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    //1.利用kvo监听
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:Nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:Nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:Nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:Nil];
    
    //2.付值属性
    [self observeValueForKeyPath:Nil ofObject:Nil change:Nil context:Nil];
    
}

/**
 *  监听的实现方法
 *
 *  @param keyPath 监听的键值
 *  @param object  监听的对象
 *  @param change  改变
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    //设置badgeValue 按钮
    if ([_item.badgeValue intValue]) {
        _bageValueBtn.hidden = NO;
        [_bageValueBtn setTitle:_item.badgeValue forState:UIControlStateNormal];
        CGSize textSize = [_item.badgeValue sizeWithFont:_bageValueBtn.titleLabel.font ];
        CGFloat btnW = textSize.width + 12;
        CGFloat btnH = textSize.height + 5;
        CGFloat btnX = self.frame.size.width - btnW - 10;
        CGFloat btnY = 3;
        _bageValueBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }else
    {
        _bageValueBtn.hidden = YES;
    }

}



/**
 *  移除对象监听
 */
-(void)dealloc
{
    [self removeObserver:_item forKeyPath:@"title"];
    [self removeObserver:_item forKeyPath:@"image"];
    [self removeObserver:_item forKeyPath:@"selectedImage"];
    [self removeObserver:_item forKeyPath:@"badgeValue"];
}


@end
