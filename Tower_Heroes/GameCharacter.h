//
//  GameCharacter.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameManager.h"

@interface GameCharacter : CCSprite
{
    CGSize screenSize;
        
    CharacterState state;
    ObjectType objectType;
    
    float velocity;
    
    BOOL isActive;
}

@property (readwrite) CharacterState state;
@property (nonatomic, assign) ObjectType objectType;
@property (nonatomic, assign) float velocity;

@property (nonatomic, assign) BOOL isActive;

- (void) changeState: (CharacterState) newState;
- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects;
- (void) updateTimer: (float *) timerPointer 
        withDeltaTime: (ccTime) deltaTime;

@end










