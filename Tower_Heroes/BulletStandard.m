//
//  BulletStandard.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BulletStandard.h"
#import "Enemy.h"

@implementation BulletStandard

@synthesize bulletStandardEffectSprite;

@synthesize bulletStandardTrailTimer;

- (void) dealloc {
    
    self.bulletStandardEffectSprite = nil;
    
    [super dealloc];
}

- (void) changeState: (CharacterState) newState {
    [self setState: newState];
    
    if (newState == kStateDead) {
        self.isActive = NO;
        
        if (self.bulletStandardEffectSprite != nil) {
            self.bulletStandardEffectSprite.visible = NO;
        }
                
        if (self.dud == YES) {
            
            id actionFadeOut = [CCFadeOut actionWithDuration: 0.08f];
            id actionDelay = [CCDelayTime actionWithDuration: 0.5f];
            id actionSequence = [CCSequence actions: actionFadeOut, actionDelay, nil];
            
            [self stopAllActions];
            [self runAction: actionSequence];
        }
        
    }
}

- (void) deletingSelf {
    
    if (self.bulletStandardEffectSprite != nil) {
        [self.delegate queueEffectToDelete: self.bulletStandardEffectSprite];
    }
    
    [super deletingSelf];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime
             andListOfGameObjects: (CCArray *) listOfGameObjects {
    
    [super updateStateWithDeltaTime: deltaTime andListOfGameObjects: listOfGameObjects];
    
    // start up the bullet standard effect sprite
    if (self.bulletStandardEffectSprite == nil) {
        self.bulletStandardEffectSprite = [CCSprite node];
        self.bulletStandardEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                                        spriteFrameByName: @"bulletice_effect_1.png"];
        [self.delegate createEffect: self.bulletStandardEffectSprite];
        
        float cocosRotationAngle = -rotationAngle;
        
        self.bulletStandardEffectSprite.rotation = cocosRotationAngle;
        self.bulletStandardEffectSprite.zOrder = self.zOrder + 1;
        
        id action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                        [[CCAnimationCache sharedAnimationCache] 
                                                         animationByName: @"towerStandardBulletEffectAnim"]]];
        
        [self.bulletStandardEffectSprite runAction: action];
    }
    
    // timer for the bullet trail effect
    [self updateTimer: &bulletStandardTrailTimer
        withDeltaTime: deltaTime];
    
    // create the effect
    if (self.bulletStandardTrailTimer < 0.0f) {
        
        if (self.state == kStateDead) {
            return;
        }
        
        // reset the trail timer
        self.bulletStandardTrailTimer = kBulletStandardTrailTimer;
        
        // create the effect
        // make sure the effect deletes itself
        // position is bullet's current position
        // make sure the trail effect is rotated properly
        
        CCSprite *s = [CCSprite spriteWithSpriteFrameName: @"bulletstandard_aftereffect_1.png"];
        s.zOrder = self.zOrder + 2;
        s.position = self.position;
        float cocosRotation = - self.rotationAngle;
        
        // add a bit of randomness to the bullet effect trail
        float angleNoise = (((float) arc4random()/ (float) ARC4RANDOM_MAX) - 0.5f)*2.0f*8.0f; // random angle -8 through 8 degrees
        float scaleNoise = (((float) arc4random()/ (float) ARC4RANDOM_MAX) - 0.5f)*2.0f*0.3f; // random scale -0.3 through 0.3
        
        s.rotation = cocosRotation + angleNoise;
        s.scale = 0.6f;
        
        id actionScaleUp = [CCScaleTo actionWithDuration: 0.05f scale: 0.7f + scaleNoise];
        
        id actionScaleDown = [CCScaleTo actionWithDuration: 0.35f scale: 0.0f];
        id actionFadeOut = [CCFadeOut actionWithDuration: 0.35f];
        id actionSpawn = [CCSpawn actions: actionScaleDown, actionFadeOut, nil];

        id actionCallFuncN = [CCCallFuncN actionWithTarget: self selector: @selector(deleteEffect:)];
        
        id actionSequence = [CCSequence actions: actionScaleUp, actionSpawn, actionCallFuncN, nil];
        
        [self.delegate createEffect: s];
        
        [s runAction: actionSequence];
        
    }
    
    self.bulletStandardEffectSprite.position = self.position;
    
}

- (void) deleteEffect: (CCSprite *) sender {
    
    [self.delegate queueEffectToDelete: sender];
    
}


- (id) init {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: @"bulletstandard_1.png"];
        self.velocity = kBulletStandardVelocity;
        self.bulletType = kBulletStandard;
        self.bulletDamage = kBulletStandardDamage;
        
        self.bulletStandardTrailTimer = kBulletStandardTrailTimer;
    }
    return self;
}

@end










