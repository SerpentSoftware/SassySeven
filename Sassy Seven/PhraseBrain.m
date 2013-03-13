//
//  PhraseBrain.m
//  Sassy Seven
//
//  Created by Michael Lyons on 3/12/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import "PhraseBrain.h"

@interface PhraseBrain()

@property (nonatomic, strong) NSArray *phrases;

@end

@implementation PhraseBrain

@synthesize phrases = _phrases;

-(void)addDefaultPhrases {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    [temp addObject:@"Bitch Please"];
    
    self.phrases = [temp copy];
}

-(NSArray *)phrases {
    if( !_phrases )
    {
        _phrases = [[NSArray alloc] init];
        [self addDefaultPhrases];
    }
    return _phrases;
}

-(NSString *)getRandomPhrase {
    NSString *temp_phrase = @"";
    
    temp_phrase = [self.phrases objectAtIndex:arc4random() % self.phrases.count];
    
    return temp_phrase;
}

@end
