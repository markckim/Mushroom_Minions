//
//  Tower.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"
#import "TowerPlacement.h"

@class ControlsLayer;

@interface Tower : GameCharacter <TowerControlDelegate, CCTargetedTouchDelegate>
{
    id <GamePlayLayerDelegate> delegate;
    id <TowerControlDelegate> tDelegate;
    ControlsLayer *controlsLayer;
    GameCharacter *targetEnemy;
    CCAnimate *firingAction;
    CCSprite *towerPersonalSpace;
    
    float bulletTimer;    
    ButtonType buttonType;
    TowerType towerType;
    BulletType bulletType;
    
    float firingRate;
    float bulletDamageEffect;
    float bulletAccuracyEffect;
    float critEffect;
    float towerRange;
    float menuSquishFactor;
    int removeSignal;
    BOOL firingActive;
    BOOL bulletActive;
    BOOL shootBulletInUpdate;
    CGPoint targetToShoot;
    
    int bulletDamageEffectUpgradeLevel;
    int bulletAccuracyEffectUpgradeLevel;
    int critEffectUpgradeLevel;
    
    // upgrade costs
    int damageUpgradeCost1;
    int damageUpgradeCost2;
    int damageUpgradeCost3;
    int accuracyUpgradeCost1;
    int accuracyUpgradeCost2;
    int accuracyUpgradeCost3;
    int critUpgradeCost1;
    int critUpgradeCost2;
    int critUpgradeCost3;
    
    int towerTotalValue;
    int towerBulletDamage;
    int towerNormalBulletDamage;
    
    NSString *maxString;
    TowerPlacement *towerPlacementReference;
        
    // tower effects
    CCSprite *towerStatusEffectSprite;
    CCSprite *towerProcEffectSprite;
    BOOL isTowerStatusEffectActive;
    float overclockEffect;
    float longshotEffect;
    float rageEffect;
    float procEffect;
    int procEffectBulletCount;
    float procEffectTimer;
    
    float overclockEffectTimer;
    float longshotEffectTimer;
    float rageEffectTimer;
    
}

@property (nonatomic, assign) id <GamePlayLayerDelegate> delegate;
@property (nonatomic, assign) id <TowerControlDelegate> tDelegate;
@property (nonatomic, assign) ControlsLayer *controlsLayer;
@property (nonatomic, assign) GameCharacter *targetEnemy;
@property (nonatomic, strong) CCAnimate *firingAction;
@property (nonatomic, strong) CCSprite *towerPersonalSpace;

@property (nonatomic, assign) float bulletTimer;
@property (nonatomic, assign) ButtonType buttonType;
@property (nonatomic, assign) TowerType towerType;
@property (nonatomic, assign) BulletType bulletType;
@property (nonatomic, assign) TowerPlacement *towerPlacementReference;

@property (nonatomic, assign) float firingRate;
@property (nonatomic, assign) float bulletDamageEffect;
@property (nonatomic, assign) float bulletAccuracyEffect;
@property (nonatomic, assign) float critEffect;
@property (nonatomic, assign) float towerRange;
@property (nonatomic, assign) float menuSquishFactor;
@property (nonatomic, assign) int removeSignal;
@property (nonatomic, assign) BOOL firingActive;
@property (nonatomic, assign) BOOL bulletActive;
@property (nonatomic, assign) BOOL shootBulletInUpdate;
@property (nonatomic, assign) CGPoint targetToShoot;


@property (nonatomic, assign) int bulletDamageEffectUpgradeLevel;
@property (nonatomic, assign) int bulletAccuracyEffectUpgradeLevel;
@property (nonatomic, assign) int critEffectUpgradeLevel;

@property (nonatomic, assign) int damageUpgradeCost1;
@property (nonatomic, assign) int damageUpgradeCost2;
@property (nonatomic, assign) int damageUpgradeCost3;

@property (nonatomic, assign) int accuracyUpgradeCost1;
@property (nonatomic, assign) int accuracyUpgradeCost2;
@property (nonatomic, assign) int accuracyUpgradeCost3;

@property (nonatomic, assign) int critUpgradeCost1;
@property (nonatomic, assign) int critUpgradeCost2;
@property (nonatomic, assign) int critUpgradeCost3;

@property (nonatomic, assign) int towerTotalValue;
@property (nonatomic, assign) int towerBulletDamage;
@property (nonatomic, assign) int towerNormalBulletDamage;

@property (nonatomic, copy) NSString *maxString;

@property (nonatomic, strong) CCSprite *towerStatusEffectSprite;
@property (nonatomic, strong) CCSprite *towerProcEffectSprite;
@property (nonatomic, assign) BOOL isTowerStatusEffectActive;
@property (nonatomic, assign) float overclockEffect;
@property (nonatomic, assign) float longshotEffect;
@property (nonatomic, assign) float rageEffect;
@property (nonatomic, assign) float procEffect;
@property (nonatomic, assign) int procEffectBulletCount;
@property (nonatomic, assign) float overclockEffectTimer;
@property (nonatomic, assign) float longshotEffectTimer;
@property (nonatomic, assign) float rageEffectTimer;
@property (nonatomic, assign) float procEffectTimer;

@property (nonatomic, strong) NSMutableArray *bulletArray; // this will act as a temporary pool of bullets; up to 5 bullets inside the array


- (void) upgradeBulletDamageEffect: (int) bDamage;
- (void) upgradeBulletAccuracyEffect: (float) percentIncrease;
- (void) upgradeCritEffect: (float) percentIncrease;
- (void) shootBullet;
- (void) firingSequence;
- (void) deletingSelf;
- (void) timeToShootBullet;
- (void) showAppropriatePersonalMenu;

- (void) activateProcEffect;

- (void) updateTimer: (float *) timerPointer 
       withDeltaTime: (ccTime) deltaTime
           andTarget: (float *) targetPointer
       andResetValue: (float) targetValue;

- (float) distanceToTarget: (GameCharacter *) gameCharacter;
- (CGRect) rect;
- (BOOL) containsTouchLocation: (UITouch *) touch;
- (void) menuAppear;
- (void) menuDisappear;
- (void) menuDisappearFromTowerRemove;
- (void) menuMoveToNewTower;
- (void) showTowerPersonalSpace;
- (void) hideTowerPersonalSpace;
- (CGPoint) myPosition;

- (void) activateTowerStatusEffect: (CastType) cType;
- (void) deactivateTowerStatusEffect;

@end













