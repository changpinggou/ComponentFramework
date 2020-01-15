#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>
#import "ITXComponent.h"

typedef enum {
    HYWV_SHOW_NAVBAr            =  0,       //显示完整的导航栏
    HYWV_HIDE_NAVBAR_SHOW_BACKBTN = 1 << 0,   //隐藏导航栏，显示返回按钮
    HYWV_HIDE_NAVBAR_BACKBTN =  1 <<1 ,   //隐藏导航栏和返回按钮
    HYWV_TRANSPARENT       =  1 <<2 ,  // 背景透明
    HYWV_NOT_FULLWEB        =  1 <<3 ,  //非全屏页
}V_hywv;

typedef enum
{
    WEB_START_LOAD = 0,     //网页开始加载
    WEB_LOAD_FINISHED = 1,  //网页加载完成
    WEB_LOAD_FAIL   = 2,   //网页加载失败
}webViewEventType;

typedef enum
{
    SCROLLVIEW_BEGIN_DRAG = 0,   // 滚动开始
    SCROLLVIEW_DID_SCROLL = 1,           //滚动过程中
    SCROLLVIEW_WILL_END_DRAGGING   = 2,   //滚动结束
}webCtrlEventType;
typedef enum
{
    CALL_COMMON_API = 0,
    NOT_CALL_COMMON_API = 1,
}apiCallReturnType;

typedef NS_ENUM(NSInteger, WebViewCoreType) {
    WebViewCoreType_UIWebView = 0,    // 使用UIWebView
    WebViewCoreType_WKWebView         // 使用WKWebView
};

//@protocol WebViewJSBridgeDelegate <NSObject>
//@required
//-(apiCallReturnType)onHandleApiCall:(ODJSBridgeSchemeParse *)jsbridgeSchemeParse;
//@end

@protocol WebViewEventDelegate <ITXObject>
@required
-(void) onWebEvent:(webViewEventType )name withParam:(NSObject *)param;
@end

@protocol WebCtrlEventDelegate <ITXObject>
@required
-(void) onWebCtrlEvent:(webCtrlEventType )name withParam:(NSObject *)param;
@end


@protocol IWebViewDecoration<ITXObject>
@required
-(void)setBackgroundView:(UIView*)view;
-(void)setScrollViewOffset:(int)value;//设置web页面往下滚动距离
-(void)setBackgroundTransparent:(BOOL)value;
-(void)setWebLoadTimeout:(NSTimeInterval)seconds;
-(void)setWebViewRect:(CGRect)rect;
-(void)enableScroll:(BOOL)value;
@end


@protocol IWebViewNavBarStyle <NSObject>
@required
- (void)setIconColor:(NSInteger)iconType;
- (void)setLeftButtonHidden:(BOOL)leftButtonHidden;
@end

@class WebViewEventDelegate;
@class WebCtrlEventDelegate;

@protocol IWebViewBase<ITXObject>
@required
-(void)loadUrl:(NSString *)url;
@end

@protocol IWebDevTool<ITXObject>
@required
-(void)toggleDevTool;
@end
@protocol IOfflineWeb<ITXObject>
-(void)handleOffline;
@required

@end


