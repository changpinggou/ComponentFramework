#import "DataReportCoObject.h"

@interface DataReportCoObject()
{
    
}
@end

@implementation DataReportCoObject
- (void)reportData {
    NSLog(@"DataReportCoObject:reportData");
}

- (void)setCSChannel {
    NSLog(@"DataReportCoObject:setCSChannel");
}

@end

id<ITXDataReport> TXDataReport(void)
{
//    static DataReportCoObject *sharedInstance = nil;
//    static dispatch_once_t token;
//    dispatch_once(&token, ^{
//        sharedInstance = [[DataReportCoObject alloc]init];
//    });
//
//    return sharedInstance;
    return nil;
}
