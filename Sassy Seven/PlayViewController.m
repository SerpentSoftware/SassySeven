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
- (void)phoneShook;

@end

@implementation PlayViewController

@synthesize ballView = _ballView;
@synthesize ballImage = _ballImage;
@synthesize glareImage = _glareImage;

@synthesize rotatingView = _rotatingView;
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
/*  
static BOOL L0AccelerationIsShaking(UIAcceleration* last, UIAcceleration* current, double threshold) {
	double
    deltaX = fabs(last.x - current.x),
    deltaY = fabs(last.y - current.y),
    deltaZ = fabs(last.z - current.z);
    
	return
    (deltaX > threshold && deltaY > threshold) ||
    (deltaX > threshold && deltaZ > threshold) ||
    (deltaY > threshold && deltaZ > threshold);
}*/



#define MOVE_FACTOR 5
#define MOVE_DISTANCE 150

- (void)startMotion {
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            CGFloat newY = 150 * (data.acceleration.y + 1);
            CGFloat newX = 300 - 150 * (data.acceleration.x + 1);
            NSLog(@"%g,%g", newX, newY);
            //self.bubbleImage.frame = CGRectMake(newX, newY, self.bubbleImage.frame.size.width, self.bubbleImage.frame.size.height);
        });
    }];
}

/* One dimentional bubble level function
   Angle would be => atan2(accelerationY, accelerationX)
 
- (void)updateBubbleForAngle:(float)angle {
    float halfVialLength = 320.0 / 2;
    float zoomAngle = angle * 4 ;  // real bubble floats up more rapidly than sine function
    
    if (zoomAngle > kMaxAngle) zoomAngle = kMaxAngle ;   // stop at the end
	if (zoomAngle < -kMaxAngle) zoomAngle = -kMaxAngle ; // stop at the other end
    
    float newY = self.center.y - sin(DegreesToRadians(zoomAngle)) * halfVialLength;
    
    bubbleView.center=CGPointMake(self.center.x, newY);
}*/

- (IBAction)homePressed {
    [self animateOut:^(BOOL fin) {
        [self dismissModalViewControllerAnimated:NO];
    }];
}
- (IBAction)trianglePressed {
    [self phoneShook];
}

- (void)animateIn {
    self.ballView.center = CGPointMake(800, self.view.center.y);
    self.rotatingView.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView animateWithDuration:.5 animations:^(void) {
        self.rotatingView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }completion:^(BOOL fin) {
        self.rotatingView.transform = CGAffineTransformIdentity;
    }];
    
    [UIView animateWithDuration:1 animations:^(void) {
        self.ballView.center = self.view.center;
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

/*- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //NSLog(@"derp");
    if( motion == UIEventSubtypeMotionShake ) {
        //[self phoneShook];
    }
}*/

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
    
    [self startMotion];
    [self animateIn];
    
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate=(id)self;
    accelerometer.updateInterval = 10.0f/60.0f;
    
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
        self.rotatingView.alpha = 0.00;
        self.rotatingView.opaque = NO;
        } completion:^(BOOL finished) {}];
        
        // Set text and play sound
        self.phraseLabel.text = [self.brain getRandomPhrase];
        
        // Fade back in
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^(void) {
            self.rotatingView.alpha = 1;
        } completion:^(BOOL finished) {
            [self playSound:[self.brain getSoundFilePath]];
            
            self.rotatingView.opaque = YES;
            self.isAnimating = NO;
        }];
    }
}

@end
