#import "ComponentObjectRoot.h"
#import "ITXComponent.h"

@interface TXComponentObjectRoot()
{
    NSMutableArray<NSString*>* _classNameList;
    NSMutableDictionary<NSString*, id<ITXObject>>* _comServiceList;
}
@end

@implementation TXComponentObjectRoot

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (id<ITXClassFactory>)sharedInstance
{
    static TXComponentObjectRoot *sharedInstance = nil;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        sharedInstance = [[self class] new];
    });
    
    return (id<ITXClassFactory>)sharedInstance;
}

+ (BOOL)LoadWithLocalCfg:(NSString *)cfgPath {
    //从配置里读取组件对象信息
    return YES;
}


- (id<ITXObject>)GetService:(NSString *)iid withClsid:(NSString *)clsid {
    NSUInteger index = [_classNameList indexOfObject:clsid];
    if (index == NSNotFound) {
        NSLog(@"class =%@ donesn't exist!", clsid);
        return nil;
    }
    
    Protocol* protocol = NSProtocolFromString(iid);
    Class temp = NSClassFromString(clsid);
    if (![temp conformsToProtocol:protocol]) {
        NSLog(@"class =%@ donesn't conforms to protocol = %@", clsid, iid);
        return nil;
    }
    
    id<ITXObject> svr = [_comServiceList objectForKey:clsid];
    if (svr != nil) {
        return (id<ITXObject>)svr;
    }
    
    svr = [[temp alloc] init];
    [_comServiceList setObject:svr forKey:clsid];
    
    return svr;
}

- (id<ITXObject>)CreateInstance:(NSString *)iid withClsid:(NSString *)clsid{
    //为了简化，暂时把配置干掉吧！！！
//    NSUInteger index = [_classNameList indexOfObject:clsid];
//    if (index == NSNotFound) {
//        NSLog(@"class =%@ donesn't exist!", clsid);
//        return nil;
//    }
    
    Protocol* protocol = NSProtocolFromString(iid);
    Class temp = NSClassFromString(clsid);
    if (![temp conformsToProtocol:protocol]) {
        NSLog(@"class =%@ donesn't conforms to protocol = %@", clsid, iid);
        return nil;
    }
    
    id<ITXObject> inst = [[temp alloc]init];
    return inst;
}
@end
