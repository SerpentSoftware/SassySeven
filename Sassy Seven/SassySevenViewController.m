//
//  SassySevenViewController.m
//  Sassy Seven
//
//  Created by Michael Lyons on 3/9/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import "SassySevenViewController.h"
#import "HelpMenuViewController.h"
#include <stdlib.h>
#import <QuartzCore/QuartzCore.h>

@interface SassySevenViewController ()

-(void)phoneShook;

@property (strong, nonatomic) NSArray *phrases;

@end

@implementation SassySevenViewController

@synthesize mainView = _mainView;

@synthesize titleLabel = _titleLabel;

@synthesize phrases = _phrases;
@synthesize phraseLabel = _phraseLabel;

@synthesize sevenBallView = _sevenBallView;
@synthesize sevenImage = _sevenImage;

@synthesize menuButtonsView = _menuButtonsView;

-(NSArray *)phrases
{
    /*
     Girl Don't Even
     Put your big girl panties on and deal with it
     Are you stupid?
     Oh sorry, What were you saying?
     Pardon me, you're obviously mistaken for someone who gives a damn.
     Do you know how to talk? Because all I hear is buzzing.
     I'd like to agree, but I'd be wrong
     I'm busy now, could I ignore you later?
     
     Please? I been done that
     */
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

-(void)moveSevenBallLeft
{
    [UIView animateWithDuration:1 animations:^(void){
        self.sevenBallView.center = CGPointMake(self.sevenBallView.center.x - 500, self.sevenBallView.center.y);
        self.sevenImage.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
-(void)fadeOutButtons
{
    [UIView animateWithDuration:1 animations:^(void) {
        self.menuButtonsView.alpha = 0;
    }];
}
-(void)fadeInButtons
{
    self.menuButtonsView.alpha = 0.00;
    self.menuButtonsView.hidden = NO;
    self.menuButtonsView.opaque = NO;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^(void) {
        self.menuButtonsView.alpha = 1;
    } completion:^(BOOL finished) {
        self.menuButtonsView.hidden = NO;
        self.menuButtonsView.opaque = YES;
    }];
}

-(void)animateFromSplashToMain
{
    [self fadeOutButtons];
    [self moveSevenBallLeft];
}

- (IBAction)playToched {
    //[self animateFromSplashToMain];
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        self.sevenBallView.center = CGPointMake( 500.0, self.sevenBallView.center.y );
        self.sevenImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        if( finished )
        {
            HelpMenuViewController *hmvc = [self.storyboard instantiateViewControllerWithIdentifier:@"pvc"];
            [self presentModalViewController:hmvc animated:NO];
            NSLog(@"Done %g, %g", self.sevenBallView.center.x, self.sevenBallView.center.y);
        }
    }];
}
- (IBAction)helpTouched {
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        self.sevenBallView.center = CGPointMake( 500.0, self.sevenBallView.center.y );
        self.sevenImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        if( finished )
        {
            HelpMenuViewController *hmvc = [self.storyboard instantiateViewControllerWithIdentifier:@"hmvc"];
            [self presentModalViewController:hmvc animated:NO];
            NSLog(@"Done %g, %g", self.sevenBallView.center.x, self.sevenBallView.center.y);
        }
    }];
    
}
-(void)resetAndAnimateMenuIn
{
    [self fadeInButtons];
    
    self.sevenBallView.center = CGPointMake( 500.0, self.sevenBallView.center.y );
    self.sevenImage.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView animateWithDuration:3 animations:^(void) {
        self.titleLabel.alpha = 0.00;
    }];
    
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        self.sevenImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        if( finished )
        {
            [UIView animateWithDuration:.5 animations:^(void) {
                self.sevenImage.transform = CGAffineTransformMakeRotation(0.00);
            }];
            NSLog(@"Done %g, %g", self.sevenBallView.center.x, self.sevenBallView.center.y);
        }
    }];
    
    [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        self.sevenBallView.center = CGPointMake( 211 , self.sevenBallView.center.y );
    } completion:^(BOOL finished) {
        if( finished )
        {
            //self.sevenBallView.center = CGPointMake( 211 , self.sevenBallView.center.y );
            NSLog(@"Done %g, %g", self.sevenBallView.center.x, self.sevenBallView.center.y);
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //self.sevenBallView.center = CGPointMake( 211.0, self.sevenBallView.center.y );
    [self resetAndAnimateMenuIn];
    [self becomeFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated
{    
    [self resignFirstResponder];
    [super viewDidDisappear:YES];
}
-(void)viewDidLoad
{
    //[super viewDidLoad];
    
    self.phraseLabel.alpha = 0.00;
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidUnload {
    [self setSevenImage:nil];
    [self setMenuButtonsView:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}
@end
