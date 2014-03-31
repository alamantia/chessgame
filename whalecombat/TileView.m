//
//  TileView.m
//  whalecombat
//
//  Created by anthony lamantia on 8/26/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.

#import "TileView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TileView
@synthesize boardLocation, tileColor, tileState, label, contentView, image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        contentView = nil;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float midPointX = (rect.size.width/2) - 25/2;
    float midPointY = (rect.size.height/2) - 25/2;
    
    // Drawing code
    switch ( [tileState integerValue] ) {
        case 1: {
            //self.layer.borderColor = [UIColor greenColor].CGColor;
            //self.layer.borderWidth = 1.0f;
        
            CGContextRef contextRef = UIGraphicsGetCurrentContext();
            CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.5);
            CGContextSetRGBStrokeColor(contextRef, 0, 0, 0, 0.5);
            
            // Draw a circle (filled)
            //CGContextFillEllipseInRect(contextRef, CGRectMake(midPointX, midPointY, 25, 25));
            // Draw a circle (border only)
            //CGContextStrokeEllipseInRect(contextRef, CGRectMake(midPointX, midPointY, 25, 25));
            
            CGContextSetRGBFillColor(contextRef, 0.0, 1, 0, 1.5);
            CGContextSetRGBStrokeColor(contextRef, 1.0, 0, 0, 1.5);
            CGContextFillRect(contextRef, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));

            break;
        }
        case 2: {
            break;
        }
        // tile can be a target.
        case 3: {
            //self.layer.borderColor = [UIColor redColor].CGColor;
            //self.layer.borderWidth = 3.0f;
            CGContextRef contextRef = UIGraphicsGetCurrentContext();
            CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.5);
            CGContextSetRGBStrokeColor(contextRef, 0, 0, 0, 0.5);
            // Draw a circle (filled)
           // CGContextFillEllipseInRect(contextRef, CGRectMake(midPointX, midPointY, 25, 25));
            // Draw a circle (border only)
            //CGContextStrokeEllipseInRect(contextRef, CGRectMake(midPointX, midPointY, 25, 25));
            
            CGContextSetRGBFillColor(contextRef, 1.0, 0, 0, 1.5);
            CGContextSetRGBStrokeColor(contextRef, 1.0, 0, 0, 1.5);
            CGContextFillRect(contextRef, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
            
            break;
        }
        
        default: {
            self.layer.borderColor = [UIColor blackColor].CGColor;
            self.layer.borderWidth = 1.0f;
            break;
        }
    }
}

@end
