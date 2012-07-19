//
//  EnemyMinion.m
//  
//
//  Created by Mark Kim on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyMinion.h"

@implementation EnemyMinion

@synthesize helmEffect;

- (void) dealloc {
    self.helmEffect = nil;
    
    [super dealloc];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects {    
    
    [super updateStateWithDeltaTime: deltaTime andListOfGameObjects: listOfGameObjects];

    if (self.helmEffect == nil) {
        self.helmEffect = [CCSprite node];
        self.helmEffect.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                        spriteFrameByName: @"minion_frozen_1.png"];
        self.helmEffect.visible = NO;
        [self.delegate createEffect: self.helmEffect];
    }
    
    self.helmEffect.zOrder = self.zOrder;
    self.helmEffect.position = self.position;
    
}

- (void) deletingSelf {
    
    if (self.helmEffect != nil) {
        [self.delegate queueEffectToDelete: self.helmEffect];
    }
    
    [super deletingSelf];
}


- (void) changeDirectionState: (DirectionState) dState {
    
    self.directionState = dState;
    id action = nil;
    
    switch (self.directionState) {
            
        case kEast:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionEastAnim"]]];
            [self runAction: action];
            break;
            
        case kNorthEast:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionNorthEastAnim"]]];
            [self runAction: action];
            break;
            
        case kNorth:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionNorthAnim"]]];
            [self runAction: action];
            break;
            
        case kNorthWest:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionNorthWestAnim"]]];
            [self runAction: action];
            break;
            
        case kWest:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionWestAnim"]]];
            [self runAction: action];
            break;
            
        case kSouthWest:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionSouthWestAnim"]]];
            [self runAction: action];
            break;
            
        case kSouth:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionSouthAnim"]]];
            [self runAction: action];
            break;
            
        case kSouthEast:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyMinionSouthEastAnim"]]];
            [self runAction: action];
            break;
            
        default:
            CCLOG(@"enemy minion: unrecognized direction state");
            break;
    }
}

- (void) changeState: (CharacterState) newState {
    if (state == kStateDead) {
        return;
    }
    
    [self setState: newState];
    // id action = nil;
    
    switch (newState) {
            
        case kStateNormal:
            self.helmEffect.visible = NO;
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
            
        case kStateDead:
            self.isActive = NO;
            [self stopAllActions];
            [self runAction: [CCFadeOut actionWithDuration: 1.0f]];
            [self runAction: [CCShow action]];
            [self.helmEffect runAction: [CCFadeOut actionWithDuration: 1.0f]];
            break;
            
        case kStateOnFire:
            self.helmEffect.visible = YES;
            self.helmEffect.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                            spriteFrameByName: @"minion_onfire_1.png"];
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
            
        case kStateFrozen:
            self.helmEffect.visible = YES;
            self.helmEffect.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                            spriteFrameByName: @"minion_frozen_1.png"];            
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
            
        default:
            CCLOG(@"enemy minion: unknown CharacterState");
            break;
    }
}

- (id) init
{
    if (self = [super init])
    {   
        NSString *minionString = [NSString stringWithFormat: @"minion_east_1.png"];
        
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: minionString];        
        
        // modifiable features
        self.health = kEnemyMinionHealth;
        self.normalHealth = kEnemyMinionHealth;
        self.armorValue = kEnemyMinionArmorValue;
        self.velocity = kEnemyMinionNormalVelocity;
        self.coinValue = kEnemyMinionCoinValue;
        self.enemyType = kEnemyMinion;
    }
    return self;
}

@end
















