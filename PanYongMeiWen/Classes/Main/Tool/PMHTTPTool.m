//
//  PMHTTPTool.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-31.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMHTTPTool.h"
#import "AFNetworking.h"
@implementation PMHTTPTool

+ (void)getWithURL:(NSString *)url path:(NSString *)path success:(HttpSuccess)success failure:(HttpFailure)failure
{
    
    //1.1创建client对象，设置url路径
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:url]];
    //1.2请求url
    NSURLRequest *request = [client requestWithMethod:@"get" path:path parameters:Nil];
    //2.创建操作对象
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            // 转换成字符串
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

            //调用块代码，向上传递数据
            success(result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    //3.执行此操作
    [operation start];
    
    
}


@end
