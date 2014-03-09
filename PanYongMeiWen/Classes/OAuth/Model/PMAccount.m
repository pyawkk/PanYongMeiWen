//
//  PMAccount.m
//  PanYongMeiWen
//
//  Created by panyong on 14-2-1.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMAccount.h"

@implementation PMAccount

/**
 *  将文件写入对象
 */

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _access_token = [decoder decodeObjectForKey:@"_access_token"];
        _expires_in = [decoder decodeObjectForKey:@"_expires_in"];
        _refresh_token = [decoder decodeObjectForKey:@"_refresh_token"];
        _name = [decoder decodeObjectForKey:@"_name"];
        _openid = [decoder decodeObjectForKey:@"_openid"];
    }
    return self;
}


/**
*  将对象写入文件
*/
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_access_token forKey:@"_access_token"];
    [encoder encodeObject:_expires_in forKey:@"_expires_in"];
    [encoder encodeObject:_refresh_token forKey:@"_refresh_token"];
    [encoder encodeObject:_name forKey:@"_name"];
    [encoder encodeObject:_openid forKey:@"_openid"];

}






@end
