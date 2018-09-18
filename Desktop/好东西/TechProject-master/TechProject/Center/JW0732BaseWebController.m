//
//  JW0732BaseWebController.m
//  Postre
//
//  Created by CoderLT on JW0732/5/22.
//  Copyright © JW0732年 CoderLT. All rights reserved.
//

#import "JW0732BaseWebController.h"
#import "JW0732KDAlertView.h"
#import "KDDefines.h"

@interface NSDate (Add)
- (NSString *)stringWithFormat:(NSString *)format;
@end
@implementation NSDate (Add)
- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}
@end

@interface JW0732NJKWebViewProgressView : UIView
@property (nonatomic) float progress;

@property (nonatomic) UIView *progressBarView;
@property (nonatomic) NSTimeInterval JW0732barAnimationDuration; // default 0.1
@property (nonatomic) NSTimeInterval JW0732fadeAnimationDuration; // default 0.27
@property (nonatomic) NSTimeInterval JW0732fadeOutDelay; // default 0.1

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end

@implementation JW0732NJKWebViewProgressView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
    _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIColor *tintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]; // iOS7 Safari bar color
    if ([[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal][NSForegroundColorAttributeName]) {
        tintColor = [[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal][NSForegroundColorAttributeName];
    }
    else if ([UIApplication.sharedApplication.delegate.window respondsToSelector:@selector(setTintColor:)] && UIApplication.sharedApplication.delegate.window.tintColor) {
        tintColor = UIApplication.sharedApplication.delegate.window.tintColor;
    }
    _progressBarView.backgroundColor = tintColor;
    [self addSubview:_progressBarView];
    
    _JW0732barAnimationDuration = 0.27f;
    _JW0732fadeAnimationDuration = 0.27f;
    _JW0732fadeOutDelay = 0.1f;
}

- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}
- (void)setProgress:(float)progress animated:(BOOL)animated {
    BOOL isGrowing = progress > 0.0;
    [UIView animateWithDuration:(isGrowing && animated) ? _JW0732barAnimationDuration : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = _progressBarView.frame;
        frame.size.width = progress * self.bounds.size.width;
        _progressBarView.frame = frame;
    } completion:nil];
    
    if (progress >= 1.0) {
        [UIView animateWithDuration:animated ? _JW0732fadeAnimationDuration : 0.0 delay:_JW0732fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 0.0;
        } completion:^(BOOL completed){
            CGRect frame = _progressBarView.frame;
            frame.size.width = 0;
            _progressBarView.frame = frame;
        }];
    }
    else {
        [UIView animateWithDuration:animated ? _JW0732fadeAnimationDuration : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 1.0;
        } completion:nil];
    }
}
@end


static CGFloat _initProgress = 0.20f;
@interface JW0732BaseWebController ()
@property (nonatomic, assign) BOOL loadSuccess;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *baseURLString;
@property (nonatomic, copy)   NSString *urlString;
@property (nonatomic, copy)   NSString *webNavTitle;
@property (nonatomic, strong) JW0732NJKWebViewProgressView *progressView;

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *forwardItem;
@end
@implementation JW0732BaseWebController
+ (instancetype)jw0704JW0732KDManager:(NSString *)urlString {
    return [self jw0704JW0732KDManager:urlString shareTitle:nil shareUrl:nil];
}
+ (instancetype)jw0704JW0732KDManager:(NSString *)urlString shareTitle:(NSString *)shareTitle shareUrl:(NSString *)shareUrl {
    JW0732BaseWebController *webView = [[self alloc] init];
    webView.urlString = urlString;
    webView.shareUrl = shareUrl;
    webView.shareTitle = shareTitle;
    return webView;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:STATUS_BAR_HIGHT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-TOOL_BAR_HIGHT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addSubview:self.progressView];
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.progressView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:STATUS_BAR_HIGHT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.progressView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.progressView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.progressView addConstraint:[NSLayoutConstraint constraintWithItem:self.progressView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:2.0f]];
    
    [self.view addSubview:self.toolBar];
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolBar
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-TAB_BAR_ADDING]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolBar
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolBar
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.toolBar addConstraint:[NSLayoutConstraint constraintWithItem:self.toolBar
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:44]];
    
    [self.observeKeyPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.webView addObserver:self forKeyPath:obj options:NSKeyValueObservingOptionNew context:nil];
    }];
    
    [self webViewRequestDidUpdateProgress:self.webView.estimatedProgress];
    [self reloadToolBar];
}

- (NSArray<NSString *> *)observeKeyPaths {
    return @[@"title", @"canGoBack", @"canGoForward", @"estimatedProgress", @"scrollView.contentOffset"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"canGoBack"] || [keyPath isEqualToString:@"canGoForward"]) {
        [self reloadToolBar];
    }
    else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self webViewRequestDidUpdateProgress:self.webView.estimatedProgress];
    }
    else if ([keyPath isEqualToString:@"scrollView.contentOffset"]) {
        if ([change[@"new"] CGPointValue].y == 0 && [change[@"old"] CGPointValue].y != 0 && [change[@"old"] CGPointValue].y == -self.webView.scrollView.contentInset.top) {
            self.webView.scrollView.contentOffset = CGPointMake(self.webView.scrollView.contentOffset.x, -self.webView.scrollView.contentInset.top);
        }
    }
}

- (void)dealloc {
    @try {
        [self.observeKeyPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.webView removeObserver:self forKeyPath:obj];
        }];
    } @catch (NSException *exception) {
        
    }
}

#pragma mark - 加载页面
- (void)setUrlString:(NSString *)urlString {
    _urlString = [urlString copy];
    [self headerRefreshing];
}
- (void)headerRefreshing {
    if (self.urlString.length > 0) {
        NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                            relativeToURL:[NSURL URLWithString:self.baseURLString]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        self.loadSuccess = NO;
        NSLog(@"准备加载：%@", request.URL.absoluteString);
    }
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载：%@", webView.URL.absoluteString);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self webViewRequestDidStart];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"开始接收：%@", webView.URL.absoluteString);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成: %@",webView.URL.absoluteString);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.loadSuccess = YES;
    [self webViewRequestingDidEnd];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error {
    NSLog(@"加载失败: %@",webView.URL.absoluteString);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self webViewRequestingDidEnd];
}

// 处理外部跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *scheme= navigationAction.request.URL.scheme;
    if (!([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"])) {
        NSURL *url = navigationAction.request.URL;
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            NSLog(@"外部跳转: %@", navigationAction.request.URL);
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }
            }
            else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

// window.open
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        if (navigationAction.navigationType == WKNavigationTypeFormSubmitted) {
            [webView evaluateJavaScript:@"$('form').serialize()" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
                NSLog(@"%@, %@", obj, error);
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:navigationAction.request.URL];
                [request setHTTPMethod:@"POST"];
                [request setHTTPBody:[obj dataUsingEncoding:NSUTF8StringEncoding]];
                [webView loadRequest:request];
            }];
        }
        else {
            [webView loadRequest:navigationAction.request];
        }
    }
    return nil;
}

// js 里面的alert实现，如果不实现，网页的alert函数无效
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    [JW0732KDAlertView JW0732showTitle:nil message:message buttons:@[@"确定"] completion:^(NSUInteger index, NSString *buttonTitles) {
        completionHandler();
    }];
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    [JW0732KDAlertView JW0732showTitle:nil message:message buttons:@[@"确定"] completion:^(NSUInteger index, NSString *buttonTitles) {
        completionHandler(index == 1);
    }];
}

#pragma mark - actions

- (void)webViewRequestDidStart {
    [self webViewRequestDidUpdateProgress:self.webView.estimatedProgress];
}
- (void)webViewRequestingDidEnd {
}
- (void)webViewRequestDidUpdateProgress:(CGFloat)progress {
    progress = _initProgress + (1.0f - _initProgress) * progress;
    self.progressView.hidden = NO;
    [self.progressView setProgress:progress animated:YES];
    NSLog(@"progressView  %.4f", progress);
}

- (void)reloadToolBar {
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
}
- (void)didClickHome:(id)sender {
    NSLog(@"didClickHome");
    [self headerRefreshing];
}
- (void)didClickBack:(id)sender {
    NSLog(@"didClickBack");
    [self.webView goBack];
}
- (void)didClickForward:(id)sender {
    NSLog(@"didClickForward");
    [self.webView goForward];
}
- (void)didClickRefresh:(id)sender {
    NSLog(@"didClickRefresh");
    [self.webView reload];
}
- (void)didClickMenu:(id)sender {
    NSLog(@"didClickMenu");
    [KDActionSheet JW0732showTitle:nil message:nil buttons:@[@"分享", @"清除缓存"] completion:^(NSUInteger index, NSString *buttonTitles) {
        NSLog(@"%ld, %@", (long)index, buttonTitles);
        if (index == 0) {
            NSArray *items = @[self.shareTitle ?: @"", [NSURL URLWithString:self.shareUrl ?: self.urlString ?: @""]];
            UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                                 applicationActivities:nil];
            [self presentViewController:activityViewController animated:YES completion:nil];
        }
        else if (index == 1) {
            NSSet *websiteDataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]];
            NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            }];
            
            NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSError *errors;
            [[NSFileManager defaultManager] removeItemAtPath:libraryPath error:&errors];
            
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            [[NSFileManager defaultManager] removeItemAtPath:cachePath error:&errors];
        }
    }];
}

#pragma mark - getter
- (NSString *)baseURLString {
    if (_baseURLString) {
        return _baseURLString;
    }
    return nil;
}

- (NSString *)webNavTitle {
    if (_webNavTitle) {
        return _webNavTitle;
    }
    return self.webView.title;
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if (@available(iOS 9.0, *)) {
            _webView.allowsLinkPreview = NO;
        }
    }
    return _webView;
}

- (JW0732NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        CGFloat progressBarHeight = 2.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        _progressView = [[JW0732NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _progressView.hidden = YES;
    }
    return _progressView;
}

- (UIImage *)imageNamed:(NSString *)name {
    return [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"BaseWeb" ofType:@"bundle"]] pathForResource:name ofType:nil]];
}

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.backgroundColor = [UIColor whiteColor];
        UIBarButtonItem *fixItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixItem.width = 20;
        self.backItem = [[UIBarButtonItem alloc] initWithImage:[self imageNamed:@"back@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBack:)];
        self.forwardItem = [[UIBarButtonItem alloc] initWithImage:[self imageNamed:@"forward@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickForward:)];
        [_toolBar setItems:@[
                             [[UIBarButtonItem alloc] initWithImage:[self imageNamed:@"home@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickHome:)],
                             fixItem,
                             self.backItem,
                             fixItem,
                             self.forwardItem,
                             fixItem,
                             [[UIBarButtonItem alloc] initWithImage:[self imageNamed:@"refresh@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRefresh:)],
                             fixItem,
                             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                             [[UIBarButtonItem alloc] initWithImage:[self imageNamed:@"menu@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickMenu:)]]];
    }
    return _toolBar;
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
