//
//  PMAccountTool.h
//  PanYongMeiWen
//
//  Created by panyong on 14-2-2.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMHTTPTool.h"
#import "PMAccount.h"
// accessToken获取成功后的回调
typedef void (^AccessTokenSuccess)();

@interface PMAccountTool : NSObject

/**
 *  保存账号信息
 *
 *  @param account 需要保存的账号对象
 */
+ (void)saveAccount:(PMAccount *)account;

/**
 *  返回当前的账号信息
 */
+ (PMAccount *)currentAccount;

/**
 *  获得accessToken
 *
 *  @param code    code参数值（专门用来换取accessToken的）
 *  @param success accessToken获取成功后的回调
 *  @param failure accessToken获取失败后的回调
 */
+ (void)accessTokenWithCode:(NSString *)code success:(AccessTokenSuccess)success failure:(HttpFailure)failure;

@end
