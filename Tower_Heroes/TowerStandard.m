//
//  TowerStandard.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerStandard.h"

@implementation TowerStandard

@synthesize directionState;

- (void) changeState: (CharacterState) newState
{
    // code here
}

- (void) firingSequence {
    
    // find the direction for the turret to face
    DirectionState newDirectionState;
    
    float deltaX = self.targetEnemy.position.x - self.position.x;
    float deltaY = self.targetEnemy.position.y - self.position.y;
    
    float angleRadians = atanf(deltaY/deltaX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    
    if (deltaX >= 0) {
        if (angleDegrees >= -22.5f && angleDegrees < 22.5f) {
            newDirectionState = kEast;
        } else if (angleDegrees >= 22.5f && angleDegrees < 67.5f) {
            newDirectionState = kNorthEast;
        } else if (angleDegrees >= -67.5f && angleDegrees < -22.5f) {
            newDirectionState = kSouthEast;
        } else if (angleDegrees >= -90.0f && angleDegrees < -67.5f) {
            newDirectionState = kSouth;
        } else if (angleDegrees >= 67.5 && angleDegrees < 90.0f) {
            newDirectionState = kNorth;
        }
    } else if (deltaX < 0) {
        angleDegrees = angleDegrees + 180.0f;
        
        if (angleDegrees >= 90.0f && angleDegrees < 112.5f) {
            newDirectionState = kNorth;
        } else if (angleDegrees >= 112.5f && angleDegrees < 157.5f) {
            newDirectionState = kNorthWest;
        } else if (angleDegrees >= 157.5f && angleDegrees < 202.5f) {
            newDirectionState = kWest;
        } else if (angleDegrees >= 202.5f && angleDegrees < 247.5f) {
            newDirectionState = kSouthWest;
        } else if (angleDegrees >= 247.5f && angleDegrees < 270.0f) {
            newDirectionState = kSouth;
        }
    }
    
    int stepsClockwise = [self stepsClockwiseTo: newDirectionState];
    int stepsCounterClockwise = [self stepsCounterClockwiseTo: newDirectionState];
    CCAnimation *rotationAnim;
    
    if (stepsClockwise < stepsCounterClockwise) {
        // then turret should rotate in the clockwise direction
        rotationAnim = [self addFramesClockwiseTo: newDirectionState];
    } else if (stepsClockwise >= stepsCounterClockwise) {
        // then turrent should rotate in the counterclockwise direction
        rotationAnim = [self addFramesCounterClockwiseTo: newDirectionState];
    }
    
    // i think i can make this slightly more efficient; maybe later
    self.directionState = newDirectionState;
    
    id rotationAction = [CCAnimate actionWithAnimation: rotationAnim];
    id actionSequence = [CCSequence actions: rotationAction, 
                         [CCCallFunc actionWithTarget: self selector: @selector(timeToShootBullet)], nil];
    [self runAction: actionSequence];
}

- (void) shootBullet {
    CGPoint tmpTargetPosition;
    tmpTargetPosition = self.targetToShoot;
    
    CCAnimation *firingAnimation = [CCAnimation animation];
    firingAnimation.delayPerUnit = 0.09;
    firingAnimation.restoreOriginalFrame = YES;
    
    // this refers to the equivalent image which looks like its "firing" instead
    int firingState = self.directionState + 8;
    
    int i = 0;
    
    while (i < 2) {
        NSString *frameString = [NSString stringWithFormat: @"TowerStandard_%d.png", firingState];
        [firingAnimation addSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache]
                                          spriteFrameByName: frameString]];
        i++;
    }
    
    self.firingAction = [CCAnimate actionWithAnimation: firingAnimation];
    [self runAction: self.firingAction];
    
    float radius = 3.0f; // in points
    float dX;
    float dY;
    
    switch (self.directionState) {
            
        case kNorth:
            dX = 0.0f;
            dY = radius;
            break;
            
        case kNorthWest:
            dX = -0.7*radius;
            dY = 0.7*radius;
            break;
            
        case kWest:
            dX = -radius;
            dY = 0.0f;
            break;
            
        case kSouthWest:
            dX = -0.7*radius;
            dY = -0.7*radius;
            break;
            
        case kSouth:
            dX = 0.0f;
            dY = -radius;
            break;
            
        case kSouthEast:
            dX = 0.7*radius;
            dY = -0.7*radius;
            break;
            
        case kEast:
            dX = radius;
            dY = 0.0f;
            break;
            
        case kNorthEast:
            dX = 0.7*radius;
            dY = 0.7*radius;
            break;
            
        default:
            CCLOG(@"TowerStandard: unrecognized direction state");
            break;
    }
    
    float translationUp = 4.0f; // in points

    CGPoint bulletPositionRelativeToTurret = ccp(self.position.x + dX, self.position.y + dY + translationUp);
    
    PLAYSOUNDEFFECT(bulletstandard_launch_sound);    
        
    [delegate createBulletType: self.bulletType
           withInitialPosition: bulletPositionRelativeToTurret
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

- (CCAnimation *) addFramesClockwiseTo: (DirectionState) dState {
    
    // assuming DirectionState goes from 1 - 8, going in the clockwise direction
    
    CCAnimation *testAnimation = [CCAnimation animation];
    testAnimation.delayPerUnit = 0.09;
    testAnimation.restoreOriginalFrame = NO;
    DirectionState testState = self.directionState;
    
    while (testState != dState) {
        testState = testState + 1;
        if (testState == 9) {
            testState = 1;
        }
        NSString *frameString = [NSString stringWithFormat: @"TowerStandard_%d.png", testState];
        [testAnimation addSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache]
                                        spriteFrameByName: frameString]];

    }
    return testAnimation;
}

- (CCAnimation *) addFramesCounterClockwiseTo: (DirectionState) dState {
    
    // assuming DirectionState goes from 1 - 8, going in the clockwise direction

    CCAnimation *testAnimation = [CCAnimation animation];
    testAnimation.delayPerUnit = 0.09;
    testAnimation.restoreOriginalFrame = NO;
    DirectionState testState = self.directionState;
    
    while (testState != dState) {
        testState = testState - 1;
        if (testState == 0) {
            testState = 8;
        }
        NSString *frameString = [NSString stringWithFormat: @"TowerStandard_%d.png", testState];
        [testAnimation addSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache]
                                        spriteFrameByName: frameString]];
    }
    return testAnimation;
}

- (int) stepsClockwiseTo: (DirectionState) dState {
    
    // assuming DirectionState goes from 1 - 8, going in the clockwise direction
    
    int steps = 0;
    DirectionState testState = self.directionState;
    
    while (testState != dState) {
        testState = testState + 1;
        steps++;
        if (testState == 9) {
            testState = 1;
        }
    }
    return steps;
}

- (int) stepsCounterClockwiseTo: (DirectionState) dState {
    
    // assuming DirectionState goes from 1 - 8, going in the clockwise direction
    
    int steps = 0;
    DirectionState testState = self.directionState;
    
    while (testState != dState) {
        testState = testState - 1;
        steps++;
        if (testState == 0) {
            testState = 8;
        }
    }
    return steps;
}

- (id) init
{
    if (self = [super init]) {
        [self setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                spriteFrameByName: @"TowerStandard_1.png"]];
        
        // initialized to kSouth, since we are using "TowerStandard_1.png" here
        self.directionState = kSouth;
        
        self.towerType = kTowerStandard;
        self.bulletType = kBulletStandard;
        self.bulletTimer = 1/kTowerStandardFiringRate;
        
        // THIS IS WHERE TALENTS AFFECT THE GAME
        GameManager *m = [GameManager sharedGameManager];
        NSMutableDictionary *tD = m.selectedHero.talentTree;
        int bulletPropulsionEffect = [[tD objectForKey: @"BulletPropulsion"] intValue];
        int optimizationEffect = [[tD objectForKey: @"Optimization"] intValue];
        int nirvanaEffect = [[tD objectForKey: @"Nirvana"] intValue];
        int sharpshooterEffect = [[tD objectForKey: @"Sharpshooter"] intValue];
        
        
        // modifiable features
        self.firingRate = kTowerStandardFiringRate + kNirvanaEffect*((float) nirvanaEffect);
        self.towerRange = kTowerStandardTowerRange + m.range_static_power + 10*bulletPropulsionEffect;
        self.bulletAccuracyEffect = kTowerStandardBulletAccuracyEffect + m.accuracy_static_power + 0.02f*((float) optimizationEffect)
        + 0.01f*((float) sharpshooterEffect);
        self.bulletDamageEffect = kTowerStandardBulletDamageEffect;
        self.critEffect = kTowerStandardCritEffect + 0.02f*((float) sharpshooterEffect);
        self.damageUpgradeCost1 = kTowerStandardDamageUpgrade1;
        self.damageUpgradeCost2 = kTowerStandardDamageUpgrade2;
        self.damageUpgradeCost3 = kTowerStandardDamageUpgrade3;
        self.accuracyUpgradeCost1 = kTowerStandardAccuracyUpgrade1;
        self.accuracyUpgradeCost2 = kTowerStandardAccuracyUpgrade2;
        self.accuracyUpgradeCost3 = kTowerStandardAccuracyUpgrade3;
        self.critUpgradeCost1 = kTowerStandardCritUpgrade1;
        self.critUpgradeCost2 = kTowerStandardCritUpgrade2;
        self.critUpgradeCost3 = kTowerStandardCritUpgrade3;
        self.towerTotalValue = kTowerStandardCost;
        self.towerBulletDamage = kBulletStandardDamage;
        self.towerNormalBulletDamage = kBulletStandardDamage;
    }
    return self;
}

@end









