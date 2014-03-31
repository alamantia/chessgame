//
//  ItemDialog.m
//  whalecombat
//
//  Created by anthony lamantia on 9/13/12.
//  Copyright (c) 2012 anthony lamantia. All rights reserved.

#import "ItemDialog.h"
#import "ItemDetail.h"
#import "AppDelegate.h"

#import "UIColor-Expanded.h" /* for all of our entertaining color phun */
#import "CombatViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ItemDialog () {
    int currentItemType;
    IBOutlet UILabel *labelTitle;
    IBOutlet UITextView *textDesc;
}
@end

@implementation ItemDialog

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Adding the item dialog view");
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    /* set the needed strings */
    labelTitle.text = self.itemDetail.titleString;
    textDesc.text = self.itemDetail.descString;
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.x = (self.hostViewController.view.frame.size.width/2) - (self.view.frame.size.width/2);
    viewFrame.origin.y = -(self.view.frame.size.height) *2;
    self.view.frame = viewFrame;
    [UIView animateWithDuration:0.50f animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.x = (self.hostViewController.view.frame.size.width/2) - (self.view.frame.size.width/2);
        viewFrame.origin.y = (self.hostViewController.view.frame.size.height/2) - (self.view.frame.size.height/2);
        self.view.frame = viewFrame;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Our dialog view frame did spawn");
    self.view.layer.borderColor = [UIColor blackColor].CGColor;
    self.view.layer.borderWidth = 4.;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction) clickTake : (id) sender
{
    AppDelegate *del =  [UIApplication sharedApplication].delegate;
    [UIView animateWithDuration:0.50f animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y =  (self.view.frame.size.height)*3;
        self.view.frame = viewFrame;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        /* begin using the selected item */
        [del.combatVc beginItemMode:self.itemDetail];
    }];
    return;
}

- (IBAction) clickPass : (id) sender
{
    [UIView animateWithDuration:0.50f animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y =  (self.view.frame.size.height)*3;
        self.view.frame = viewFrame;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
    return;
}

@end
