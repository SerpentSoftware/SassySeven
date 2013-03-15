//
//  PhraseBrain.m
//  Sassy Seven
//
//  Created by Michael Lyons on 3/12/13.
//  Copyright (c) 2013 Serpent Software. All rights reserved.
//

#import "PhraseBrain.h"

@interface PhraseBrain()

@property (nonatomic, strong) NSDictionary *phrases;
@property (nonatomic, strong) NSString *current_key;

@end

@implementation PhraseBrain

@synthesize phrases = _phrases;
@synthesize current_key = _current_key;

-(void)addDefaultPhrases {
    NSMutableDictionary *temp_dictionary = [[NSMutableDictionary alloc] init];
    
    NSArray *temp_array = [[NSArray alloc] initWithObjects:@"nobodygottime1",@"nobodygottime2",@"nobodygottime3", nil];
    [temp_dictionary setValue:temp_array forKey:@"Ain't nobody\ngot time\nfor that"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"allihear1",@"allihear2",@"allihear3", nil];
    [temp_dictionary setValue:temp_array forKey:@"Do you know\nhow to\ntalk?"];

    temp_array = [[NSArray alloc] initWithObjects:@"answerdat1",@"answerdat2",@"answerdat3", nil];
    [temp_dictionary setValue:temp_array forKey:@"I'm ain't even\ngonna\nanswer\nthat"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"areyoustupid1",@"areyoustupid2", nil];
    [temp_dictionary setValue:temp_array forKey:@"Are you\nstupid?"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"biggirlpanties1", nil];
    [temp_dictionary setValue:temp_array forKey:@"Deal with\nit"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"franklymydear1",@"franklymydear2",@"franklymydear3", nil];
    [temp_dictionary setValue:temp_array forKey:@"I don't\ngive\na damn"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"girldonteven1",@"girldonteven2",@"girldonteven3",@"girldonteven4", nil];
    [temp_dictionary setValue:temp_array forKey:@"Girl,\ndon't\neven"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"givesadamn1",@"givesadamn2", nil];
    [temp_dictionary setValue:temp_array forKey:@"Who gives\na damn"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"hellno1",@"hellno2",@"hellno3",@"hellno4", nil];
    [temp_dictionary setValue:temp_array forKey:@"Hell\nno!"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"ignoreyoulater1",@"ignoreyoulater2",@"ignoreyoulater3",@"ignoreyoulater4", nil];
    [temp_dictionary setValue:temp_array forKey:@"Can I\nignore you\nlater?"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"liketoagree1",@"liketoagree2", nil];
    [temp_dictionary setValue:temp_array forKey:@"I'd agree\nbut no"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"mmgirl1", nil];
    [temp_dictionary setValue:temp_array forKey:@"Mmmm\nGirl!"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"ohnoyoudidnt1",@"ohnoyoudidnt2",@"ohnoyoudidnt3", nil];
    [temp_dictionary setValue:temp_array forKey:@"Oh no\nyou\ndidn't!"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"ringonit1",@"ringonit2", nil];
    [temp_dictionary setValue:temp_array forKey:@"Should'da put\na ring\non it"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"sayingsomething1",@"sayingsomething2",@"sayingsomething3", nil];
    [temp_dictionary setValue:temp_array forKey:@"Were you\nsaying\nsome-\nthing?"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"shutyomouth1", nil];
    [temp_dictionary setValue:temp_array forKey:@"Shut\nyo\nmouth!"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"whatno1",@"whatno2",@"whatno3", nil];
    [temp_dictionary setValue:temp_array forKey:@"What?\nNo"];
    
    temp_array = [[NSArray alloc] initWithObjects:@"whatwhatwhat1", nil];
    [temp_dictionary setValue:temp_array forKey:@"What?!"];
    
    self.phrases = [temp_dictionary copy];
}

-(NSDictionary *)phrases {
    if( !_phrases )
    {
        _phrases = [[NSDictionary alloc] init];
        [self addDefaultPhrases];
    }
    return _phrases;
}

-(NSString *)getRandomPhrase {
    NSString *temp_phrase = @"Derp";
    
    //temp_phrase = [self.phrases objectAtIndex:arc4random() % self.phrases.count];
    self.current_key = [self.phrases.allKeys objectAtIndex:(arc4random()%self.phrases.allKeys.count)];
    temp_phrase = self.current_key;
    
    return temp_phrase;
}
-(NSString *)getSoundFilePath {
    NSString *temp_path = @"Derp";
    
    NSArray *temp_array = [self.phrases valueForKey:self.current_key];
    temp_path = [temp_array objectAtIndex:arc4random() % temp_array.count];
    
    return temp_path;
}

@end
