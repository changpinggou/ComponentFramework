#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>
#import "ITXComponent.h"

@protocol ITXWeixinLogin <ITXObject>
@required
-(void)setWeixinEnvVar;
-(void)loginWithWeixin;
@end
