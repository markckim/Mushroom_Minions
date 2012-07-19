//
//  PreLoadLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreLoadLayer.h"

@implementation PreLoadLayer

@synthesize loadingLabel;

- (void) dealloc {
    self.loadingLabel = nil;
    
    [super dealloc];
}


- (id) init {
    if (self = [super init]) {
        
        [[GameManager sharedGameManager] performSelectorInBackground: @selector(loadAudioForSceneWithID:) 
                                                          withObject: [NSNumber numberWithInt: kGameScene1]];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.loadingLabel = [CCLabelBMFont labelWithString: @"Loading..." fntFile: @"MushroomText.fnt"];
        self.loadingLabel.scale = 0.7f;
        self.loadingLabel.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild: self.loadingLabel];
        
        id actionFadeOut = [CCFadeOut actionWithDuration: 0.5f];
        id actionFadeIn = [CCFadeIn actionWithDuration: 0.5];
        id actionSequence = [CCSequence actions: actionFadeOut, actionFadeIn, nil];
        id actionForever = [CCRepeatForever actionWithAction: actionSequence];
        
        [self.loadingLabel runAction: actionForever];
        
        id actionDelay = [CCDelayTime actionWithDuration: 2.0f];
        id actionCallFunc = [CCCallFunc actionWithTarget: self selector: @selector(playSceneWithoutSound)];
        id actionSequenceLayer = [CCSequence actions: actionDelay, actionCallFunc, nil];
        
        [self runAction: actionSequenceLayer];
        
    }
    return self;
}

@end
