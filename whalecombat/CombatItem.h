//
//  CombatItem.h
//  whalecombat
//
//  Created by anthony lamantia on 8/27/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CombatItem : NSObject

@property (nonatomic, assign) CGPoint  location;
@property (nonatomic, assign) CGPoint  direction;
@property (nonatomic, assign) CGPoint  speed;
@property (nonatomic, assign) int      type;
@property (nonatomic, strong) NSString *name;

@end
