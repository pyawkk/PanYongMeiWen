//
//  PMStatusTool.m
//  PanYongMeiWen
//
//  Created by panyong on 14-2-3.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMStatusTool.h"
#import "PMHTTPTool.h"
@implementation PMStatusTool

+ (void)statusesWithAccessToken:(NSString *)accessToken success:(StatusSuccess)success failure:(HttpFailure)failure
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = accessToken;
    
//    {
//            "pageflag": "0",
//            "pagetime": "0",
//            "reqnum": "20",
//            "contenttype": "0",
//            "type": "0",
//            "format": "json",
//            "access_token": "200e36d8b75a2beed6b9a33928d53b4a",
//            "oauth_consumer_key": "801058005",
//            "openid": "D1914303BC8017CA56C681558314453F",
//            "oauth_version": "2.a",
//            "clientip": "42.49.45.94",
//            "scope": "all",
//            "appfrom": "php-sdk2.0beta",
//            "seqid": 1391443196,
//            "serverip": "183.60.10.172"
//    }
    
    PMLog(@"accesstonk的结果%@",accessToken);
    NSString *string = @"?format=json&pageflag=0&pagetime=0&reqnum=20&contenttype=0&type=0&access_token=200e36d8b75a2beed6b9a33928d53b4a&oauth_consumer_key=801058005&openid=D1914303BC8017CA56C681558314453F&oauth_version=2.a&clientip=42.49.45.94&scope=all";
    //以下是没发出去的url  原来这里是要以获取到的access_token后的参数啊！
//    access_token=bd89dd358b270f5173f9b10e8b756372&expires_in=8035200&refresh_token=1831e213b5893f6fce6d02b1b6edc485&openid=90871e21aff85d0fa124813d11afde22&name=a624204727&nick=舞天歌&state=
    NSString *requestStr = [NSString stringWithFormat:@"?format=json&pageflag=0&pagetime=0&reqnum=20&type=0&contenttype=0&oauth_consumer_key=801472809&access_token=%@&openid=90871e21aff85d0fa124813d11afde22&oauth_version=2.a&clientip=42.49.45.94&scope=all",accessToken];
    
    NSLog(@"%@",requestStr);
    
    [PMHTTPTool getWithURL:@"https://open.t.qq.com/api/statuses/home_timeline" path:requestStr success:^(id string) {
       //NSArray *array = string[@"data"];
        //PMLog(@"data数据为：%@",array);
    //将数据类型转化为json类型
        //NSData *myData = string[@"data"];
         
      
        PMLog(@"获取数据成功%@",string);
        PMLog(@"获取数据成功%@",[string class]);
        
//        NSMutableArray *statuses = [NSMutableArray array];
//        for (NSDictionary *dict in array) {
//            IWStatus *status = [[IWStatus alloc] init];
//            // 解析字典的所有键值对为模型属性
//            [status setValues:dict];
//            
//            [statuses addObject:status];
//        }
//        
//        if (success) {
//            success(statuses);
//        }
    } failure:failure];
    
    
    // 2.发送请求
//    [PMHTTPTool getWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
//        
//        NSArray *array = json[@"statuses"];
//        
//        NSMutableArray *statuses = [NSMutableArray array];
//        for (NSDictionary *dict in array) {
//            IWStatus *status = [[IWStatus alloc] init];
//            // 解析字典的所有键值对为模型属性
//            [status setValues:dict];
//            
//            [statuses addObject:status];
//        }
//        
//        if (success) {
//            success(statuses);
//        }
//        
//    } failure:failure];
}


@end
