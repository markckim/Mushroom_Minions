//
//  LoadingLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingLayer.h"

@implementation LoadingLayer

@synthesize loadingLabel;

- (void) dealloc {
    self.loadingLabel = nil;
    
    [super dealloc];
}

- (void) insertTitle {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString: @"Loading Scene"
                                           fontName: @"Helvetica"
                                           fontSize: 28];
    [label setPosition: ccp(screenSize.width/2, screenSize.height/2)];
    
    id actionFadeOut = [CCFadeOut actionWithDuration: 1.0f];
    id actionFadeIn = [CCFadeIn actionWithDuration: 0.75f];
    id actionSequence = [CCSequence actions: actionFadeOut, actionFadeIn, nil];
    id actionForever = [CCRepeatForever actionWithAction: actionSequence];
    
    [label runAction: actionForever];
    
    [self addChild: label
                 z: 1
               tag: 1];
}

- (void) initAnimations {
    
    GameManager *m = [GameManager sharedGameManager];
    
    // Tower Standard
    CCAnimation *towerStandardBulletEffectAnim = [[GameManager sharedGameManager]
                                                  loadPlistForAnimationWithName: @"bulletEffectAnim"
                                                  andClassName: @"TowerStandard"];
    CCAnimation *towerStandardBulletImpactAnim = [[GameManager sharedGameManager]
                                                  loadPlistForAnimationWithName: @"bulletImpactAnim"
                                                  andClassName: @"TowerStandard"];
    CCAnimation *towerStandardBulletCritAnim = [[GameManager sharedGameManager]
                                                  loadPlistForAnimationWithName: @"bulletCritAnim"
                                                  andClassName: @"TowerStandard"];
    
     // Tower Bomb
     CCAnimation *towerBombExplosionAnim = [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"explosionAnim"
     andClassName: @"TowerBomb"];
     CCAnimation *towerBombFiringAnim = [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"firingAnim"
     andClassName: @"TowerBomb"];
     CCAnimation *towerBombBulletEffectAnim = [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"bulletEffectAnim"
     andClassName: @"TowerBomb"];
     
     // Tower Ice
     CCAnimation *towerIceExplosionAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"explosionAnim"
     andClassName: @"TowerIce"];
     CCAnimation *towerIceMovementAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"movementAnim"
     andClassName: @"TowerIce"];
     CCAnimation *towerIceFiringAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"firingAnim"
     andClassName: @"TowerIce"];
     CCAnimation *towerIceBulletEffectAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"bulletEffectAnim"
     andClassName: @"TowerIce"];
     
     // Enemy Mud
     CCAnimation *enemyMudMovementAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"movementAnim"
     andClassName: @"EnemyMud"];
     CCAnimation *enemyMudFrozenAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"frozenAnim"
     andClassName: @"EnemyMud"];
    
    // Enemy Critling
    CCAnimation *enemyCritlingMovementAnim = [m loadPlistForAnimationWithName: @"movementAnim" andClassName: @"EnemyCritling"];
    CCAnimation *enemyCritlingFrozenAnim = [m loadPlistForAnimationWithName: @"frozenAnim" andClassName: @"EnemyCritling"];
    
    // Enemy pinki
    CCAnimation *enemyPinkiMovementAnim = [m loadPlistForAnimationWithName: @"movementAnim" andClassName: @"EnemyPinki"];
    CCAnimation *enemyPinkiFrozenAnim = [m loadPlistForAnimationWithName: @"frozenAnim" andClassName: @"EnemyPinki"];
    
    // Enemy Tarling
    CCAnimation *enemyTarlingMovementAnim = [m loadPlistForAnimationWithName: @"movementAnim" andClassName: @"EnemyTarling"];
    CCAnimation *enemyTarlingFrozenAnim = [m loadPlistForAnimationWithName: @"frozenAnim" andClassName: @"EnemyTarling"];
     
     CCAnimation *enemyDreadlingMovementAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"movementAnim"
     andClassName: @"EnemyDreadling"];
     CCAnimation *enemyDreadlingFrozenAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"frozenAnim"
     andClassName: @"EnemyDreadling"];
     
     // Enemy Minion
     CCAnimation *enemyMinionEastAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"eastAnim"
     andClassName: @"EnemyMinion"];
     CCAnimation *enemyMinionNorthEastAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"northEastAnim"
     andClassName: @"EnemyMinion"];
     CCAnimation *enemyMinionNorthAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"northAnim"
     andClassName: @"EnemyMinion"];
     CCAnimation *enemyMinionNorthWestAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"northWestAnim"
     andClassName: @"EnemyMinion"];
     CCAnimation *enemyMinionWestAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"westAnim"
     andClassName: @"EnemyMinion"];
     CCAnimation *enemyMinionSouthWestAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"southWestAnim"
     andClassName: @"EnemyMinion"];
     CCAnimation *enemyMinionSouthAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"southAnim"
     andClassName: @"EnemyMinion"];
     CCAnimation *enemyMinionSouthEastAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"southEastAnim"
     andClassName: @"EnemyMinion"];
     
     // Enemy Phib
     CCAnimation *enemyPhibNorthAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"northAnim"
     andClassName: @"EnemyPhib"];
     CCAnimation *enemyPhibNorthEastAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"northEastAnim"
     andClassName: @"EnemyPhib"];
     CCAnimation *enemyPhibEastAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"eastAnim"
     andClassName: @"EnemyPhib"];
     CCAnimation *enemyPhibSouthEastAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"southEastAnim"
     andClassName: @"EnemyPhib"];
     CCAnimation *enemyPhibSouthAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"southAnim"
     andClassName: @"EnemyPhib"];
     CCAnimation *enemyPhibSouthWestAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"southWestAnim"
     andClassName: @"EnemyPhib"];
     CCAnimation *enemyPhibWestAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"westAnim"
     andClassName: @"EnemyPhib"];
     CCAnimation *enemyPhibNorthWestAnim =  [[GameManager sharedGameManager] 
     loadPlistForAnimationWithName: @"northWestAnim"
     andClassName: @"EnemyPhib"];
     
    // Powers
    CCAnimation *c1_p3_normal_ = [[GameManager sharedGameManager] loadPlistForAnimationWithName: @"c1_p3_normal_"
                                                                                   andClassName: @"Powers"];
    CCAnimation *c1_p3_fast_ = [[GameManager sharedGameManager] loadPlistForAnimationWithName: @"c1_p3_fast_"
                                                                                 andClassName: @"Powers"];
    CCAnimation *c3_proc_ = [[GameManager sharedGameManager] loadPlistForAnimationWithName: @"c3_proc_"
                                                                                 andClassName: @"Powers"];
    
    // Tower Standard
    [[CCAnimationCache sharedAnimationCache] addAnimation: towerStandardBulletEffectAnim 
                                                     name: @"towerStandardBulletEffectAnim"];
    [[CCAnimationCache sharedAnimationCache] addAnimation: towerStandardBulletImpactAnim 
                                                     name: @"towerStandardBulletImpactAnim"];
    [[CCAnimationCache sharedAnimationCache] addAnimation: towerStandardBulletCritAnim 
                                                     name: @"towerStandardBulletCritAnim"];
    
     // Tower Bomb
     [[CCAnimationCache sharedAnimationCache] addAnimation: towerBombExplosionAnim 
     name: @"towerBombExplosionAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: towerBombFiringAnim 
     name: @"towerBombFiringAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: towerBombBulletEffectAnim 
     name: @"towerBombBulletEffectAnim"];
     
     // Tower Ice
     [[CCAnimationCache sharedAnimationCache] addAnimation: towerIceExplosionAnim
     name: @"towerIceExplosionAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: towerIceMovementAnim
     name: @"towerIceMovementAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: towerIceFiringAnim
     name: @"towerIceFiringAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: towerIceBulletEffectAnim
     name: @"towerIceBulletEffectAnim"];
     
     // Enemy Mud
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMudMovementAnim
     name: @"enemyMudMovementAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMudFrozenAnim
     name: @"enemyMudFrozenAnim"];
    
    // Enemy Critling
    [[CCAnimationCache sharedAnimationCache] addAnimation: enemyCritlingMovementAnim
                                                      name: @"enemyCritlingMovementAnim"];
    [[CCAnimationCache sharedAnimationCache] addAnimation: enemyCritlingFrozenAnim
                                                     name: @"enemyCritlingFrozenAnim"];
    
    // Enemy Pinki
    [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPinkiMovementAnim
                                                     name: @"enemyPinkiMovementAnim"];
    [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPinkiFrozenAnim
                                                     name: @"enemyPinkiFrozenAnim"];
    
    // Enemy Tarling    
    [[CCAnimationCache sharedAnimationCache] addAnimation: enemyTarlingMovementAnim
                                                     name: @"enemyTarlingMovementAnim"];
    [[CCAnimationCache sharedAnimationCache] addAnimation: enemyTarlingFrozenAnim
                                                     name: @"enemyTarlingFrozenAnim"];
     
     // Enemy Dreadling
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyDreadlingMovementAnim
     name: @"enemyDreadlingMovementAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyDreadlingFrozenAnim
     name: @"enemyDreadlingFrozenAnim"];
     
     // Enemy Minion
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionEastAnim
     name: @"enemyMinionEastAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionNorthEastAnim
     name: @"enemyMinionNorthEastAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionNorthAnim
     name: @"enemyMinionNorthAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionNorthWestAnim
     name: @"enemyMinionNorthWestAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionWestAnim
     name: @"enemyMinionWestAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionSouthWestAnim
     name: @"enemyMinionSouthWestAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionSouthAnim
     name: @"enemyMinionSouthAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyMinionSouthEastAnim
     name: @"enemyMinionSouthEastAnim"];
     
     // Enemy Phib
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibNorthAnim
     name: @"enemyPhibNorthAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibNorthEastAnim
     name: @"enemyPhibNorthEastAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibEastAnim
     name: @"enemyPhibEastAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibSouthEastAnim
     name: @"enemyPhibSouthEastAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibSouthAnim
     name: @"enemyPhibSouthAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibSouthWestAnim
     name: @"enemyPhibSouthWestAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibWestAnim
     name: @"enemyPhibWestAnim"];
     [[CCAnimationCache sharedAnimationCache] addAnimation: enemyPhibNorthWestAnim
     name: @"enemyPhibNorthWestAnim"];
    
    // Powers
    [[CCAnimationCache sharedAnimationCache] addAnimation: c1_p3_normal_
                                                     name: @"c1_p3_normal_"];
    [[CCAnimationCache sharedAnimationCache] addAnimation: c1_p3_fast_
                                                     name: @"c1_p3_fast_"];
    [[CCAnimationCache sharedAnimationCache] addAnimation: c3_proc_
                                                     name: @"c3_proc_"];


}

- (id) init {
    if (self = [super init]) {
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        [self initAnimations];
        
        // loading the audio for the game scene
        GameManager *m = [GameManager sharedGameManager];
        [m performSelectorInBackground: @selector(loadAudioForSceneWithID:) 
                            withObject: [NSNumber numberWithInt: kGameScene1]];
        
        // loading the correct static powers for the selected hero
        if (m.selectedHero.characterID == 1) {
            
            m.accuracy_static_power = ACCURACY_STATIC_POWER;
            m.range_static_power = 0.0f;
            m.proc_static_power = NO;
            
        } else if (m.selectedHero.characterID == 2) {
            
            m.accuracy_static_power = 0.0f;
            m.range_static_power = RANGE_STATIC_POWER;
            m.proc_static_power = NO;

        } else if (m.selectedHero.characterID == 3) {
            
            m.accuracy_static_power = 0.0f;
            m.range_static_power = 0.0f;
            m.proc_static_power = YES;
            
        }
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.loadingLabel = [CCLabelBMFont labelWithString: @"Loading..." fntFile: @"MushroomText.fnt"];
        self.loadingLabel.scale = 0.7f;
        self.loadingLabel.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild: self.loadingLabel];
        
        id actionFadeOut = [CCFadeOut actionWithDuration: 0.5f];
        id actionFadeIn = [CCFadeIn actionWithDuration: 0.5];
        id actionSequence = [CCSequence actions: actionFadeOut, actionFadeIn, nil];
        id actionForever = [CCRepeatForever actionWithAction: actionSequence];
        
        [self.loadingLabel runAction: actionForever];
        
        id actionDelay = [CCDelayTime actionWithDuration: 2.0f];
        id actionCallFunc = [CCCallFunc actionWithTarget: self selector: @selector(gameSceneWithoutSound)];
        id actionSequenceLayer = [CCSequence actions: actionDelay, actionCallFunc, nil];
        
        [self runAction: actionSequenceLayer];

        
    }
    return self;
}

@end


















