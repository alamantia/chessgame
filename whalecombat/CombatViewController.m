//
//  CombatViewController.m
//  whalecombat
//
//  Created by anthony lamantia on 8/24/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "CombatViewController.h"
#import "EnemiesTableView.h"
#import "CombatPlayer.h"
#import "BoardPeice.h"
#import "CombatItem.h"
#import "UIColor-Expanded.h"
#import "CapturedViewController.h"
#import "ItemDialog.h"
#import "ItemDetail.h"

#import "ADice.h"
#import "AVector2D.h"
#import "TileView.h"
#import <QuartzCore/QuartzCore.h>

#define TILES_WIDE  8
#define TILES_TALL  8

static float tileWidth  = 0.;
static float tileHeight = 0.;

enum SELECTION_MODES {
    SELECTION_MODE_NONE,
    SELECTION_MODE_PLAYER_MOVE,
};

@interface CombatViewController () {
    IBOutlet UITextView *textCombat;
    IBOutlet UITableView *_eTableView;
    IBOutlet UIView      *_boardView;
    IBOutlet UIView       *_capturedView;
    IBOutlet UILabel      *_actionLabel;
    IBOutlet UIView       *_actionView;
    
    EnemiesTableView     *enemiesTableView;
    BoardPeice           *selectedPeice;
    CapturedViewController *captureView;
    ItemDialog             *itemDialog;
    ItemDetail              *activeItem;
    BOOL animationLock;
    int selectionMode;
    
    int turnsToItem;
    int playersSide;
    int players;
    int gameMode;
    int gameTurn;
}

@property (nonatomic, strong) NSMutableArray *tilesArray;
@end

@implementation CombatViewController
@synthesize  peicesArray, player, tilesArray, itemsArray, playerArray;

#pragma mark = Tile gestures

/* this is where things can get complicated         */
/* and where it could be nice to support gamecenter */

- (void) spawnItem
{
    int x = 0;
    int y = 0;
spawnItem:
    for ( x = 0; x < 8; x++) {
        for (y = 0; y < 8; y++) {
            BoardPeice *peice = [self getPeiceAtTile:x :y];
            if (peice != nil)
                continue;
            if (rand() % 128 == 14) {
                /* add an item */
                BoardPeice *newItem = [[BoardPeice alloc] init];
                newItem.name = @"";
                newItem.side = SIDE_ITEM;
                newItem.location = CGPointMake(x, y);
                [peicesArray addObject:newItem];
                TileView *tileView = [self getTileAtX:x y:y];
                if (tileView.contentView == nil) {
                    [self createContentView:tileView];
                }
                [tileView.contentView.image setImage: [UIImage imageNamed:@"itemBox.png"]];
                return;
            }
        }
    }
    goto spawnItem;
    return;
}

- (void) finishTurn
{
    turnsToItem--;
    if (turnsToItem <= 0) {
        [self spawnItem];
        turnsToItem = 5;
    }
    labelItem.text = [NSString stringWithFormat:@"Next item in %i turns", turnsToItem];
    return;
}

- (void) enemyTurn
{
    [self finishTurn];
    return;
}

- (void) clearTileStates
{
    for (TileView *tileView in tilesArray) {
        tileView.tileState = [NSNumber numberWithInt:0];
        [tileView setNeedsDisplay];
    }
    return;
}

/* capture an item/take an enemy ..etc */
- (void) captureTile : (int) x : (int) y
{
    /* we need to compute this verses the current player not just side enemy ...etc */
    for (BoardPeice *peice in peicesArray) {
        if (peice.location.x == x && peice.location.y == y) {
            if (peice.side == SIDE_ENEMY /* || peice.side == SIDE_PLAYER */) {
                [captureView addPeice:peice];
                [peicesArray removeObject:peice];
                return;
            }
            if (peice.side == SIDE_ITEM) {
                
                
                /* let's just test with the pawn bump for now */
                ItemDetail *cItem = [[ItemDetail alloc] init];
                cItem.titleString = @"The Pawn Bump";
                cItem.descString  = @"Randomly bump one of your opponents unwitting pawns out of place.";
                cItem.selectDialogString = @"Select the enemy pawn you would like to bump.";
                cItem.type        = ITEM_PAWN_BUMP;
                
                [peicesArray removeObject:peice];
                NSLog(@"Trying to add item dialog view");
                itemDialog = [[ItemDialog alloc] initWithNibName:@"ItemDialog" bundle:nil];
                itemDialog.itemDetail = cItem;
                itemDialog.hostViewController = self;
                [self.view addSubview:itemDialog.view];
                return;
            }
        }
    }
    return;
}

- (int) getStateOfTile : (int) x : (int) y
{
    for (BoardPeice *enemy in peicesArray) {
        if (enemy.location.x == x && enemy.location.y == y) {
            return enemy.side;
        }
    }
    return 0;
} 

/* get peice located at tile */
- (BoardPeice *) getPeiceAtTile : (int) x : (int) y
{    
    for (BoardPeice *peice in peicesArray) {
        if (peice.location.x == x && peice.location.y == y) {
            return peice;
        }
    }
    return nil;
}

- (void) processTapPlayer : (BoardPeice *) peice
{
    if (animationLock == YES)
        return;
    /* clear the state */
    if (selectionMode == SELECTION_MODE_PLAYER_MOVE) {
        selectionMode = SELECTION_MODE_NONE;
        [self clearTileStates];
        selectedPeice = nil;
        return;
    }
    if (selectionMode == SELECTION_MODE_NONE) {
        selectedPeice = peice;
        TileView *tt = [self getTileAtX:peice.location.x y:peice.location.y];
        tt.tileState = [NSNumber numberWithInt:0];
        [tt setNeedsDisplay];
        NSMutableArray *playerRange = [peice getRange];
        for (NSMutableDictionary *possibleMove in playerRange) {
            selectedPeice = peice;
            int moveX = [[possibleMove valueForKey:@"x"] integerValue] + (int)peice.location.x;
            int moveY = [[possibleMove valueForKey:@"y"] integerValue] + (int)peice.location.y;
            if ([[possibleMove valueForKey:@"x"] integerValue] == 0 && [[possibleMove valueForKey:@"y"] integerValue] == 0) {
                //continue;
            }
            NSLog(@"Possible Move (%i, %i)", moveX, moveY);
            //if (moveX == peice.location.x && moveX == peice.location.y)
              //  continue;
            TileView *movetile = [self getTileAtX:moveX y:moveY];
            if (movetile == nil) {
                NSLog(@"Move tile is nil (%i, %i) %i %i ", moveX, moveY,  [[possibleMove valueForKey:@"x"] integerValue],  [[possibleMove valueForKey:@"y"] integerValue]  );
                continue;
            }
            /* check if the tile is passable */
            BoardPeice *tilePeice = [self getPeiceAtTile:moveX:moveY];
            switch ( tilePeice.side ) {
                case SIDE_ITEM:
                    movetile.tileState = [NSNumber numberWithInt:3];
                case SIDE_ENEMY:
                    movetile.tileState = [NSNumber numberWithInt:3];
                    break;
                default: {
                    movetile.tileState = [NSNumber numberWithInt:1];
                }
            }
            [movetile setNeedsDisplay];
        }
        
        
        /* make the current tile green */
        TileView *movetile = [self getTileAtX:peice.location.x y:peice.location.y];
        movetile.tileState = [NSNumber numberWithInt:1];
        [movetile setNeedsDisplay];


        
        selectionMode = SELECTION_MODE_PLAYER_MOVE;
        return;
    }
    return;
}

/* add a new peice to teh board at x,y */
- (void) addPeice : (int) type : (int) x : (int) y
{
    return;
}

/* Animates and moves a peice to a new location on the board */
/* the AI engine will call this to execute a move as well    */
- (void) movePeice : (BoardPeice *) peice : (int) x : (int) y
{
    TileView *currentTile = [self getTileAtX:peice.location.x y:peice.location.y];
    TileView *movetile = [self getTileAtX:x y:y];
    TileView *oldContent = movetile.contentView;
    animationLock = YES;
    [UIView animateWithDuration:0.5f
                     animations:^{
                         movetile.contentView = nil;
                         TileView *targetContent = currentTile.contentView;
                         targetContent.frame = movetile.frame;
                     } completion:^(BOOL finished) {
                         CGPoint tileLocation  = peice.location;
                         tileLocation.x = movetile.boardLocation.x;
                         tileLocation.y = movetile.boardLocation.y;
                         peice.location = tileLocation;
                         //if (oldContent != nil) {
                          //   [oldContent removeFromSuperview];
                         //}
                         movetile.contentView = currentTile.contentView;
                         currentTile.contentView = nil;
                         animationLock = NO;
                     }
     ];
    [self clearTileStates];
    return;
}

/* (animate and move a player) */
- (void) movePlayer : (BoardPeice *) peice : (int) x : (int) y
{
    NSMutableArray *playerRange = [peice getRange];
    if (selectedPeice.location.x == x && selectedPeice.location.y == y) {
        selectionMode = SELECTION_MODE_NONE;
        return;
    }
    for (NSMutableDictionary *possibleMove in playerRange) {
        int moveX = [[possibleMove valueForKey:@"x"] integerValue] + (int)peice.location.x;
        int moveY = [[possibleMove valueForKey:@"y"] integerValue] + (int)peice.location.y;
        //if (moveX == peice.location.x && moveX == peice.location.y)
         //   continue;
        if (moveX == x && moveY == y) {
            TileView *movetile = [self getTileAtX:moveX y:moveY];
            NSLog(@"Player can move to tile (%i, %i)", moveX, moveY);
#if 0
            BoardPeice *tilePeice = [self getPeiceAtTile:moveX:moveY];
            if (tilePeice != nil) {
                /* if this move can't capture continue */
                if ([[possibleMove valueForKey:@"can_capture"] boolValue] == NO) {
                    return;
                }
                if (tilePeice.side == SIDE_PLAYER) {
                    return;
                }

                /* OK */
            } else {
                if ([[possibleMove valueForKey:@"capture_only"] boolValue] == YES) {
                    return;
                }
                /* OK */
            }
#endif
            selectionMode = SELECTION_MODE_NONE;
            TileView *currentTile = [self getTileAtX:peice.location.x y:peice.location.y];
            TileView *oldContent = movetile.contentView;
            animationLock = YES;
            peice.moveCount++;
            [UIView animateWithDuration:0.5f
                             animations:^{
                                 movetile.contentView = nil;
                                 TileView *targetContent = currentTile.contentView;
                                 targetContent.frame = movetile.frame;
                             } completion:^(BOOL finished) {
                                 CGPoint tileLocation  = peice.location;
                                 tileLocation.x = movetile.boardLocation.x;
                                 tileLocation.y = movetile.boardLocation.y;
                                 peice.location = tileLocation;
                                 if (oldContent != nil) {
                                     [oldContent removeFromSuperview];
                                 }
                                 movetile.contentView = currentTile.contentView;
                                 currentTile.contentView = nil;
                                 [self captureTile:movetile.boardLocation.x :movetile.boardLocation.y];
                                 [self enemyTurn];
                                 animationLock = NO;
                             }
             ];
            [self clearTileStates];
        }
    }
    return;
}

- (void) processTap : (int) x : (int) y
{
    if (animationLock == YES)
        return;
    BoardPeice *tappedPeice = [self getPeiceAtTile: x : y];
    TileView   *tappedTile = [self getTileAtX:x y:y];
    if (gameMode == GAME_MODE_USE_ITEM) {
        [self activateItemWithPeice:tappedPeice:tappedTile];
        NSLog(@"Tap in use item mode");
        NSLog(@"Tapped tile is %p", tappedTile);
        return;
    }
    
    if (selectionMode == SELECTION_MODE_PLAYER_MOVE) {
        if (tappedPeice != nil) {
            if (tappedPeice.side == SIDE_PLAYER) {
                [self clearTileStates];
                selectionMode = SELECTION_MODE_NONE;
                if (tappedPeice != selectedPeice) {
                    NSLog(@"Highlight a different peice");
                    [self processTapPlayer:tappedPeice];
                }
                return;
            }
        }
        [self movePlayer: selectedPeice : x : y];
        return;
    }
    if (tappedPeice != nil) {
        if (tappedPeice.side == SIDE_PLAYER) {
            [self processTapPlayer:tappedPeice];
        }
    }
    return;
}

-(void) tileTapped:(UIGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:_boardView];
    for (TileView *tileView in tilesArray) {
        BOOL isPointInsideView = CGRectContainsPoint(tileView.frame, tapPoint);
        if (isPointInsideView == YES) {
            [self processTap:tileView.boardLocation.x :tileView.boardLocation.y];
            return;
        }
    }
}

#pragma mark = Board Drawing ..etc (move somewhere else later)

- (void) drawBoard
{
    CGRect rect = _boardView.frame;
    
    tileWidth = rect.size.width  / TILES_WIDE;
    tileHeight = rect.size.height / TILES_TALL;
    
    [tilesArray removeAllObjects];
    
    NSLog(@"tile width    %f", tileWidth);
    NSLog(@"tiles height  %f", tileHeight);

    float currentX = 0.0f;
    float currentY = 0.0f;
    
    int tileX = 0;
    int tileY = 8; /* we start drawing from the top */
    
    int startWhite = 1;
    int idx = 0;
    for (tileY = 7; tileY >= 0; tileY--) {
        currentX = 0;
        if (startWhite == 1) {
            idx = 0;
        }else {
            idx = 1;
        }
        for (tileX = 0; tileX <= 7; tileX ++) {
            TileView  *tileView = [[TileView alloc] initWithFrame:CGRectMake(currentX, currentY, tileWidth, tileHeight)];
            [_boardView addSubview:tileView];
            if (idx % 2 == 0) {
                //white
                tileView.backgroundColor = [UIColor colorWithHexString:@"94fafc"];
                tileView.tileColor = [NSNumber numberWithInt:0];
            } else {
                //black
                tileView.backgroundColor = [UIColor colorWithHexString:@"fcb9fc"];
                tileView.tileColor = [NSNumber numberWithInt:1];
            }
            tileView.tileState = [NSNumber numberWithInt:0];
            tileView.boardLocation = CGPointMake(tileX, tileY);
            
            /* add a label to the tileView */
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tileView.frame.size.width, tileView.frame.size.height)];
            label.textAlignment =  UITextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:32.0f];
            [label setBackgroundColor:[UIColor clearColor]];
            tileView.label = label;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tileTapped:)];
            [tapGesture setDelegate:self];
            [tileView addGestureRecognizer:tapGesture];
            [tileView addSubview:label];
            tileView.contentView = nil;
            [tilesArray addObject:tileView];
            currentX += tileWidth;
            idx++;
        }
        if (startWhite == 1) {
            startWhite = 0;
        } else {
            startWhite = 1;
        }
        currentY += tileHeight;
    }
    return;
}

- (TileView *) getTileAtX : (int) x y:(int) y
{
    for (TileView *tileView in tilesArray) {
        if ((int)tileView.boardLocation.x == x && (int)tileView.boardLocation.y == y) {
            return tileView;
        }
    }
    return nil;
}

- (void) createContentView : (TileView *) tileView
{
    tileView.contentView = [[TileView alloc] initWithFrame:tileView.frame];
    tileView.contentView.backgroundColor = [UIColor clearColor];
    tileView.contentView.tileState = [NSNumber numberWithInt:2];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tileView.contentView.frame.size.width, tileView.contentView.frame.size.height)];
    label.textAlignment =  UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:32.0f];
    [label setBackgroundColor:[UIColor clearColor]];
    tileView.contentView.label = label;
    [tileView.contentView addSubview:label];
    
    float width = tileView.contentView.frame.size.width/1.5;
    float height = tileView.contentView.frame.size.height/1.5;

    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(width/4, height/4, width, height)];
    
    [image setBackgroundColor:[UIColor clearColor]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    tileView.contentView.image = image;
    
    [tileView.contentView addSubview:image];

    tileView.contentView.userInteractionEnabled = NO;
    [_boardView addSubview: tileView.contentView];
    NSLog(@"Adding player contentView");
    return;
}

/* draw the peices on the board */
- (void) drawPeices
{
    TileView *tileView = nil;
    
    for (BoardPeice *peice in peicesArray) {
        tileView = [self getTileAtX:peice.location.x y:peice.location.y];
        if (tileView == nil) {
            continue;
        }
        if (tileView.contentView == nil) {
            [self createContentView:tileView];
        }
        if (peice.side == SIDE_ENEMY) {
            if (peice.type == TYPE_PAWN) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_black_pawn.png"]];
            }
            if (peice.type == TYPE_KNIGHT) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_black_knight.png"]];
            }
            
            if (peice.type == TYPE_QUEEN) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_black_queen.png"]];
            }
            
            if (peice.type == TYPE_KING) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_black_king.png"]];
            }

            if (peice.type == TYPE_ROOK) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_black_rook.png"]];
            }
            
            if (peice.type == TYPE_BISHOP) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_black_bishop.png"]];
            }
        }
        if (peice.side == SIDE_PLAYER) {
            if (peice.type == TYPE_PAWN) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_white_pawn.png"]];
            }
            if (peice.type == TYPE_KNIGHT) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_white_knight.png"]];
            }
            
            
            if (peice.type == TYPE_ROOK) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_white_rook.png"]];
            }
            
            if (peice.type == TYPE_BISHOP) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_white_bishop.png"]];
            }
            
            if (peice.type == TYPE_KING) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_white_king.png"]];
            }
            if (peice.type == TYPE_QUEEN) {
                [tileView.contentView.image setImage: [UIImage imageNamed:@"chess_piece_2_white_queen.png"]];
            }
        }
        if (peice.side == SIDE_ITEM) {
            [tileView.contentView.image setImage: [UIImage imageNamed:@"itemBox.png"]];
        }
    }
    return;
}

- (void) highlightBoard
{
    return;
}

- (void) updateCombat
{
    //NSLog(@"Updating Combat %i", [ADice Roll:20]);
    [self performSelector:@selector(updateCombat) withObject:nil afterDelay:0.5f];
    //[_eTableView reloadData];
    return;
    
}

/* populate the board with some items */
- (void) buildSampleItems
{
    BoardPeice *newItem;

    newItem = [[BoardPeice alloc] init];
    newItem.name = @"Item #1";
    newItem.side = SIDE_ITEM;
    newItem.location = CGPointMake(3, 3);
    [peicesArray addObject:newItem];
    
    newItem = [[BoardPeice alloc] init];
    newItem.name = @"Item #1";
    newItem.side = SIDE_ITEM;
    newItem.location = CGPointMake(0, 3);
    [peicesArray addObject:newItem];

    
    newItem = [[BoardPeice alloc] init];
    newItem.name = @"Item #1";
    newItem.side = SIDE_ITEM;
    newItem.location = CGPointMake(7, 3);
    [peicesArray addObject:newItem];

    
    return;
}

- (void) buildSampleEnemies
{
    [peicesArray removeAllObjects];
    BoardPeice *newEnemy;
    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Enemy #1";
    newEnemy.side = SIDE_ENEMY;
    newEnemy.type = TYPE_BISHOP;
    newEnemy.location = CGPointMake(7, 7);
    [peicesArray addObject: newEnemy];
    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Enemy #2";
    newEnemy.side = SIDE_ENEMY;
    newEnemy.type = TYPE_ROOK;
    newEnemy.location = CGPointMake(0, 7);
    [peicesArray addObject: newEnemy];

    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Enemy #3";
    newEnemy.side = SIDE_ENEMY;
    newEnemy.type = TYPE_KNIGHT;
    newEnemy.location = CGPointMake(4, 6);
    [peicesArray addObject: newEnemy];
    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Enemy #4";
    newEnemy.side = SIDE_ENEMY;
    newEnemy.type = TYPE_PAWN;
    newEnemy.location = CGPointMake(3, 6);
    [peicesArray addObject: newEnemy];
    
    /* Place the players peices */
    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_PAWN;
    newEnemy.location = CGPointMake(0, 1);
    [peicesArray addObject: newEnemy];

    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_PAWN;

    newEnemy.location = CGPointMake(1, 1);
    [peicesArray addObject: newEnemy];
    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_PAWN;
    newEnemy.location = CGPointMake(2, 1);
    [peicesArray addObject: newEnemy];

    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_PAWN;
    newEnemy.location = CGPointMake(3, 1);
    [peicesArray addObject: newEnemy];
    [_eTableView reloadData];
    
    
    
    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_QUEEN;
    newEnemy.location = CGPointMake(1, 0);
    [peicesArray addObject: newEnemy];

    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_KING;
    newEnemy.location = CGPointMake(0, 0);
    [peicesArray addObject: newEnemy];
    

    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_BISHOP;
    newEnemy.location = CGPointMake(2, 0);
    [peicesArray addObject: newEnemy];

    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_KNIGHT;
    newEnemy.location = CGPointMake(3, 0);
    [peicesArray addObject: newEnemy];

    
    newEnemy = [[BoardPeice alloc] init];
    newEnemy.name = @"Player #4";
    newEnemy.side = SIDE_PLAYER;
    newEnemy.type = TYPE_ROOK;
    newEnemy.location = CGPointMake(4, 0);
    [peicesArray addObject: newEnemy];
    return;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        enemiesTableView = [[EnemiesTableView alloc] initWithStyle:UITableViewStylePlain];
        enemiesTableView.combatVc = self;
        player = [[CombatPlayer alloc] init];
        player.location   = CGPointMake(0,0);
        
        self.peicesArray = [[NSMutableArray alloc] init];
        self.itemsArray = [[NSMutableArray alloc] init];

        [self buildSampleEnemies];
        [self buildSampleItems];
        
        // Custom initialization
    }
    return self;
}

int t = 0;
- (void) flash
{
    return;
    if (t % 2  == 0) {
        //self.view.backgroundColor = [UIColor orangeColor];
    } else {
       // self.view.backgroundColor = [UIColor magentaColor];
    }
    t ++;
    [self performSelector:@selector(flash) withObject:nil afterDelay:0.25];
    return;
}

- (void) buildItemList
{
    /* let's just test with the pawn bump for now */
    ItemDetail *cItem = nil;
    cItem = [[ItemDetail alloc] init];
    cItem.titleString = @"The Pawn Bump";
    cItem.descString  = @"Randomly bump one of your opponents unwitting pawns out of place.";
    cItem.selectDialogString = @"Select the enemy pawn you would like to bump.";
    cItem.type        = ITEM_PAWN_BUMP;
    [self.itemsArray addObject:cItem];
    return;
}

- (void) initGameMode
{
    gameMode    = GAME_MODE_SINGLE;
    playersSide = SIDE_WHITE;
    gameTurn    = SIDE_WHITE;
    return;
}

- (void)viewDidLoad
{
    [self initGameMode];
    turnsToItem = 5;
    animationLock = NO;
    [self flash];

    captureView = [[CapturedViewController alloc] initWithNibName:@"CapturedViewController" bundle:nil];
    CGRect captureViewFrame = _capturedView.frame;
    captureViewFrame.origin.x = 0.;
    captureViewFrame.origin.y = 0.;
    captureView.view.frame = captureViewFrame;
    [_capturedView addSubview:captureView.view];
    
    selectionMode = SELECTION_MODE_NONE;
    [super viewDidLoad];
    selectedPeice = nil;
    _eTableView.dataSource = enemiesTableView;
    _eTableView.delegate   = enemiesTableView;
    [_eTableView reloadData];
    tilesArray = [[NSMutableArray alloc] init];
    [self drawBoard];
    [self drawPeices];
    [self performSelector:@selector(updateCombat) withObject:nil afterDelay:0.5f];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void) selectedEnemy : (BoardPeice *) enemy
{
    return;
}

#pragma mark - Item use code
- (void) beginItemMode : (ItemDetail *) itemDetail
{
    gameMode = GAME_MODE_USE_ITEM;
    activeItem = itemDetail;
    NSLog(@"Item has title %@", itemDetail.titleString);
    _actionLabel.text = itemDetail.selectDialogString;
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         CGRect actionViewRect = _actionView.frame;
                         actionViewRect.origin.y = 0.0f;
                         _actionView.frame = actionViewRect;
                     } completion:^(BOOL finished) {
                         
                     }
     ];
    return;
}




/*
    Handle the various item types ( move this shit later)
*/


/* display that the item use has failed */
- (void) itemFailDialog  : (NSString *) str
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                      message:str
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
    [message show];
    return;
}

/* try performing a pawn bump item */


/* place a inpassable wall at a location */
- (BOOL) itemUse_PlaceWall : (BoardPeice *) peice : (TileView *) tile
{
    return NO;
}

- (BOOL) itemUse_PawnBump :  (BoardPeice *) peice :(TileView *) tile
{
    NSLog(@"Trying to pass and fail the pawn bump");
    
    if (peice.side == SIDE_PLAYER) {
        NSLog(@"Picked wrong side");
        [self itemFailDialog:@"You must select one of your enemies pawns"];
        return NO;
    }

    if (peice.type != TYPE_PAWN) {
        NSLog(@"Picked wrong peice");
        [self itemFailDialog:@"You must select one of your enemies pawns"];
        return NO;
    }
    
    NSLog(@"Let's get peice bumping!");
    
    int xCurrent = tile.boardLocation.x;
    int yCurrent = tile.boardLocation.y;
    
    BoardPeice *pL = nil;
    
    pL = [self getPeiceAtTile:xCurrent+1:yCurrent];
    if (pL == nil) {
        [self movePeice:peice:xCurrent+1:yCurrent];
        return YES;
    }
    
    pL = [self getPeiceAtTile:xCurrent-1:yCurrent];
    if (pL == nil) {
        [self movePeice:peice:xCurrent-1:yCurrent];
        return YES;
    }
    
    pL = [self getPeiceAtTile:xCurrent:yCurrent+1];
    if (pL != nil) {
        [self movePeice:peice:xCurrent:yCurrent+1];
        return YES;
    }
    
    pL = [self getPeiceAtTile:xCurrent:yCurrent-1];
    if (pL == nil) {
        [self movePeice:peice:xCurrent:yCurrent-1];
        return YES;
    }
    
    
    pL = [self getPeiceAtTile:xCurrent+1:yCurrent+1];
    if (pL == nil) {
        [self movePeice:peice:xCurrent+1:yCurrent+1];
        return YES;
    }
    
    pL = [self getPeiceAtTile:xCurrent+1:yCurrent-1];
    if (pL == nil) {
        [self movePeice:peice:xCurrent+1:yCurrent-1];
        return YES;
    }
    
    pL = [self getPeiceAtTile:xCurrent-1:yCurrent-1];
    if (pL == nil) {
        [self movePeice:peice:xCurrent-1:yCurrent-1];
        return YES;
    }

    pL = [self getPeiceAtTile:xCurrent-1:yCurrent+1];
    if (pL == nil) {
        [self movePeice:peice:xCurrent-1:yCurrent+1];
        return YES;
    }

    /* find random unoccupied tile and move the peice to that location */
    return NO;
}

- (void) activateItemWithPeice : (BoardPeice *) peice :(TileView *) tile
{
    NSLog(@"Trying to activate item");
    /* activeItem is the current item       */
    switch (activeItem.type) {
        
        case ITEM_PAWN_BUMP: {
            if (![self itemUse_PawnBump:peice :tile])
                return;
            break;
        }
            
        case ITEM_PEICE_SWAP: {
            break;
        }
            
        case ITEM_UNDO_LAST_MOVE: {
            break;
        }
            
        case ITEM_DOUBLE_MOVE: {
            break;
        }
            
        case ITEM_PLACE_WALL: {
            break;
        }
            
        default: {
            NSLog(@"Unknown item type");
            break;
        }
    }
    /* call this once the item check passes */
    
    
    
    gameMode    = GAME_MODE_SINGLE;
    [self endItemMode];
    return;
    
    return;
}

- (void) endItemMode
{
    [UIView animateWithDuration:0.25f
                     animations:^{
                         CGRect actionViewRect = _actionView.frame;
                         actionViewRect.origin.y = - actionViewRect.size.height;
                         _actionView.frame = actionViewRect;
                     } completion:^(BOOL finished) {
                         
                     }
     ];
    return;
}

@end
