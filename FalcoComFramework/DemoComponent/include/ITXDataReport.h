#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>
#import "ITXComponent.h"

@protocol ITXDataReport <ITXObject>
@required
-(void)setCSChannel;
-(void)reportData;
@end

#ifdef __cplusplus
extern "C" {
#endif
    id<ITXDataReport> TXDataReport(void);
#ifdef __cplusplus
}
#endif

