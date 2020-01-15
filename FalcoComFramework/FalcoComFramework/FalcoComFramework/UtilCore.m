#import "UtilCore.h"
#import "ITXComponent.h"
#import "ITXCoreCenter.h"
#import "IObjectFactory.h"

@implementation TXUtilCore
+(BOOL)LaunchFalcoComFramework:(NSString*)coreXmlPath
{
    id<ITXCoreCenter> coreCenter =  TXFalcoComFramework();
    return [coreCenter setCoreConfigPath:coreXmlPath];
}

+(id)CreateObject:(NSString *)iid withClsid:(NSString *)clsid
{
    id<ITXCoreCenter> coreCenter =  TXFalcoComFramework();
    id<ITXObjectFactory> objectFactory = [coreCenter GetObjectFactory];
    return [objectFactory CreateObject:iid withClsid:clsid];
}

+(id)GetService:(NSString *)iid withClsid:(NSString *)clsid
{
    id<ITXCoreCenter> coreCenter =  TXFalcoComFramework();
    id<ITXServiceCenter> serviceFactory = [coreCenter GetServiceFactory];
    return [serviceFactory GetService:iid withClsid:clsid];
}
@end

@implementation TXUtilType
+(id)Cast:(id)rawType
{
    return rawType;
}
@end

