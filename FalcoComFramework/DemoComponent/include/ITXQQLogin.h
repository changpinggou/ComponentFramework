#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>
#import "ITXComponent.h"

@protocol ITXQQLogin <ITXObject>
@required
-(void)setQQEnvVar;
-(void)loginWithQQ;
@end
