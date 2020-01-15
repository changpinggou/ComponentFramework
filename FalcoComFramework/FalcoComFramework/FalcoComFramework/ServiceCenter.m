#import "ServiceCenter.h"
#import "ClassMetaInfo.h"
#import "XMLDictionary.h"

@interface TXSeviceCenter()
{
    NSMutableDictionary<NSString*, TXServiceinfo*>* _platformServiceInfo;//平台申明的service信息
    id<ITXComponentMgr> _comMgr;
}
@end

@implementation TXSeviceCenter

-(instancetype)init
{
    if (self = [super init]) {
        _platformServiceInfo = [[NSMutableDictionary<NSString*, TXServiceinfo*> alloc] init];
        _comMgr = nil;
    }
    return self;
}
- (BOOL)AddPlatformConfig:(NSDictionary *)objectsNode {
    NSArray* objectsArray= [objectsNode arrayValueForKeyPath:@"platform.object"];
    for (NSDictionary* dic in objectsArray){
        NSString* type = [dic objectForKey:@"_type"];
        if ([type isEqualToString:@"service"]) {
            NSString* name = [dic objectForKey:@"_name"];
            NSString* iid = [dic objectForKey:@"_iid"];
            NSString* clsname = [dic objectForKey:@"_clsname"];
            TXServiceinfo* seviceInfo = [[TXServiceinfo alloc]init];
            seviceInfo.name = name;
            seviceInfo.iid = iid;
            seviceInfo.clsid = clsname;
            seviceInfo.comid = @"platform";
            [_platformServiceInfo setObject:seviceInfo forKey:name];
        }
    }
    return YES;
}

- (id<ITXObject>)GetService:(NSString *)iid withClsid:(NSString *)clsid {
    TXServiceinfo* platServiceInfo = [_platformServiceInfo objectForKey:clsid];
    if (!platServiceInfo) {
        return nil;
    }
    
    if (platServiceInfo.service != nil) {
        return platServiceInfo.service;
    }

    if ([platServiceInfo.comid isEqualToString:@""]) {
        Protocol* protocol = NSProtocolFromString(iid);
        Class temp = NSClassFromString(clsid);
        if (![temp conformsToProtocol:protocol]) {
            NSLog(@"class =%@ donesn't conforms to protocol = %@", clsid, iid);
            return nil;
        }
        
        id<ITXObject> inst = [[temp alloc]init];
        platServiceInfo.service = inst;
        return  inst;
    }
    
    if (_comMgr != nil) {
        id<ITXClassFactory> classFactory = [_comMgr QueryComponent:iid];
        if (classFactory != nil) {
            return [classFactory GetService:iid withClsid:clsid];
        }
    }
    
    return nil;
}

- (void)SetComponentMgr:(id<ITXComponentMgr>)comMgr {
    _comMgr = comMgr;
}

@end
