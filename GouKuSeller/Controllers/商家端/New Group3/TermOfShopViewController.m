//
//  TermOfShopViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/18.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TermOfShopViewController.h"

@interface TermOfShopViewController ()

@property (nonatomic ,strong)UIWebView      *myWebview;

@end

@implementation TermOfShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家违规条例";
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
}

- (void)onCreate{
    self.myWebview = [[UIWebView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight, SCREEN_WIDTH - 30, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight)];
    [self.view addSubview:self.myWebview];
    NSString *txtPath=[[NSBundle mainBundle]pathForResource:@"商家违规条例" ofType:@"md"];
    ///编码可以解决 .txt 中文显示乱码问题
    NSStringEncoding *useEncodeing = nil;
    //带编码头的如utf-8等，这里会识别出来
    NSString *body = [NSString stringWithContentsOfFile:txtPath usedEncoding:useEncodeing error:nil];
    
    //识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug。
    if (!body) {
        body = [NSString stringWithContentsOfFile:txtPath encoding:0x80000632 error:nil];
    }
    //还是识别不到，按GB18030编码再解码一次.
    if (!body) {
        body = [NSString stringWithContentsOfFile:txtPath encoding:0x80000631 error:nil];
    }
    //展现
    if (body) {
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        id userData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (userData) {
            if ([userData isKindOfClass:[NSDictionary class]])
            {

            }
        }
        [self.myWebview loadHTMLString:body baseURL: nil];
    }else {
        NSString *urlString = [[NSBundle mainBundle] pathForAuxiliaryExecutable:txtPath];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *requestUrl = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        [self.myWebview loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
