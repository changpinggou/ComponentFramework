#import "ClassA.h"

@interface ClassA()
{
    
}
@end

@implementation ClassA
-(void)setQQEnvVar
{
    NSLog(@"setQQEnvVar");
}

-(void)loginWithQQ
{
    NSLog(@"loginWithQQ");
}

-(void)setWeixinEnvVar
{
    NSLog(@"setWeixinEnvVar");
}

-(void)loginWithWeixin
{
    NSLog(@"loginWithWeixin");
}

-(void)LogObjectInfo
{
    NSString* currentClass =  NSStringFromClass([self class]);
    NSLog(@"LogObjectInfo:%@", currentClass);
}
@end
