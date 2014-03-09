

//1.判断是否为ios7
#define ios7  ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)

//2.获取RGB颜色
#define PMColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//3.设置全局背景色
#define PMGlobalBgColor   PMColor(226,226,226)

//4.自定义Log
#ifdef DEBUG
#define PMLog(...) NSLog(__VA_ARGS__)
#else
#define PMLog(...)
#endif

//5.appKey
#define KAppKey @"801472809"
#define KAppSecret @"b5e5dc296488133cc6dc8f4a8a873607"
#define KRedirctURL @"http://www.baidu.com"
#define KCode @"7aac0048a74ca6c4cd46c410c0dc75f8"

#define KRequestURL [NSString stringWithFormat:@"https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@&wap=2",KAppKey,KRedirctURL];
