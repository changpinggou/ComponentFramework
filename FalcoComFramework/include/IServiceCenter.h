#import <Foundation/Foundation.h>
#import "ITXComponent.h"

@protocol ITXServiceCenter <NSObject>
@required
-(BOOL)AddPlatformConfig:(NSDictionary*)objectsNode;
-(void)SetComponentMgr:(id<ITXComponentMgr>)comMgr;
-(id<ITXObject>)GetService:(NSString *)iid withClsid:(NSString *)clsid;
@end
