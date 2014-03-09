//
//  UIImage+PM.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-28.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "UIImage+PM.h"

@implementation UIImage (PM)

/**
 *  图片自动适配
 *
 *  @param name ios6的图片名称
 *
 *  @return 自动适配后的图片名
 */
+(UIImage *)imageWithNamed:(NSString *)name
{
    if (ios7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *img = [UIImage imageNamed:newName];
        if (img == Nil) {
            return [self imageNamed:name];
        }
        return [self imageNamed:newName];
    }else
    {
        return [self imageNamed:name];
    }
}

/**
 *  将图片进行不变形拉伸处理
 *
 *  @param name 图片名
 *
 *  @return 拉伸处理后的图片
 */
+(UIImage *)resizedImage:(NSString *)name{
    UIImage *newImage = [UIImage imageWithNamed:name];
    return [newImage stretchableImageWithLeftCapWidth:newImage.size.width * 0.5 topCapHeight:newImage.size.height * 0.5];
}


@end
