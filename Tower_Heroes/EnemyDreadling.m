//
//  EnemyDreadling.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyDreadling.h"

@implementation EnemyDreadling

@synthesize eyes;

- (void) dealloc {
    self.eyes = nil;
    
    [super dealloc];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects {    
    
    [super updateStateWithDeltaTime: deltaTime andListOfGameObjects: listOfGameObjects];
    
    if (self.eyes == nil) {
        self.eyes = [CCSprite node];
        self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                  spriteFrameByName: @"dreadling_face_east_1.png"];
        [self.delegate createEffect: self.eyes];
        
        self.directionState = kDirectionNone;

    }
    
    self.eyes.zOrder = self.zOrder;
    self.eyes.position = self.position;    
}

- (void) changeDirectionState: (DirectionState) dState {
    
    self.directionState = dState;
    
    switch (self.directionState) {
            
        case kEast:
            self.eyes.visible = YES;
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: @"dreadling_face_east_1.png"];
            break;
            
        case kNorthEast:
            self.eyes.visible = NO;
            break;
            
        case kNorth:
            self.eyes.visible = NO;
            break;
            
        case kNorthWest:
            self.eyes.visible = NO;
            break;
            
        case kWest:
            self.eyes.visible = YES;
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: @"dreadling_face_west_1.png"];
            break;
            
        case kSouthWest:
            self.eyes.visible = YES;
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: @"dreadling_face_southwest_1.png"];
            break;
            
        case kSouth:
            self.eyes.visible = YES;
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: @"dreadling_face_south_1.png"];
            break;
            
        case kSouthEast:
            self.eyes.visible = YES;
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: @"dreadling_face_southeast_1.png"];
            break;
            
        default:
            CCLOG(@"dreadling: unrecognized direction state");
            break;
    }
}

- (void) changeState: (CharacterState) newState {
    if (state == kStateDead) {
        return;
    }
    
    [self setState: newState];
    id action = nil;
    
    switch (newState) {
            
        case kStateNormal:
            [self stopAllActions];
            [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: @"dreadling_1.png"]];
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyDreadlingMovementAnim"]]];
            [self runAction: action];
            break;
            
        case kStateDead:
            self.isActive = NO;
            [self stopAllActions];
            [self runAction: [CCFadeOut actionWithDuration: 1.0f]];
            [self runAction: [CCShow action]];
            [self.eyes runAction: [CCFadeOut actionWithDuration: 1.0f]];
            break;
            
        case kStateOnFire:
            [self stopAllActions];
            [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: @"dreadling_onfire_1.png"]];
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
            
        case kStateFrozen:
            [self stopAllActions];
            [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: @"dreadling_frozen_1.png"]];
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyDreadlingFrozenAnim"]]];
            [self runAction: action];
            break;
            
        default:
            CCLOG(@"//////////////// Dreadling: unknown CharacterState");
            break;
    }
}

- (void) deletingSelf {
    [self.delegate queueEffectToDelete: self.eyes];
    
    [super deletingSelf];
}

- (id) init
{
    if (self = [super init])
    {   
        NSString *dreadlingString = [NSString stringWithFormat: @"dreadling_1.png"];
        
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: dreadlingString];
        
        id action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                        [[CCAnimationCache sharedAnimationCache] 
                                                         animationByName: @"enemyDreadlingMovementAnim"]]];
        [self runAction: action];
        
        // modifiable features
        self.health = kEnemyDreadlingHealth;
        self.normalHealth = kEnemyDreadlingHealth;
        self.armorValue = kEnemyDreadlingArmorValue;
        self.velocity = kEnemyDreadlingNormalVelocity;
        self.coinValue = kEnemyDreadlingCoinValue;
        self.enemyType = kEnemyDreadling;
    }
    return self;
}


@end
