//
//  PlayViewController.h
//  Sassy Seven
//
//  Created by Michael Lyons on 3/12/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface PlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *ballView;
@property (weak, nonatomic) IBOutlet UIImageView *ballImage;

@property (weak, nonatomic) IBOutlet UIView *rotatingView;
@property (weak, nonatomic) IBOutlet UIView *fadingView;
@property (weak, nonatomic) IBOutlet UILabel *phraseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleImage;


@property (nonatomic, retain) AVAudioPlayer *player;

@end
