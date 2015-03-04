//
//  WBOAuthController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBOAuthController.h"
#import "MBProgressHUD+GP.h"
#import <AFNetworking.h>
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "AppDelegate.h"

@interface WBOAuthController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,weak) MBProgressHUD *currHUD;

@end

@implementation WBOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebView];
    [self startOAuth];
}

#pragma mark - OAuth主方法
- (void)startOAuth{
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code",kClient_id,kRedirect_uri];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];

}

#pragma mark - 初始化webView
- (void)setUpWebView{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.currHUD = [MBProgressHUD showMessage:@"正在玩命加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.currHUD hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.currHUD hide:YES];
//    WBLog(@"OAuth 请求出错 %@",error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
    if ( range.length > 0 ) {
        NSInteger index = range.location + range.length;
        NSString *code = [request.URL.absoluteString substringFromIndex:index];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}


#pragma mark - 请求 accessToken
- (void)accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSSet *acceptContentType = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet *acceptContentTypeM = [NSMutableSet setWithSet:acceptContentType];
    // text/plain
    [acceptContentTypeM addObject:@"text/plain"];
    manager.responseSerializer.acceptableContentTypes = acceptContentTypeM;
    NSString *tokenURLString = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = kClient_id;
    params[@"client_secret"] = kClient_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = kRedirect_uri;
    [manager POST:tokenURLString parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *dict) {
        WBAccount *account = [WBAccount accountWithDict:dict];
        [WBAccountTool saveAccount:account];
        [self switchToAppMainViewController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WBLog(@"OAuth请求token出错 %@",error);
    }];
}

- (void)switchToAppMainViewController{
    [(AppDelegate *)[UIApplication sharedApplication].delegate switchToMainViewController];
}

@end
