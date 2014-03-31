//
//  TileView.h
//  whalecombat
//
//  Created by anthony lamantia on 8/26/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileView : UIView

@property (nonatomic, assign) CGPoint     boardLocation;
@property (nonatomic, retain) NSNumber    *tileColor;
@property (nonatomic, retain) NSNumber    *tileState;
@property (nonatomic, retain) UILabel     *label;
@property (nonatomic, retain) UIImageView *image;

@property (nonatomic, retain) TileView *contentView;

@end
