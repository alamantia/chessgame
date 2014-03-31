//
//  CombatPlayer.h
//  whalecombat
//
//  Created by anthony lamantia on 8/25/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CombatPlayer : NSObject {
    
}

@property (nonatomic, assign) CGPoint  location;
@property (nonatomic, assign) CGPoint  direction;
@property (nonatomic, assign) CGPoint  speed;
@property (nonatomic, strong) NSString *name;

- (NSArray *) getValidMoves;
- (NSMutableArray *) getRange;

@end
