//
//  TowerIce.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerIce.h"

@implementation TowerIce

@synthesize towerIceFiringSprite;

- (void) dealloc {
    self.towerIceFiringSprite = nil;
    
    [super dealloc];
}

- (void) changeState: (CharacterState) newState
{
    // code here
}

- (void) deletingSelf {
    [self.delegate queueEffectToDelete: self.towerIceFiringSprite];
    
    [super deletingSelf];
}

- (void) firingSequence {
    self.towerIceFiringSprite.visible = YES;
    
    id action = [CCSequence actions: [CCDelayTime actionWithDuration: 0.22f], 
                 [CCCallFunc actionWithTarget:self selector: @selector(timeToShootBullet)], nil];
    
    [self.towerIceFiringSprite runAction: self.firingAction];
    [self runAction: action];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects {
        
    if ([self.towerIceFiringSprite numberOfRunningActions] == 0) {
        self.towerIceFiringSprite.visible = NO;
    }
    
    if (self.towerIceFiringSprite == nil) {
        self.towerIceFiringSprite = [CCSprite node];
        self.towerIceFiringSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                                  spriteFrameByName: @"bulletice_firing_1.png"];
        self.towerIceFiringSprite.position = ccp(self.position.x,self.position.y + self.contentSize.height/2);
        self.towerIceFiringSprite.visible = NO;
        [self.delegate createEffect: self.towerIceFiringSprite];
        self.towerIceFiringSprite.zOrder = self.zOrder + 1;
    }
    
    [super updateStateWithDeltaTime: deltaTime andListOfGameObjects: listOfGameObjects];
    
}


- (void) shootBullet {    
    CGPoint tmpTargetPosition;
    tmpTargetPosition = self.targetToShoot;
        
    PLAYSOUNDEFFECT(bulletice_launch_sound);
        
    [delegate createBulletType: self.bulletType
           withInitialPosition: ccp(self.position.x, self.position.y + self.contentSize.height/2)
             andTargetPosition: tmpTargetPosition
         andBulletDamageEffect: self.bulletDamageEffect
             andAccuracyEffect: self.bulletAccuracyEffect
                 andCritEffect: (self.critEffect + self.rageEffect)
             andTowerReference: self];
    
    self.bulletTimer = 1/(self.firingRate*self.overclockEffect*self.procEffect);
    
    if (self.procEffectBulletCount > 0) {
        self.procEffectBulletCount -= 1;
        
        if (self.procEffectBulletCount == 0) {
            self.procEffect = 1.0f;            
            id actionFadeOut = [CCFadeTo actionWithDuration: 1.0f opacity: 0];
            
            [self.towerProcEffectSprite runAction: actionFadeOut];
        }
    }
}

- (id) init
{
    if (self = [super init]) {
        [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                spriteFrameByName: @"TowerIce_1.png"]];
        self.towerType = kTowerIce;
        self.bulletType = kBulletIce;
        self.bulletTimer = 1/kTowerIceFiringRate;
        self.bulletActive = NO;
        self.firingAction = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache]
                                                             animationByName: @"towerIceFiringAnim"]];
        
        id action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                        [[CCAnimationCache sharedAnimationCache] 
                                                         animationByName: @"towerIceMovementAnim"]]];
        [self runAction: action];
        
        // THIS IS WHERE TALENTS AFFECTS THE GAME
        GameManager *m = [GameManager sharedGameManager];
        NSMutableDictionary *tD = m.selectedHero.talentTree;
        int bulletPropulsionEffect = [[tD objectForKey: @"BulletPropulsion"] intValue];
        int optimizationEffect = [[tD objectForKey: @"Optimization"] intValue];
        int nirvanaEffect = [[tD objectForKey: @"Nirvana"] intValue];
        int sharpshooterEffect = [[tD objectForKey: @"Sharpshooter"] intValue];

        // modifiable features
        self.firingRate = kTowerIceFiringRate + kNirvanaEffect*((float) nirvanaEffect);
        self.towerRange = kTowerIceTowerRange + m.range_static_power + 10*bulletPropulsionEffect;
        self.bulletAccuracyEffect = kTowerIceBulletAccuracyEffect + m.accuracy_static_power + 0.02f*((float) optimizationEffect)
        + 0.01f*((float) sharpshooterEffect);        
        self.bulletDamageEffect = kTowerIceBulletDamageEffect;
        self.critEffect = kTowerIceCritEffect + 0.02f*((float) sharpshooterEffect);
        self.damageUpgradeCost1 = kTowerIceDamageUpgrade1;
        self.damageUpgradeCost2 = kTowerIceDamageUpgrade2;
        self.damageUpgradeCost3 = kTowerIceDamageUpgrade3;
        self.accuracyUpgradeCost1 = kTowerIceAccuracyUpgrade1;
        self.accuracyUpgradeCost2 = kTowerIceAccuracyUpgrade2;
        self.accuracyUpgradeCost3 = kTowerIceAccuracyUpgrade3;
        self.critUpgradeCost1 = kTowerIceCritUpgrade1;
        self.critUpgradeCost2 = kTowerIceCritUpgrade2;
        self.critUpgradeCost3 = kTowerIceCritUpgrade3;
        self.towerTotalValue = kTowerIceCost;
        self.towerBulletDamage = kBulletIceDamage;
        self.towerNormalBulletDamage = kBulletIceDamage;
    }
    return self;
}

@end










