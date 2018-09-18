//
//  WebViewController.m
//  DriverAssistant
//
//  Created by C on JW 16/3/31.
//  Created by C on JW 118 rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UIWebView *_webView;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _myTitle;
}

- (instancetype)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
    }
    return self;
}

@end
