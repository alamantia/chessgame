//
//  EnemiesTableCell.m
//  whalecombat
//
//  Created by anthony lamantia on 8/24/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import "EnemiesTableCell.h"

@implementation EnemiesTableCell
@synthesize  labelName = _labelName;
@synthesize  labelDist = _labelDist;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
