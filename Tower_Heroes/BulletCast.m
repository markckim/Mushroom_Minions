//
//  BulletCast.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BulletCast.h"
#import "GamePlayLayer.h"
#import "Enemy.h"

@implementation BulletCast

@synthesize castType;
@synthesize mineTimer;
@synthesize gamePlayLayer;

- (void) dealloc {
    
    self.gamePlayLayer = nil;
    
    [super dealloc];
}

- (void) changeState: (CharacterState) newState {
    [self setState: newState];
    
    
    if (newState == kStateDead) {
        self.isActive = NO;
    }
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime
             andListOfGameObjects: (CCArray *) listOfGameObjects {
    
    
    if (self.castType == kCastSmite) {
    }
    
    if (self.castType == kCastMine) {
        
        if (self.isActive == YES) {
            self.isActive = NO;
            self.state = kStateDead;
            return;
        }
        
        if (self.state == kStateNone) {
            return;
            
        } else if (self.state == kStateDead) {
            
            if ([self numberOfRunningActions] > 0) {
                return;
            } else {
                [self deletingSelf];
                return;
            }
            
        } else if (self.state == kStateExploding) {
            
            PLAYSOUNDEFFECT(bulletbomb_explosion_sound);
            
            self.isActive = YES;
            
            [self stopAllActions];
                        
            id actionExplosion = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                                  animationByName: @"towerBombExplosionAnim"]];
            [self runAction: actionExplosion];
            
            return;
        }
        
        // need timer here for duration of mine existence
        // timer should "freeze" if the mine detects an enemy
        if (self.mineTimer > 0) {
            self.mineTimer -= deltaTime;
        } else {
            [self deletingSelf];
        }
        
        // check if any enemies are close to the mine
        float detectionRadius = 40.0f;
        
        for (Enemy *e in self.gamePlayLayer.enemyCollection) {
                        
            float dX = e.position.x - self.position.x;
            float dY = e.position.y - self.position.y;
            float distance = sqrt(pow(dX,2.0f) + pow(dY,2.0f));
            
            if (distance < detectionRadius) {  
                [self explosionSequence];
            }
        }
        
    }
}

- (void) activateMine {
    self.state = kStateExploding;
}

- (void) explosionSequence {
    
    PLAYSOUNDEFFECT(play_button_sound);
    
    self.state = kStateNone;
    
    [self stopAllActions];
        
    id actionDelay = [CCDelayTime actionWithDuration: 2.0f];
    id actionAnimationFast = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                              animationByName: @"c1_p3_fast_"]];
    id actionRepeat = [CCRepeat actionWithAction: actionAnimationFast times: 12];
    
    id actionSpawn = [CCSpawn actions: actionDelay, actionRepeat, nil];
    id actionCallFunc1 = [CCCallFunc actionWithTarget: self selector: @selector(activateMine)];
    
    id actionSequence = [CCSequence actions: actionSpawn, actionCallFunc1, nil];
    
    [self runAction: actionSequence];
}

- (id) init {
    
    // don't use this method
    
    if (self = [super init]) {
    
    }
    return self;
}

- (id) initWithLocation: (CGPoint) pos 
            andCastType: (CastType) cType {
    
    if (self = [super init]) {
        self.bulletType = kBulletCast;
        self.castType = cType;
        self.position = pos;
        self.mineTimer = -1.0f;
        
        self.velocity = 0;
                
        if (cType == kCastMine) {
            self.bulletDamage = kMineDamage;
        }
        
    }
    
    return self;
}


@end














