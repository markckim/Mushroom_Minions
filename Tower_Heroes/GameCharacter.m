//
//  GameCharacter.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter

@synthesize state;
@synthesize objectType;
@synthesize velocity;
@synthesize isActive;

- (void) updateTimer: (float *) timerPointer 
        withDeltaTime: (ccTime) deltaTime {
    
    if (*timerPointer < 0.0f) {
        return;
    }
    
    *timerPointer = *timerPointer - deltaTime;
    if (*timerPointer < 0.0f) {
        *timerPointer = -1.0f;
    }
}

- (void) changeState: (CharacterState) newState {
    CCLOG(@"GameCharacter: changeState: method should be updated by subclass");
    [self setState: newState];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects {
    CCLOG(@"GameCharacter: updateStateWithDeltaTime:andListOfGameObjects: method should be updated by subclass");
}


- (id) init {
    if (self = [super init]) {
        
        screenSize = [[CCDirector sharedDirector] winSize];
                
        self.state = kStateNormal;
        self.objectType = kTypeNone;
        self.isActive = YES;                
    }
    
    return self;
}

@end





























