//
//  EnemyMud.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyMud.h"

@implementation EnemyMud

@synthesize eyes;

@synthesize nameString;
@synthesize animationMovementString;
@synthesize animationFrozenString;

- (void) dealloc {
    
    self.eyes = nil;
    self.nameString = nil;
    self.animationMovementString = nil;
    self.animationFrozenString = nil;
    
    [super dealloc];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects {    
    
    [super updateStateWithDeltaTime: deltaTime andListOfGameObjects: listOfGameObjects];
    
    if (self.eyes == nil) {
        self.eyes = [CCSprite node];
        
        NSString *eyesString = [NSString stringWithFormat: @"%@_face_east_1.png", self.nameString];
        
        self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                  spriteFrameByName: eyesString];
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
            
            NSString *eastString = [NSString stringWithFormat: @"%@_face_east_1.png", self.nameString];
            
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: eastString];
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
            
            NSString *westString = [NSString stringWithFormat: @"%@_face_west_1.png", self.nameString];
            
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: westString];
            break;
            
        case kSouthWest:
            self.eyes.visible = YES;
            
            NSString *southwestString = [NSString stringWithFormat: @"%@_face_southwest_1.png", self.nameString];
            
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: southwestString];
            break;
            
        case kSouth:
            self.eyes.visible = YES;
            
            NSString *southString = [NSString stringWithFormat: @"%@_face_south_1.png", self.nameString];
            
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: southString];
            break;
            
        case kSouthEast:
            self.eyes.visible = YES;
            
            NSString *southeastString = [NSString stringWithFormat: @"%@_face_southeast_1.png", self.nameString];
            
            self.eyes.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: southeastString];
            break;
            
        default:
            CCLOG(@"enemy mud: unrecognized direction state");
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
            
            NSString *normalString = [NSString stringWithFormat: @"%@_1.png", self.nameString];
            
            [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: normalString]];
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: self.animationMovementString]]];
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
            
            NSString *onfireString = [NSString stringWithFormat: @"%@_onfire_1.png", self.nameString];
            
            [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: onfireString]];
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            break;
                        
        case kStateFrozen:
            [self stopAllActions];
            
            NSString *frozenString = [NSString stringWithFormat: @"%@_frozen_1.png", self.nameString];
            
            [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: frozenString]];
            [self runAction: [CCSequence actions: 
                              [CCBlink actionWithDuration: 0.25f blinks:4], 
                              [CCShow action], nil]];
            action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                         [[CCAnimationCache sharedAnimationCache] 
                                                          animationByName: self.animationFrozenString]]];
            [self runAction: action];
            break;
            
        default:
            CCLOG(@"//////////////// enemy mud: unknown CharacterState");
            break;
    }
}

- (void) deletingSelf {
    [self.delegate queueEffectToDelete: self.eyes];
    
    [super deletingSelf];
}

- (id) initWithEnemyType: (EnemyType) eType {
    
    self.enemyType = eType;
    
    if (self = [super init]) {
        
        if (eType == kEnemyMud) {
            
            self.nameString = @"mudmonster";
            self.animationMovementString = @"enemyMudMovementAnim";
            self.animationFrozenString = @"enemyMudFrozenAnim";
            
            self.health = kEnemyMudHealth;
            self.normalHealth = kEnemyMudHealth;
            self.armorValue = kEnemyMudArmorValue;
            self.velocity = kEnemyMudNormalVelocity;
            self.coinValue = kEnemyMudCoinValue;
            self.enemyType = kEnemyMud;
            
        } else if (eType == kEnemyCritling) {
            
            self.nameString = @"critling";
            self.animationMovementString = @"enemyCritlingMovementAnim";
            self.animationFrozenString = @"enemyCritlingFrozenAnim";
            
            self.health = kEnemyCritlingHealth;
            self.normalHealth = kEnemyCritlingHealth;
            self.armorValue = kEnemyCritlingArmorValue;
            self.velocity = kEnemyCritlingNormalVelocity;
            self.coinValue = kEnemyCritlingCoinValue;
            self.enemyType = kEnemyCritling;

        } else if (eType == kEnemyPinki) {
            
            self.nameString = @"pinki";
            self.animationMovementString = @"enemyPinkiMovementAnim";
            self.animationFrozenString = @"enemyPinkiFrozenAnim";
            
            self.health = kEnemyPinkiHealth;
            self.normalHealth = kEnemyPinkiHealth;
            self.armorValue = kEnemyPinkiArmorValue;
            self.velocity = kEnemyPinkiNormalVelocity;
            self.coinValue = kEnemyPinkiCoinValue;
            self.enemyType = kEnemyPinki;
            
        } else if (eType == kEnemyTarling) {
            
            self.nameString = @"tarling";
            self.animationMovementString = @"enemyTarlingMovementAnim";
            self.animationFrozenString = @"enemyTarlingFrozenAnim";
            
            self.health = kEnemyTarlingHealth;
            self.normalHealth = kEnemyTarlingHealth;
            self.armorValue = kEnemyTarlingArmorValue;
            self.velocity = kEnemyTarlingNormalVelocity;
            self.coinValue = kEnemyTarlingCoinValue;
            self.enemyType = kEnemyTarling;

        }
        
        NSString *startingSpriteString = [NSString stringWithFormat: @"%@_1.png", self.nameString];
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: startingSpriteString];
        
        id action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                                                        animationByName: self.animationMovementString]]];
        [self runAction: action];        
        
    }
    
    return self;
}

- (id) init
{
    if (self = [super init])
    {   
        
        self.nameString = @"mudmonster";
        self.animationMovementString = @"enemyMudMovementAnim";
        self.animationFrozenString = @"enemyMudFrozenAnim";
        
        // modifiable features
        self.health = kEnemyMudHealth;
        self.normalHealth = kEnemyMudHealth;
        self.armorValue = kEnemyMudArmorValue;
        self.velocity = kEnemyMudNormalVelocity;
        self.coinValue = kEnemyMudCoinValue;
        
        NSString *startingSpriteString = [NSString stringWithFormat: @"%@_1.png", self.nameString];
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: startingSpriteString];
        
        id action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                                                        animationByName: self.animationMovementString]]];
        [self runAction: action];
    }
    return self;
}

@end















