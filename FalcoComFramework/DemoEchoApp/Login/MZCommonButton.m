
#import "MZCommonButton.h"

@implementation MZCommonButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:230/255. green:184/255. blue:0/255. alpha:1.];
    } else {
        self.backgroundColor = [UIColor colorWithRed:250/255. green:225/255. blue:0/255. alpha:1.];
    }
}

@end
