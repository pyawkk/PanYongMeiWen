//
//  PMStatusTool.h
//  PanYongMeiWen
//
//  Created by panyong on 14-2-3.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMHTTPTool.h"

typedef void (^StatusSuccess)(NSArray *statuses);


@interface PMStatusTool : NSObject

+ (void)statusesWithAccessToken:(NSString *)accessToken success:(StatusSuccess)success failure:(HttpFailure)failure;


@end
