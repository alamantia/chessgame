//
//  CodePage.m
//  whalecombat
///Users/anthonyl/code/whalecombat/whalecombat/CodePage.m
//  Created by anthony lamantia on 8/26/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "CodePage.h"

@implementation CodePage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
#if 0
    NSString *text = @"\u2665\u263A\u263B\u2591\u2591\u2591\u2591\u2591\u2591\u2591\u2591\u2591\u2591\u2592\u2593\u2663\u25B2";
    [text drawInRect:rect withFont:[UIFont systemFontOfSize:32.0]];
    // Drawing code
#endif
}

@end
