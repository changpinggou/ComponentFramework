#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>
#import "IObjectFactory.h"
#import "IServiceCenter.h"

@protocol ITXCoreCenter <NSObject>
@required
-(id<ITXObjectFactory>)GetObjectFactory;
-(id<ITXServiceCenter>)GetServiceFactory;
-(BOOL)setCoreConfigPath:(NSString*)cfgPath;
@end

#ifdef __cplusplus
extern "C" {
#endif
    id<ITXCoreCenter> TXFalcoComFramework(void);
#ifdef __cplusplus
}
#endif




