//
//  AVector2D.h
//
//
//  Created by anthony lamantia on 8/25/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVector2D : NSObject

+ (CGPoint) Normal : (CGPoint) a;
+ (CGPoint) Dot : (CGPoint) a   : (CGPoint)  b;
+ (CGPoint) Sub : (CGPoint) a   : (CGPoint)  b;
+ (CGPoint) Add : (CGPoint) a : (CGPoint) b;

+ (float) Mag : (CGPoint) a;
+ (float) Dist : (CGPoint) a  : (CGPoint) b;

@end
