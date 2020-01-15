#import "ComponentMgr.h"
#import "ClassMetaInfo.h"
#import "UtilCore.h"
#import "XMLDictionary.h"

@interface TXComponentMgr()
{
    NSMutableDictionary<NSString*, TXObjectInfo*>*    _interfaceInfoList;    //组件接口信息
    NSMutableDictionary<NSString*, id<ITXClassFactory>>* _componentStubList;    //组件对象
}
@end

@implementation TXComponentMgr

-(instancetype)init
{
    if (self = [super init]) {
        _interfaceInfoList = [[NSMutableDictionary alloc]init];
        _componentStubList = [[NSMutableDictionary alloc]init];
    }
    return self;
}

#pragma mark ITXComponentMgr
-(BOOL)AddComponentConfig:(NSDictionary*)comCfgList
{
    if (comCfgList == nil) {
        return NO;
    }
    
    NSArray* componentsArray = [comCfgList arrayValueForKeyPath:@"components.component"];
    for (NSDictionary* element in componentsArray){
        NSString* componentName = [element objectForKey:@"_name"];
        NSArray* objectsArray= [element arrayValueForKeyPath:@"object"];
        for (id obj in objectsArray){
            NSDictionary* dic = (NSDictionary*)obj;
            NSString* type = [dic objectForKey:@"_type"];
            TXObjectInfo* objinfo = nil;
            if ([type isEqualToString:@"service"]) {
                objinfo = [[TXServiceinfo alloc]init];
            }else if([type isEqualToString:@"object"]){
                objinfo = [[TXObjectInfo alloc]init];
            }
            
            NSString* name = [dic objectForKey:@"_name"];
            NSString* clsname = [dic objectForKey:@"_clsname"];

            objinfo.name = name;
            objinfo.type = type;
            objinfo.clsid = clsname;
            objinfo.comid = componentName;
            [_interfaceInfoList setObject:objinfo forKey:name];
        }
    }
    return YES;
}

- (BOOL)NotifyExit {
    //todo:
    return YES;
}

- (id<ITXClassFactory>)QueryComponent:(NSString *)iid {
    TXObjectInfo* interfaceInfo = [_interfaceInfoList objectForKey:iid];
    if (interfaceInfo == nil) {
        return nil;
    }
    NSString* comStubClassName = interfaceInfo.comid;
    id<ITXClassFactory> component = [_componentStubList objectForKey:comStubClassName];
    if (component != nil) {
        return [TXUtilType<id<ITXClassFactory>> Cast:component];
    }
    Class<ITXComponent> comStubClass = NSClassFromString(comStubClassName);
    if (comStubClass == nil) {
        return nil;
    }
    
    id<ITXClassFactory> factory = [comStubClass sharedInstance];
    if (factory == nil) {
        return nil;
    }
    [_componentStubList setObject:factory forKey:comStubClassName];
    
    return factory;
}
@end
