//
//  CombatViewController.h
//  whalecombat
//
//  Created by anthony lamantia on 8/24/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.

#import <UIKit/UIKit.h>

@class CombatPlayer;
@class CombatEnemy;
@class TileView;
@class BoardPeice;
@class ItemDetail;

#define GAME_MODE_SINGLE   0 /* a single player game */
#define GAME_MODE_DOUBLE   1 /* a two player game    */
#define GAME_MODE_USE_ITEM 2 /* item selection mode  */

@interface CombatViewController : UIViewController <UIGestureRecognizerDelegate> {
    IBOutlet UILabel *labelTitle;
    IBOutlet UILabel *labelItem;
}

/* The current design of the game no longer makes use of these buttons */

- (IBAction) clickWeapon1 : (id) sender;
- (IBAction) clickWeapon2 : (id) sender;
- (IBAction) clickWeapon3 : (id) sender;
- (IBAction) clickWeapon4 : (id) sender;
- (IBAction) clickWeapon5 : (id) sender;
- (IBAction) clickWeapon6 : (id) sender;
- (IBAction) clickWeapon7 : (id) sender;
- (IBAction) clickWeapon8 : (id) sender;
- (IBAction) clickWeapon9 : (id) sender;

- (IBAction) clickLock     : (id) sender;
- (IBAction) clickApproach : (id) sender;
- (IBAction) clickKeep     : (id) sender;

- (void) selectedEnemy : (CombatEnemy *) enemy;
- (int)  getStateOfTile : (int) x : (int) y;
- (void) beginItemMode : (ItemDetail *) itemDetail;

- (TileView *) getTileAtX : (int) x y:(int) y;

@property (nonatomic, strong) NSMutableArray *peicesArray;
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong) NSMutableArray *playerArray;

@property (nonatomic, strong) CombatPlayer   *player;

- (BoardPeice *) getPeiceAtTile : (int) x : (int) y;
- (void) activateItemWithPeice : (BoardPeice *) peice :(TileView *) tile;

@end
