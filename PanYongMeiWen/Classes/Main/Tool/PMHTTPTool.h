//
//  PMHTTPTool.h
//  PanYongMeiWen
//
//  Created by panyong on 14-1-31.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMHTTPTool : NSObject

//定义HttpSuccess的块代码
typedef void (^HttpSuccess)(id string);
typedef void (^HttpFailure)(NSError *err);

/**
 *  AFN发送httpGet请求
 *
 *  @param url     请求地址
 *  @param path    请求参数
 *  @param success 成功回掉的块代码
 *  @param failure 失败回掉的块代码
 */

+ (void)getWithURL:(NSString *)url path:(NSString *)path success:(HttpSuccess)success failure:(HttpFailure)failure;


@end
