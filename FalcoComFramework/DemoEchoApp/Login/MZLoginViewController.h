#import <UIKit/UIKit.h>

@protocol MZLoginMgrDelegate <NSObject>
@optional
-(void)onQQLogin;
-(void)onWeixinLogin;
@end

@interface MZLoginViewController : UIViewController
-(instancetype)init;
@property (nonatomic, strong) id<MZLoginMgrDelegate> loginDelegate;
@end
