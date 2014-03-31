//
//  ItemDialog.h
//  whalecombat
//
//  Created by anthony lamantia on 9/13/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.

#import <UIKit/UIKit.h>

/* various dumb defines and things like that */
/* this list contains some item ideas and thoughts as well */

@class ItemDetail;

@interface ItemDialog : UIViewController {
    
}

- (IBAction) clickTake : (id) sender;
- (IBAction) clickPass : (id) sender;

@property (nonatomic, strong) UIViewController *hostViewController;
@property (nonatomic, retain) ItemDetail *itemDetail;

@end
