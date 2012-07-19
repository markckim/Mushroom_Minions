//
//  Enemy.h
//  
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"
#import "ImprovedSteps.h"
#import "PathGenerator.h"

@class BackgroundLayer;

@interface Enemy : GameCharacter {
    id <GamePlayLayerDelegate> delegate;
    PathGenerator *path;

    float offScreenWidth;
    float velocityEffect;
    CGPoint currentDestination;
    
    float health;
    float normalHealth;
    float armorValue;
    EnemyType enemyType;
    float frozenEffectTimer;
    float bombEffectTimer;
    
    float deltaX;
    float deltaY;
    float distanceToDestination;
    CCSprite *towerIceExplosionSprite;
    CCSprite *healthbar;
    CCSprite *healthbarBack;
    BOOL towerIceExplosionActive;
    DirectionState directionState;
    
    int coinValue;
    
    CCSprite *enemyStatusEffectSprite;
    float poisonEffectTimer;
    int poisonCounter;
    
    float smiteEffectTimer;
    float slowEffectTimer;
    float slowEffect;
    
    BackgroundLayer *backgroundLayer;
}

@property (nonatomic, assign) BackgroundLayer *backgroundLayer;
@property (nonatomic, assign) id <GamePlayLayerDelegate> delegate;
@property (nonatomic, strong) PathGenerator *path;

@property (nonatomic, assign) float velocityEffect;
@property (nonatomic, assign) CGPoint currentDestination;
@property (nonatomic, assign) float health;
@property (nonatomic, assign) float normalHealth;
@property (nonatomic, assign) float armorValue;
@property (nonatomic, assign) EnemyType enemyType;
@property (nonatomic, assign) float frozenEffectTimer;
@property (nonatomic, assign) float bombEffectTimer;

@property (nonatomic, assign) float deltaX;
@property (nonatomic, assign) float deltaY;
@property (nonatomic, assign) float distanceToDestination;
@property (nonatomic, strong) CCSprite *towerIceExplosionSprite;
@property (nonatomic, strong) CCSprite *healthbar;
@property (nonatomic, strong) CCSprite *healthbarBack;
@property (nonatomic, assign) BOOL towerIceExplosionActive;
@property (nonatomic, assign) DirectionState directionState;

@property (nonatomic, assign) int coinValue;
@property (nonatomic, strong) CCSprite *enemyStatusEffectSprite;
@property (nonatomic, assign) float poisonEffectTimer;
@property (nonatomic, assign) int poisonCounter;
@property (nonatomic, assign) float smiteEffectTimer;
@property (nonatomic, assign) float slowEffectTimer;
@property (nonatomic, assign) float slowEffect;

- (int) takeDamage: (float) baseDamage;
- (void) takePoisonDamage: (float) poisonDamage;

- (void) checkForStateChange;
- (void) initPathGenerator;
- (void) towerIceExplosionEffect;

- (void) activateEnemyStatusEffect: (CastType) cType;

// have enemies override this method
- (void) changeDirectionState: (DirectionState) dState;

// delete any enemy-specific sprites (e.g., eyes) in this method
// then, call [super deletingSelf]
- (void) deletingSelf;

@end











