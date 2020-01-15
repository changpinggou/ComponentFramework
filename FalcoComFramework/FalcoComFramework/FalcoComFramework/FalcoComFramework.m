//
//  FalcoComFramework.m
//  FalcoComFramework
//
//  Created by applechang on 2018/11/22.
//  Copyright © 2018年 applechang. All rights reserved.
//

#import "FalcoComFramework.h"
#import "ObjectFactory.h"
#import "ServiceCenter.h"
#import "ComponentMgr.h"
#import "XMLDictionary.h"

@interface FalcoComFramework()
{
    id<ITXObjectFactory> _objectFactory;
    id<ITXServiceCenter> _serviceFactory;
    id<ITXComponentMgr>  _componentMgr;
}
@end

@implementation FalcoComFramework

-(instancetype)init
{
    if (self = [super init]) {
        _objectFactory  =[TXObjectFactory new];
        _serviceFactory =[TXSeviceCenter new];
        _componentMgr   =[TXComponentMgr new];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static FalcoComFramework *sharedInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[FalcoComFramework alloc]init];
    });
    
    return sharedInstance;
}

-(id<ITXObjectFactory>)GetObjectFactory
{
    return _objectFactory;
}

-(id<ITXServiceCenter>)GetServiceFactory
{
    return _serviceFactory;
}

-(BOOL)setCoreConfigPath:(NSString*)cfgPath
{
    NSDictionary<NSString *, id>* cfg = [NSDictionary dictionaryWithXMLFile:cfgPath];

//    NSDictionary* platformNode = [cfg objectForKey:@"platform"];
//    NSDictionary* componentsNode = [cfg objectForKey:@"components"];

    [_serviceFactory AddPlatformConfig:cfg];
    [_objectFactory  AddPlatformConfig:cfg];
    [_componentMgr  AddComponentConfig:cfg];

    [_objectFactory SetComponentMgr:_componentMgr];
    [_serviceFactory SetComponentMgr:_componentMgr];
    
    return YES;
}
@end

id<ITXCoreCenter> TXFalcoComFramework()
{
    return [FalcoComFramework sharedInstance];
}
