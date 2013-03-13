//
//  PlayViewController.m
//  Sassy Seven
//
//  Created by Michael Lyons on 3/12/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import "PlayViewController.h"
#import "PhraseBrain.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

@synthesize ballView = _ballView;
@synthesize ballImage = _ballImage;
@synthesize glareImage = _glareImage;

@synthesize phraseLabel = _phraseLabel;

@synthesize player = _player;

- (IBAction)homePressed {
    [self animateOut:^(BOOL fin) {
        [self dismissModalViewControllerAnimated:NO];
    }];
}

- (void)animateIn {
    self.ballView.center = CGPointMake(800, self.view.center.y);

    [UIView animateWithDuration:1 animations:^(void) {
        self.ballView.center = self.view.center;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)animateOut:(void ( ^ )(BOOL))finished {   
    [UIView animateWithDuration:1 animations:^(void) {
        self.ballView.center = CGPointMake(800, self.view.center.y);
    } completion:finished];
}/*
*/
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //NSLog(@"derp");
    if( motion == UIEventSubtypeMotionShake ) {
        NSLog(@"SHOOK");
        NSLog(@"Trying to speak");
        NSString *soundFilePath =
        [[NSBundle mainBundle] pathForResource: @"AppSounds/bitch"
                                        ofType: @"wav"];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
        
        AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
        self.player = newPlayer;
        
        [self.player prepareToPlay];
        [self.player setDelegate:self];
        [self.player play];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
    
    [self animateIn];
}
- (void)viewDidDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    [self setBallView:nil];
    [self setPhraseLabel:nil];
    [self setGlareImage:nil];
    [self setBallImage:nil];
    [super viewDidUnload];
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}
@end
