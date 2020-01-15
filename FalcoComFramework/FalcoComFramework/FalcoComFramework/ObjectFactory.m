#import "ObjectFactory.h"
#import "ITXComponent.h"
#import "ClassMetaInfo.h"
#import "XMLDictionary.h"

@interface TXObjectFactory()
{
    NSMutableDictionary<NSString*, TXObjectInfo*>* _platformObjectInfo;//平台接口信息
    id<ITXComponentMgr> _comMgr;
}
@end

@implementation TXObjectFactory
-(instancetype)init
{
    if (self = [super init]) {
        _platformObjectInfo = [[NSMutableDictionary<NSString*, TXObjectInfo*> alloc] init];
        _comMgr = nil;
    }
    return self;
}

#pragma mark ITXObjectFactory
- (BOOL)AddPlatformConfig:(NSDictionary *)objectsNode {
    if (objectsNode == nil) {
        return NO;
    }
    
    NSArray* objectsArray= [objectsNode arrayValueForKeyPath:@"platform.object"];
    for (NSDictionary* dic in objectsArray){
        NSString* type = [dic objectForKey:@"_type"];
        if ([type isEqualToString:@"object"]) {
            NSString* name = [dic objectForKey:@"_name"];
            NSString* iid = [dic objectForKey:@"_iid"];
            NSString* clsname = [dic objectForKey:@"_clsname"];
            TXObjectInfo* objInfo = [[TXObjectInfo alloc]init];
            objInfo.name = name;
            objInfo.iid = iid;
            objInfo.clsid = clsname;
            objInfo.comid = @"platform";
            [_platformObjectInfo setObject:objInfo forKey:name];
        }
    }
    
    return YES;
}

- (BOOL)AddPluginConfig:(NSDictionary *)dataCfg {
    //注册插件包含的对象工厂信息
    //注册插件包含的对象，接口信息
    return YES;
}

-(void)SetComponentMgr:(id<ITXComponentMgr>)comMgr
{
    _comMgr = comMgr;
}

-(id<ITXObject>)CreateObject:(NSString *)iid withClsid:(NSString *)clsid{
    TXObjectInfo* platObjectInfo = [_platformObjectInfo objectForKey:iid];
    if (platObjectInfo) {
        //如果平台信息里面有该对象信息，则创建
        Protocol* protocol = NSProtocolFromString(iid);
        Class temp = NSClassFromString(clsid);
        if (![temp conformsToProtocol:protocol]) {
            NSLog(@"class =%@ donesn't conforms to protocol = %@", clsid, iid);
            return nil;
        }
        
        id<ITXObject> inst = [[temp alloc] init];
        return inst;
    }
    
    id<ITXClassFactory> classFactory = [_comMgr QueryComponent:iid];
    if (classFactory == nil) {
        return nil;
    }
    return [classFactory CreateInstance:iid withClsid:clsid];
}
@end
