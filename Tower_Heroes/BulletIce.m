//
//  BulletIce.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BulletIce.h"

@implementation BulletIce

@synthesize bulletIceEffectSprite;
@synthesize bulletIceTrailTimer;

- (void) dealloc {
    self.bulletIceEffectSprite = nil;
    
    [super dealloc];
}

- (void) deletingSelf {
    
    if (self.bulletIceEffectSprite != nil) {
        [self.delegate queueEffectToDelete: self.bulletIceEffectSprite];
    }
    
    [super deletingSelf];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime
             andListOfGameObjects: (CCArray *) listOfGameObjects {
    
    [super updateStateWithDeltaTime: deltaTime andListOfGameObjects: listOfGameObjects];
    
    if (self.bulletIceEffectSprite == nil) {
        self.bulletIceEffectSprite = [CCSprite node];
        self.bulletIceEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                                   spriteFrameByName: @"bulletice_effect_1.png"];
        [self.delegate createEffect: self.bulletIceEffectSprite];
        
        float cocosRotationAngle = -rotationAngle;
        
        self.bulletIceEffectSprite.rotation = cocosRotationAngle;
        self.bulletIceEffectSprite.zOrder = self.zOrder + 1;
        
        id action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                        [[CCAnimationCache sharedAnimationCache] 
                                                         animationByName: @"towerIceBulletEffectAnim"]]];
        
        [self.bulletIceEffectSprite runAction: action];
    }
    
    // timer for the bullet trail effect
    [self updateTimer: &bulletIceTrailTimer
        withDeltaTime: deltaTime];
    
    // create the effect
    if (self.bulletIceTrailTimer < 0.0f) {
        
        if (self.state == kStateDead) {
            return;
        }
        
        // reset the trail timer
        self.bulletIceTrailTimer = kBulletIceTrailTimer;
        
        // create the effect
        // make sure the effect deletes itself
        // position is bullet's current position
        // make sure the trail effect is rotated properly
        
        CCSprite *s = [CCSprite spriteWithSpriteFrameName: @"bulletice_effect_1.png"];
        s.zOrder = self.zOrder + 2;
        s.position = self.position;
        float cocosRotation = - self.rotationAngle;
        s.rotation = cocosRotation;
        s.scale = 0.9f;
        
        id actionScaleUp = [CCScaleTo actionWithDuration: 0.04f scale: 1.2f];
        
        id actionScaleDown = [CCScaleTo actionWithDuration: 0.12f scale: 0.0f];
        id actionFadeOut = [CCFadeOut actionWithDuration: 0.12f];
        id actionSpawn = [CCSpawn actions: actionScaleDown, actionFadeOut, nil];
        
        id actionCallFuncN = [CCCallFuncN actionWithTarget: self selector: @selector(deleteEffect:)];
        
        id actionSequence = [CCSequence actions: actionScaleUp, actionSpawn, actionCallFuncN, nil];
        
        [self.delegate createEffect: s];
        
        [s runAction: actionSequence];
        
    }
    
    self.bulletIceEffectSprite.position = self.position;
    
}

- (void) deleteEffect: (CCSprite *) sender {
    
    [self.delegate queueEffectToDelete: sender];
    
}

- (void) changeState: (CharacterState) newState {
    [self setState: newState];
    
    // id action = nil;
    
    if (newState == kStateDead) {
                
        [self.bulletIceEffectSprite stopAllActions];
        self.bulletIceEffectSprite.visible = NO;
        
        self.isActive = NO;
        
        id actionFadeOut = [CCFadeOut actionWithDuration: 0.08f];
        id actionDelay = [CCDelayTime actionWithDuration: 0.5f];
        id actionSequence = [CCSequence actions: actionFadeOut, actionDelay, nil];
        
        [self stopAllActions];
        [self runAction: actionSequence];
    }
}

- (id) init {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: @"bulletice_1.png"];
        self.velocity = kBulletIceVelocity;
        self.bulletType = kBulletIce;
        self.bulletDamage = kBulletIceDamage;
        
        
    }
    
    return self;
    
} // init

@end







