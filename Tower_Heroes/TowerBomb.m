//
//  TowerBomb.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerBomb.h"

@implementation TowerBomb

- (void) firingSequence {
    
    id action = [CCSequence actions: [CCDelayTime actionWithDuration: 0.22f], 
                 [CCCallFunc actionWithTarget:self selector: @selector(timeToShootBullet)], nil];
    
    [self runAction: self.firingAction];
    [self runAction: action];
}

- (void) shootBullet {    
    CGPoint tmpTargetPosition;
    tmpTargetPosition = self.targetToShoot;
        
    PLAYSOUNDEFFECT(bulletbomb_launch_sound);
        
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
                                spriteFrameByName: @"TowerBomb_1.png"]];
        self.towerType = kTowerBomb;
        self.bulletType = kBulletBomb;
        self.bulletTimer = 1/kTowerBombFiringRate;
        self.firingAction = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache]
                                                             animationByName: @"towerBombFiringAnim"]];
        
        // THIS IS WHERE TALENTS AFFECTS THE GAME
        GameManager *m = [GameManager sharedGameManager];
        NSMutableDictionary *tD = m.selectedHero.talentTree;
        int bulletPropulsionEffect = [[tD objectForKey: @"BulletPropulsion"] intValue];
        int optimizationEffect = [[tD objectForKey: @"Optimization"] intValue];
        int nirvanaEffect = [[tD objectForKey: @"Nirvana"] intValue];
        int sharpshooterEffect = [[tD objectForKey: @"Sharpshooter"] intValue];

        // modifiable features
        self.firingRate = kTowerBombFiringRate + kNirvanaEffect*((float) nirvanaEffect);
        self.towerRange = kTowerBombTowerRange + m.range_static_power + 10*bulletPropulsionEffect;
        self.bulletAccuracyEffect = kTowerBombBulletAccuracyEffect + m.accuracy_static_power + 0.02f*((float) optimizationEffect)
        + 0.01f*((float) sharpshooterEffect);        
        self.bulletDamageEffect = kTowerBombBulletDamageEffect;
        self.critEffect = kTowerBombCritEffect + 0.02f*((float) sharpshooterEffect);
        self.damageUpgradeCost1 = kTowerBombDamageUpgrade1;
        self.damageUpgradeCost2 = kTowerBombDamageUpgrade2;
        self.damageUpgradeCost3 = kTowerBombDamageUpgrade3;
        self.accuracyUpgradeCost1 = kTowerBombAccuracyUpgrade1;
        self.accuracyUpgradeCost2 = kTowerBombAccuracyUpgrade2;
        self.accuracyUpgradeCost3 = kTowerBombAccuracyUpgrade3;
        self.critUpgradeCost1 = kTowerBombCritUpgrade1;
        self.critUpgradeCost2 = kTowerBombCritUpgrade2;
        self.critUpgradeCost3 = kTowerBombCritUpgrade3;
        self.towerTotalValue = kTowerBombCost;
        self.towerBulletDamage = kBulletBombDamage;
        self.towerNormalBulletDamage = kBulletBombDamage;
    }
    return self;
}

@end






