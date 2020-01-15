#import "MZSplashViewController.h"
#import "Masonry.h"

@interface MZSplashViewController ()

@end

@implementation MZSplashViewController

- (UIImage *)getCurrentLaunchImage {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    NSString *interfaceOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) ||
        ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        interfaceOrientation = @"Portrait";
    } else {
        interfaceOrientation = @"Landscape";
    }
    
    NSString *launchImageName = nil;
    
    NSArray *launchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *launchImage in launchImages) {
        CGSize launchImageSize = CGSizeFromString(launchImage[@"UILaunchImageSize"]);
        NSString *launchImageOrientation = launchImage[@"UILaunchImageOrientation"];
        
        if (CGSizeEqualToSize(launchImageSize, screenSize) &&
            [launchImageOrientation isEqualToString:interfaceOrientation]) {
            launchImageName = launchImage[@"UILaunchImageName"];
            break;
        }
    }
    
    return [UIImage imageNamed:launchImageName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[self getCurrentLaunchImage]];
    [self.view addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
