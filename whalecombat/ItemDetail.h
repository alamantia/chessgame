//
//  ItemDetail.h
//  whalecombat
//
//  Created by anthony lamantia on 9/14/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.

#import <Foundation/Foundation.h>

@class CombatViewController;
@class BoardPeice;

#define ITEM_PAWN_BUMP      1
#define ITEM_PEICE_SWAP     2
#define ITEM_UNDO_LAST_MOVE 3
#define ITEM_DOUBLE_MOVE    4
#define ITEM_PLACE_WALL     5

@interface ItemDetail : NSObject {
    
}

@property (nonatomic, assign) int       type;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *descString;
@property (nonatomic, strong) NSString *selectDialogString;

@end
