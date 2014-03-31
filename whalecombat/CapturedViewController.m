//
//  CapturedViewController.m
//  whalecombat
//
//  Created by anthony lamantia on 9/12/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "CapturedViewController.h"
#import "BoardPeice.h"

@interface CapturedViewController () {
    int blackCount;
    int whitecount;
}

@end

@implementation CapturedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    blackCount = 0;
    whitecount = 0;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define P_WIDTH 30
#define P_HEIGHT 30
- (void) addPeice : (BoardPeice *) peice
{
    NSLog(@"Adding a peice");
   if (peice.side == SIDE_PLAYER) {
        UIImage *image;
        float locationX = blackCount * 35;
        float locationY = 0;
        if (peice.type == TYPE_PAWN) {
            image = [UIImage imageNamed:@"chess_piece_2_white_pawn.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];
            
        }
        if (peice.type == TYPE_KNIGHT) {
            image = [UIImage imageNamed:@"chess_piece_2_white_knight.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];
            
        }
        
        if (peice.type == TYPE_QUEEN) {
            image = [UIImage imageNamed:@"chess_piece_2_white_queen.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];
            
        }
        
        if (peice.type == TYPE_KING) {
            image = [UIImage imageNamed:@"chess_piece_2_white_king.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];
            
        }
        
        if (peice.type == TYPE_ROOK) {
            image =  [UIImage imageNamed:@"chess_piece_2_white_rook.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];
        }

        if (peice.type == TYPE_BISHOP) {
            image = [UIImage imageNamed:@"chess_piece_2_white_bishop.png"];            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];
            
        }
        whitecount++;
    }

    if (peice.side == SIDE_ENEMY) {
        UIImage *image;
        float locationX = blackCount * 35;
        float locationY = 35.;
        if (peice.type == TYPE_PAWN) {
            image = [UIImage imageNamed:@"chess_piece_2_black_pawn.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                               locationY,
                                                                               P_WIDTH,
                                                                               P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];
            
        }
        if (peice.type == TYPE_KNIGHT) {
            image = [UIImage imageNamed:@"chess_piece_2_black_knight.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];

        }
        
        if (peice.type == TYPE_QUEEN) {
            image = [UIImage imageNamed:@"chess_piece_2_black_queen.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];

        }
        
        if (peice.type == TYPE_KING) {
            image = [UIImage imageNamed:@"chess_piece_2_black_king.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];

        }
        
        if (peice.type == TYPE_ROOK) {
           image =  [UIImage imageNamed:@"chess_piece_2_black_rook.png"];            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];

        }
        
        if (peice.type == TYPE_BISHOP) {
            image = [UIImage imageNamed:@"chess_piece_2_black_bishop.png"];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX,
                                                                                   locationY,
                                                                                   P_WIDTH,
                                                                                   P_HEIGHT)];
            [imageView setImage:image];
            [self.view addSubview:imageView];

        }
        
        blackCount++;

    }
    
    return;
}


@end
