#import <Foundation/Foundation.h>
#import "ITXComponent.h"

@interface TXObjectInfo : NSObject
@property(retain, nonatomic) NSString* name;  //接口name
@property(retain, nonatomic) NSString* comid; //组件名
@property(retain, nonatomic) NSString* clsid; //类名
@property(retain, nonatomic) NSString* iid;   //接口guid
@property(retain, nonatomic) NSString* type;  //service or object
@end

@interface TXServiceinfo : TXObjectInfo
@property(retain, nonatomic) id<ITXObject> service;  //service对象
@end
