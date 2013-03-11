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
@property (weak, nonatomic) IBOutlet UIImageView *sevenImageView;
@property (weak, nonatomic) IBOutlet UIView *ballContainerView;

@property (weak, nonatomic) IBOutlet UILabel *phraseLabel;

@end
