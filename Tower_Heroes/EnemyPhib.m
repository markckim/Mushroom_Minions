//
//  EnemyPhib.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyPhib.h"

@implementation EnemyPhib


- (void) changeDirectionState: (DirectionState) dState {
    
    self.directionState = dState;
    id action = nil;
    
    switch (self.directionState) {
            
        case kEast:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibEastAnim"]]];
            [self runAction: action];
            break;
            
        case kNorthEast:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibNorthEastAnim"]]];
            [self runAction: action];
            break;
            
        case kNorth:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibNorthAnim"]]];
            [self runAction: action];
            break;
            
        case kNorthWest:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibNorthWestAnim"]]];
            [self runAction: action];
            break;
            
        case kWest:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibWestAnim"]]];
            [self runAction: action];
            break;
            
        case kSouthWest:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibSouthWestAnim"]]];
            [self runAction: action];
            break;
            
        case kSouth:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibSouthAnim"]]];
            [self runAction: action];
            break;
            
        case kSouthEast:
            [self stopAllActions];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: @"enemyPhibSouthEastAnim"]]];
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
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
            
        case kStateDead:
            self.isActive = NO;
            [self stopAllActions];
            [self runAction: [CCFadeOut actionWithDuration: 1.0f]];
            [self runAction: [CCShow action]];
            break;
            
        case kStateOnFire:
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
            
        case kStateFrozen:
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
            
        default:
            CCLOG(@"//////////////// enemy phib: unknown CharacterState");
            break;
    }
}

- (id) init
{
    if (self = [super init])
    {   
        NSString *phibString = [NSString stringWithFormat: @"phib_east_1.png"];
        
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: phibString];
        self.directionState = kDirectionNone;
        
        // modifiable features
        self.health = kEnemyPhibHealth;
        self.normalHealth = kEnemyPhibHealth;
        self.armorValue = kEnemyPhibArmorValue;
        self.velocity = kEnemyPhibNormalVelocity;
        self.coinValue = kEnemyPhibCoinValue;
        self.enemyType = kEnemyPhib;
    }
    return self;
}

@end
















