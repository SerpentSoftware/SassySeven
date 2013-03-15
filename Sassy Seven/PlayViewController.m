//
//  PlayViewController.m
//  Sassy Seven
//
//  Created by Michael Lyons on 3/12/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import "PlayViewController.h"
#import "PhraseBrain.h"
#import <CoreMotion/CoreMotion.h>

@interface PlayViewController ()

@property (readonly) CMMotionManager *motionManager;
@property (readonly, nonatomic) PhraseBrain *brain;
@property (nonatomic) NSInteger numberOfShakes;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL viewHasAnimatedIn;

- (void)phoneShook;

@end

@implementation PlayViewController

@synthesize ballView = _ballView;
@synthesize ballImage = _ballImage;
@synthesize glareImage = _glareImage;

@synthesize rotatingView = _rotatingView;
@synthesize fadingView = _fadingView;
@synthesize phraseLabel = _phraseLabel;
@synthesize bubbleImage = _bubbleImage;

@synthesize player = _player;
@synthesize brain = _brain;
@synthesize numberOfShakes = _numberOfShakes;
@synthesize isAnimating = _isAnimating;


- (CMMotionManager *)motionManager {
    CMMotionManager *motionManager = nil;
    id appDelegate = [UIApplication sharedApplication].delegate;
    if([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    return motionManager;
}

- (PhraseBrain *)brain
{
    if(!_brain)
    {
        _brain = [[PhraseBrain alloc] init];
    }
    return _brain;
}


#define MOVE_FACTOR 60
#define MOVE_DISTANCE 150

- (void)startMotion {
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            
            
            CGFloat targetY = 150 * (data.acceleration.y + 1);
            CGFloat targetX = 300 - 150 * (data.acceleration.x + 1);
            
            CGFloat newX = self.bubbleImage.frame.origin.x + ( (targetX - self.bubbleImage.frame.origin.x) / MOVE_FACTOR );
            CGFloat newY = self.bubbleImage.frame.origin.y + ( (targetY - self.bubbleImage.frame.origin.y) / MOVE_FACTOR );

            self.fadingView.transform = CGAffineTransformMakeRotation( (M_PI_2/180) * (data.acceleration.x * 30) );
            
            self.bubbleImage.frame = CGRectMake(newX, newY, self.bubbleImage.frame.size.width, self.bubbleImage.frame.size.height);
        });
    }];
}

- (IBAction)homePressed {
    [self animateOut:^(BOOL fin) {
        [self dismissModalViewControllerAnimated:NO];
    }];
}
- (IBAction)trianglePressed {
    [self phoneShook];
}

- (void)animateIn {
    self.ballView.center = CGPointMake(800, self.ballView.center.y);
    self.fadingView.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView animateWithDuration:1 animations:^(void) {
        self.fadingView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }completion:^(BOOL fin) {
        [UIView animateWithDuration:1 animations:^(void) {
            self.fadingView.transform = CGAffineTransformIdentity;
        }];
    }];
    
    [UIView animateWithDuration:1 animations:^(void) {
        self.ballView.center = CGPointMake(self.view.center.x, self.ballView.center.y);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)animateOut:(void ( ^ )(BOOL))finished {   
    [UIView animateWithDuration:1 animations:^(void) {
        self.ballView.center = CGPointMake(800, self.view.center.y);
    } completion:finished];
}

-(void)playSound:(NSString *)fileName
{
    NSLog(@"%@", fileName);
    
    NSURL *fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3",[[NSBundle mainBundle] resourcePath], fileName]];
    
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    
    newPlayer.numberOfLoops = 0;
    
    self.player = newPlayer;
    
    [self.player prepareToPlay];
    [self.player setDelegate:(id)self];
    [self.player play];
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
    
    [self startMotion];
    [self animateIn];
    
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate=(id)self;
    accelerometer.updateInterval = 10.0f/60.0f;
    self.bubbleImage.alpha = .50;
    self.bubbleImage.opaque = NO;
    
    self.numberOfShakes = 0;
    self.isAnimating = NO;
}
- (void)viewDidDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}

#define SHAKE_THRESHOLD 2.0
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (fabsf(acceleration.x) > SHAKE_THRESHOLD
        || fabsf(acceleration.y) > SHAKE_THRESHOLD
        || fabsf(acceleration.z) > SHAKE_THRESHOLD) {
        [self phoneShook];
        self.numberOfShakes = 20;
    }
}
- (void)viewDidUnload {
    [self setBallView:nil];
    [self setPhraseLabel:nil];
    [self setGlareImage:nil];
    [self setBallImage:nil];
    [self setBubbleImage:nil];
    [self setRotatingView:nil];
    [self setFadingView:nil];
    [super viewDidUnload];
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)phoneShook
{
    if (self.isAnimating == NO)
    {
        self.isAnimating = YES;
        // Fade triangle out
        // Possible problem - bubble will fade as well
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^(void) {
        self.fadingView.alpha = 0.00;
        self.fadingView.opaque = NO;
        } completion:^(BOOL finished) {}];
        
        // Set text and play sound
        self.phraseLabel.text = [self.brain getRandomPhrase];
        
        // Fade back in
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^(void) {
            self.fadingView.alpha = 1;
        } completion:^(BOOL finished) {
            [self playSound:[self.brain getSoundFilePath]];
            
            self.fadingView.opaque = YES;
            self.isAnimating = NO;
        }];
    }
}

@end
