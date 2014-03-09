//
//  PMOAuthViewController.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-30.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMOAuthViewController.h"
#import "AFNetworking.h"
#import "PMHTTPTool.h"
#import "PMTabBarController.h"
#import "PMAccount.h"
#import "MBProgressHUD+Add.h"
#import "PMAccountTool.h"
@interface PMOAuthViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    NSString *_code;
}
@end

@implementation PMOAuthViewController

-(void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    self.view = _webView;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	//加载请求  貌似后面最好加上&wap=2 不然狗日的腾讯不买账啊
    NSString *requestStr = KRequestURL;
    NSURL *url = [NSURL URLWithString:requestStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载，请稍后……" toView:self.view];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

}


/**
 *  webView每发送一次请求就会调用一次
 *
 *  @param webView        是哪个webView发送的请求
 *  @param request        发送的是什么样的请求
 *
 *  @return YES：可以发送请求  NO：不可以发送请求
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.获取到回调的url地址
    NSString *urlStr = request.URL.absoluteString ;
    //2.获取code= 的位置信息
    NSRange range = [urlStr rangeOfString:@"code="];
    //3.取出回掉的code信息
    if (range.location != NSNotFound) {
        //因为返回的字符串，所以需要对字符串进行截取处理
        int fromIndex = range.length + range.location;
        NSString *string = [urlStr substringFromIndex:fromIndex ];
        PMLog(@"%@",string);
        NSArray *strArr = [urlStr componentsSeparatedByString:@"&"];
        NSRange newRange = [strArr[0] rangeOfString:@"code="];
        int newFromIndex = newRange.length + newRange.location;
        NSString *newString = [strArr[0] substringFromIndex:newFromIndex ];
        PMLog(@"code=%@",newString);
        _code = newString;
        //PMLog(@"%@",strArr);
        //4.根据code获取用户的accesstoken
        //[self getAccessToken:newString];
        
        //新抽出来的代码，直接到
        [PMAccountTool accessTokenWithCode:newString success:^{
            // 显示首页（PWTabBarContoller）
            self.view.window.rootViewController = [[PMTabBarController alloc] init];
        } failure:^(NSError *err) {
            PMLog(@"获取accessToken失败%@",err);
        }];
        return NO;
    }
    
    return YES;
}





/**
*client_id	 true	 申请应用时分配的app_key
*client_secret	 true	 申请应用时分配的app_secret
*grant_type	 true	 authorization_code
*code	 true	 调用authorize时返回的code
*redirect_uri	 true	 授权回调地址，必须和应用注册的地址一致（地址长度上限为256个字节）
*/
-(void)getAccessToken:(NSString *)code
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
        NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [doc
                          stringByAppendingPathComponent:@"account.data"];
        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        // 2.3.显示首页（PWTabBarContoller）
        self.view.window.rootViewController = [[PMTabBarController alloc] init];
        
    } failure:^(NSError *err) {
        PMLog(@"获取accessToken失败%@",err);
    }];

}





@end
