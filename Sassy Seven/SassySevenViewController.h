//
//  SassySevenViewController.h
//  Sassy Seven
//
//  Created by Michael Lyons on 3/9/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SassySevenViewController : UIViewController;

@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *sevenBallView;
@property (weak, nonatomic) IBOutlet UIImageView *sevenImage;

@property (weak, nonatomic) IBOutlet UIView *menuButtonsView;

@property (weak, nonatomic) IBOutlet UILabel *phraseLabel;

@end
