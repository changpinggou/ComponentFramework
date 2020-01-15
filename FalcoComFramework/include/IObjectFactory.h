#import <Foundation/Foundation.h>
#import "ITXComponent.h"

@protocol ITXObjectFactory <NSObject>
@required
-(BOOL)AddPlatformConfig:(NSDictionary*)objectsNode;
-(void)SetComponentMgr:(id<ITXComponentMgr>)comMgr;
-(id<ITXObject>)CreateObject:(NSString *)iid withClsid:(NSString *)clsid;
@end
