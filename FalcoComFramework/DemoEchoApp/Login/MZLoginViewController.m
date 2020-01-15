#import "MZLoginViewController.h"
#import "Masonry.h"
#import "MZCommonButton.h"

@interface MZLoginViewController ()
//@property (nonatomic, strong) MZLoginMgr* loginMgr;
@property (nonatomic, strong) MZCommonButton* qqButton;
@property (nonatomic, strong) MZCommonButton* wxButton;
//@property (nonatomic, strong) CommonWebViewController *webViewVC;
//@property (nonatomic, strong) QQProgressHUD* progressHud;
@end

@implementation MZLoginViewController

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

+ (UIImage*)loadImageWithName:(NSString*)imgName
{
    UIImage* image = nil;
    NSString* extension;
    NSString*  bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Resource/Images"];
    NSRange range = [imgName rangeOfString:@"@" options:NSBackwardsSearch];
    if (range.location != NSNotFound) { //带了@的，说明为全称，不再判断添加@判断
        return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath, imgName]];
    }
    range = [imgName rangeOfString:@"." options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        extension = [imgName substringFromIndex:range.location+1];
        imgName = [imgName substringToIndex:range.location];
    }
    //先按系统适配规则查找，比如有些视觉2x、3x是不同的图片
    NSString* fullPath = [NSString stringWithFormat:@"%@/%@%@%@", bundlePath, imgName, @".", extension];
    image = [UIImage imageWithContentsOfFile: fullPath];
    
    if (image != nil)
    {
        return image;
    }
    
    //按系统规则找不到，就按照先找3x、再找2x，大部分情况下都是3x的，1x就不需要单独找了，1x存在的话，按系统适配规则肯定能查得到
    //先找3x
    image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@%@%@", bundlePath, imgName, @"@3x.", extension]];
    if (image != nil) {
        return image;
    }
    //再找2x
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@%@%@", bundlePath, imgName, @"@2x.", extension]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    _progressHud = [QQProgressHUD new];

    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[MZLoginViewController loadImageWithName:@"Entry/login_logo.png"]];
    
    [self.view addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(142);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(203);
    }];
    
    _wxButton = [MZCommonButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_wxButton];
    [_wxButton setBackgroundColor:[UIColor colorWithRed:250/255. green:225/255. blue:0/255. alpha:1.]];
    _wxButton.layer.cornerRadius = 20;
    _wxButton.clipsToBounds = YES;
    [_wxButton setTitle:@"微信登录" forState:UIControlStateNormal];
    [_wxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_wxButton setTitle:@"微信登录" forState:UIControlStateDisabled];
    [_wxButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_wxButton setTitle:@"微信登录" forState:UIControlStateHighlighted];
    _wxButton.titleLabel.font = [UIFont systemFontOfSize:19];

    [_wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-56.5);
    }];
    [_wxButton addTarget:self action:@selector(onWXLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    
    MZCommonButton *_qqButton = [MZCommonButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_qqButton];
    [_qqButton setBackgroundColor:[UIColor colorWithRed:250/255. green:225/255. blue:0/255. alpha:1.]];
    _qqButton.layer.cornerRadius = 20;
    _qqButton.clipsToBounds = YES;
    [_qqButton setTitle:@"QQ登录" forState:UIControlStateNormal];
    [_qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_qqButton setTitle:@"QQ登录" forState:UIControlStateDisabled];
    [_qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_qqButton setTitle:@"QQ登录" forState:UIControlStateHighlighted];
    _qqButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [_qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(40);
        if (_wxButton) {
            make.bottom.mas_equalTo(_wxButton.mas_top).offset(-20);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-56.5);
        }
    }];
    [_qqButton addTarget:self action:@selector(onQQLoginClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (bool)validateNetwork {
    return true;
}

- (void)onQQLoginClicked {
    [self.loginDelegate onQQLogin];
}

- (void)onWXLoginClicked {
    [self.loginDelegate onWeixinLogin];
}

- (void)enableLoginButton:(bool)value
{
    _wxButton.enabled = value;
    _qqButton.enabled = value;
}
@end
