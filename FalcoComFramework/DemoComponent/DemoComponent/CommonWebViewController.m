#import "CommonWebViewController.h"
#import <WebKit/WebKit.h>



@interface CommonWebViewController()<UINavigationControllerDelegate,UIScrollViewDelegate>
{
    CGPoint _offsetPoint;
}

@property (nonatomic,strong )WKWebView *wkWebView;
@property (nonatomic, retain) UIButton *backButton;     //返回按钮
//当前正在加载的URL，用于取bid，之后加载的资源用url中的bid
@property (nonatomic, assign) BOOL leftButtonHidden;
@property (nonatomic, assign) NSInteger iconType;   //设置按钮和状态栏风格 1-黑色 2-白色
@property (nonatomic, assign) NSInteger hywv;

@property (nonatomic, strong) UIButton *devToolsBtn;
@property (nonatomic, copy) NSURL  *currentLoadingURL;

@property (nonatomic, assign) BOOL useWKWebView;  //业务决定的是否要使用wkwebview


@property (nonatomic,strong)NSMutableDictionary *extInfo;
@property (nonatomic, copy) NSURL  *devLoadingURL;
@end
//当前正在加载的URL，用于取bid，之后加载的资源用url中的bid
@implementation CommonWebViewController
{
}

@synthesize leftButtonHidden = _leftButtonHidden;

- (void)dealloc
{
    self.devToolsBtn = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // [self setCookie];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    //[self updateLeftButtonHidden];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

-(instancetype)init
{

    self = [super init];
    if (self)
    {
        self.extInfo = [NSMutableDictionary dictionary];
    }
    return self;
}



-(void)createWebView
{
    _wkWebView = [[WKWebView alloc]init];
    _wkWebView.backgroundColor = [UIColor clearColor];
    _wkWebView.opaque = NO;
    _wkWebView.scrollView.delegate = self;
    _wkWebView.frame = self.view.bounds;
    [self.view addSubview:_wkWebView];

}

-(void)viewWillAppear:(BOOL)animated
{
    if((self.hywv & HYWV_HIDE_NAVBAR_SHOW_BACKBTN)>0 ) {
        [self setIconColor:self.iconType];
    }
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark - WKWebView Delegate Methods
/*
 * Called on iOS devices that have WKWebView when the web view wants to start navigation.
 * Note that it calls shouldStartDecidePolicy, which is a shared delegate method,
 * but it's essentially passing the result of that method into decisionHandler, which is a block.
 // 在发送请求之前，决定是否跳转
 */
- (void) webView: (WKWebView *) webView decidePolicyForNavigationAction: (WKNavigationAction *) navigationAction decisionHandler: (void (^)(WKNavigationActionPolicy)) decisionHandler
{
    //允许跳转
//    [self HandleRequest:navigationAction.request.URL];
//    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
}

- (void)setIconColor:(NSInteger)iconType
{
    _iconType = iconType;

    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)setLeftButtonHidden:(BOOL)leftButtonHidden
{
    _leftButtonHidden = leftButtonHidden;
    [self updateLeftButtonHidden];
}

- (BOOL)leftButtonHidden
{
    return _leftButtonHidden;
}

- (void)updateLeftButtonHidden
{
    if (_leftButtonHidden) {
        _backButton.hidden = YES;
    }else{
        if((self.hywv & HYWV_HIDE_NAVBAR_SHOW_BACKBTN)>0 ) {
            _backButton.hidden = NO;
        } else {
            _backButton.hidden = YES;
        }
    }
}

- (void)onBackButtonClick
{
}

-(void)loadUrl:(NSString *)url
{
    NSMutableString* newURL = [url mutableCopy];
    self.currentLoadingURL = [NSURL URLWithString:newURL];
    if(self.wkWebView == nil)
    {
        [self createWebView];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newURL]];
    [self.wkWebView loadRequest:request];
}
-(NSURL *)getURL
{
    return self.currentLoadingURL;
}

- (void)executeJsScript:(NSString *)script
{
    //[self.webView  stringByEvaluatingJavaScriptFromString:script];
}

-(NSDictionary *)getWebInfo
{
    return _extInfo;
}

#pragma Decoration

-(void)setScrollViewOffset:(int)value//设置web页面往下滚动距离
{
    
}

@end
