#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>

@protocol ITXObject <NSObject>
@end

@protocol ITXClassFactory <NSObject>
@required
- (id<ITXObject>)GetService:(NSString *)iid withClsid:(NSString *)clsid;
- (id<ITXObject>)CreateInstance:(NSString *)iid withClsid:(NSString *)clsid;
@end

@protocol ITXComponent <NSObject>
@required
+(BOOL)LoadWithLocalCfg:(NSString*)cfgPath;
+(id<ITXClassFactory>)sharedInstance;
@end

@protocol ITXComponentMgr <NSObject>
@required
-(id<ITXClassFactory>)QueryComponent:(NSString *)iid;
-(BOOL)AddComponentConfig:(NSDictionary*)comCfgList;
-(BOOL)NotifyExit;
@end




