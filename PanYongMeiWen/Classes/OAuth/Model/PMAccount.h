//
//  PMAccount.h
//  PanYongMeiWen
//
//  Created by panyong on 14-2-1.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMAccount : NSObject <NSCoding>

//access_token	 访问第三方资源的凭证
@property (nonatomic,copy) NSString *access_token;
//expires_in	 accesstoken过期时间，以返回的时间的准，单位为秒，注意过期时提醒用户重新授权
@property (nonatomic,copy) NSString *expires_in;
//refresh_token	 刷新token
@property (nonatomic,copy) NSString *refresh_token;
//name 授权的name
@property (nonatomic,copy) NSString *name;
//openid
@property (nonatomic,copy) NSString *openid;

@end
