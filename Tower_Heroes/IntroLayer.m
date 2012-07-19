//
//  IntroLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntroLayer.h"

@implementation IntroLayer

- (void) insertTitle {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelBMFont *label = [CCLabelBMFont labelWithString: @"Cut Scene Placeholder" fntFile: @"MushroomText.fnt"];
    label.scale = 0.7f;

    [label setPosition: ccp(screenSize.width/2, screenSize.height/2)];
    
    id actionFadeOut = [CCFadeOut actionWithDuration: 0.5f];
    id actionFadeIn = [CCFadeIn actionWithDuration: 0.5f];
    id actionSequence = [CCSequence actions: actionFadeOut, actionFadeIn, nil];
    id actionForever = [CCRepeatForever actionWithAction: actionSequence];
    
    [label runAction: actionForever];
    
    [self addChild: label
                 z: 1
               tag: 1];
}

- (id) init {
    if (self = [super init])
    {        
        [self insertBackgroundImage];
        [self insertTitle];
        
        id actionDelay = [CCDelayTime actionWithDuration: 2.0f];
        id actionCallFunc = [CCCallFunc actionWithTarget: self selector: @selector(loadingSceneWithoutSound)];
        id actionSequence = [CCSequence actions: actionDelay, actionCallFunc, nil];
        
        [self runAction: actionSequence];
    }
    
    return self;
}

@end



















