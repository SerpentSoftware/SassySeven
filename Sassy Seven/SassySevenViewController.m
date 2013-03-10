//
//  SassySevenViewController.m
//  Sassy Seven
//
//  Created by Michael Lyons on 3/9/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import "SassySevenViewController.h"
#include <stdlib.h>

@interface SassySevenViewController ()

-(void)phoneShook;

@property (strong, nonatomic) NSArray *phrases;

@end

@implementation SassySevenViewController

@synthesize mainView = _mainView;
@synthesize phrases = _phrases;

@synthesize phraseLabel = _phraseLabel;

-(NSArray *)phrases
{
    if( !_phrases )
    {
        _phrases = [[NSArray alloc] initWithObjects:@"Does it look like I even care?", @"Phrase 2", @"Phrase 3", nil];
    }
    return _phrases;
}

-(void)phoneShook
{
    self.phraseLabel.text = [self.phrases objectAtIndex:(arc4random() % [self.phrases count])];
    if( self.mainView.backgroundColor == UIColor.blackColor )
    {
        self.mainView.backgroundColor = UIColor.whiteColor;
        self.phraseLabel.textColor = UIColor.blackColor;
    }
    else
    {
        self.mainView.backgroundColor = [UIColor blackColor];
        self.phraseLabel.textColor = UIColor.whiteColor;
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if( motion == UIEventSubtypeMotionShake )
    {
        [self phoneShook];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
