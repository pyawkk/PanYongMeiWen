//
//  UIImage+PM.h
//  PanYongMeiWen
//
//  Created by panyong on 14-1-28.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PM)
+(UIImage *)imageWithNamed:(NSString *)name;
//对图片背景进行不变形拉伸
+(UIImage *)resizedImage:(NSString *)name;
@end
