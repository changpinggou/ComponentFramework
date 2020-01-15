//  Created by applechang on 2018/11/19.
//  Copyright © 2018年 applechang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITXInterface1.h"
#import "ITXInterface2.h"
#import "ITXInterface3.h"

@interface ClassA : NSObject<ITXInterface1, ITXInterface2, ITXInterface3>
@end
