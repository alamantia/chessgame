//
//  EnemiesTableCell.h
//  whalecombat
//
//  Created by anthony lamantia on 8/24/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnemiesTableCell : UITableViewCell {
    IBOutlet UILabel *_labelName;
    IBOutlet UILabel *_labelDist;
}
@property (nonatomic, retain) UILabel *labelName;
@property (nonatomic, retain) UILabel *labelDist;
@end
