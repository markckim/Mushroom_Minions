//
//  BulletBomb.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BulletBomb.h"

@implementation BulletBomb

@synthesize bulletBombEffectSprite;

- (void) dealloc {
    
    self.bulletBombEffectSprite = nil;
    
    [super dealloc];
}

- (void) deletingSelf {
    
    
    [super deletingSelf];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime
             andListOfGameObjects: (CCArray *) listOfGameObjects {
    
    [super updateStateWithDeltaTime: deltaTime andListOfGameObjects: listOfGameObjects];
    
    if (self.state == kStateDead) {
        [self.delegate queueEffectToDelete: self.bulletBombEffectSprite];
    }
    
    if (self.bulletBombEffectSprite == nil) {
        self.bulletBombEffectSprite = [CCSprite node];
        self.bulletBombEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                                   spriteFrameByName: @"bulletbomb_effect_1.png"];
        [self.delegate createEffect: self.bulletBombEffectSprite];
        
        float cocosRotationAngle = -rotationAngle;
        
        self.bulletBombEffectSprite.rotation = cocosRotationAngle;
        self.bulletBombEffectSprite.zOrder = self.zOrder + 1;
        
        id action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                        [[CCAnimationCache sharedAnimationCache] 
                                                         animationByName: @"towerBombBulletEffectAnim"]]];
        
        [self.bulletBombEffectSprite runAction: action];
    }
    
    self.bulletBombEffectSprite.position = self.position;
}


- (void) changeState: (CharacterState) newState {
    [self setState: newState];
    id action = nil;
    
    switch (newState) {
            
        case kStateExploding:
            PLAYSOUNDEFFECT(bulletbomb_explosion_sound);
            action = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                      animationByName: @"towerBombExplosionAnim"]];
            [self runAction: action];
            self.isActive = YES;            
            break;
            
        case kStateDead:
            [self.bulletBombEffectSprite stopAllActions];
            self.bulletBombEffectSprite.visible = NO;
            self.isActive = NO;
            break;
            
        default:
            CCLOG(@"//////////////// BulletBomb: unknown CharacterState");
            break;
    }
}

- (id) init {
    if (self = [super init]) {        
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: @"bulletbomb_1.png"];
        self.velocity = kBulletBombVelocity;
        self.bulletType = kBulletBomb;
        self.bulletDamage = kBulletBombDamage;
        
        // note: bomb bullet is initially set to 'inactive'
        // it only becomes active when it reaches its target destination and explodes
        self.isActive = NO;
    }
    
    return self;
    
} // init

@end














