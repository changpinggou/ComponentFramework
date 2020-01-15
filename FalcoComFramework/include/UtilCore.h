//  Created by applechang on 2018/11/12.
//  Copyright © 2018年 applechang. All rights reserved.

#import <Foundation/Foundation.h>

@interface TXUtilCore<ObjectType> : NSObject
+(BOOL)LaunchFalcoComFramework:(NSString*)coreXmlPath;
+(ObjectType)CreateObject:(NSString *)iid withClsid:(NSString *)clsid;
+(ObjectType)GetService:(NSString *)iid withClsid:(NSString *)clsid;
@end

@interface TXUtilType<ObjectType> : NSObject
+(ObjectType)Cast:(id)rawType;
@end
