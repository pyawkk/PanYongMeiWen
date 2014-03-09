//
//  PMAccountTool.m
//  PanYongMeiWen
//
//  Created by panyong on 14-2-2.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMAccountTool.h"
#import "PMHTTPTool.h"
#import "PMAccount.h"
#import "PMTabBarController.h"
#define PMAccountPath [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation PMAccountTool
static PMAccount *_currentAccount;

+(void)saveAccount:(PMAccount *)account
{
    // 2.2.存储账号模型对象
    NSString *path = PMAccountPath;
    [NSKeyedArchiver archiveRootObject:account toFile:path];

}

+(PMAccount *)currentAccount
{
    if (_currentAccount == nil) {
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:PMAccountPath];
    }
    return _currentAccount;
}


+(void)accessTokenWithCode:(NSString *)code success:(AccessTokenSuccess)success failure:(HttpFailure)failure
{
    //1.设置请求url
    NSString *requestStr = @"https://open.t.qq.com/cgi-bin/oauth2/access_token";
    NSString *str = [NSString stringWithFormat:@"?client_id=%@&client_secret=%@&redirect_uri=%@&grant_type=authorization_code&code=%@",KAppKey,KAppSecret,KRedirctURL,code];
    //    PMLog(@"请求的地址是：%@",str);
    
    //2.现在利用AFN发送请求
    [PMHTTPTool getWithURL:requestStr path:str success:^(id result) {
        PMLog(@"获取数据成功");
        NSLog(@"%@",result);
        //返回的结果access_token=bd89dd358b270f5173f9b10e8b756372&expires_in=8035200&refresh_token=1831e213b5893f6fce6d02b1b6edc485&openid=90871e21aff85d0fa124813d11afde22&name=a624204727&nick=舞天歌&state=
        
        //2.1创建一个账号模拟对象
        PMAccount *account = [[PMAccount alloc] init];
        
        //现在要将accessToken归档
        NSArray *strArr = [result componentsSeparatedByString:@"&"];
        NSRange newRange = [strArr[0] rangeOfString:@"="];
        int newFromIndex = newRange.length + newRange.location;
        NSString *access_token = [strArr[0] substringFromIndex:newFromIndex ];
        PMLog(@"%@",access_token);
        account.access_token = access_token;
        
        NSRange newRange1 = [strArr[1] rangeOfString:@"="];
        int newFromIndex1 = newRange1.length + newRange1.location;
        NSString *expires_in = [strArr[1] substringFromIndex:newFromIndex1];
        PMLog(@"%@",expires_in);
        account.expires_in = expires_in;
        
        NSRange newRange2 = [strArr[2] rangeOfString:@"="];
        int newFromIndex2 = newRange2.length + newRange2.location;
        NSString *refresh_token = [strArr[2] substringFromIndex:newFromIndex2];
        PMLog(@"%@",refresh_token);
        account.refresh_token = refresh_token;
        
        NSRange newRange3 = [strArr[3] rangeOfString:@"="];
        int newFromIndex3 = newRange3.length + newRange3.location;
        NSString *openid = [strArr[3] substringFromIndex:newFromIndex3];
        PMLog(@"%@",openid);
        account.openid = openid;
        
        NSRange newRange4 = [strArr[4] rangeOfString:@"="];
        int newFromIndex4 = newRange4.length + newRange4.location;
        NSString *name = [strArr[4] substringFromIndex:newFromIndex4];
        PMLog(@"%@",name);
        account.name = name;
        
        // 2.2.存储账号模型对象
        [self saveAccount:account];
        
        //2.4成功
        if (success) {
            success();
        }
        
    } failure:failure];


}



@end
