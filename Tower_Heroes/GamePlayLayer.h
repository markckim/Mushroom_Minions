//
//  GamePlayLayer.h
//  
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@class EnemyMud;
@class ControlsLayer;
@class BackgroundLayer;
@class ControlsLayer;
@class Tower;
@class TowerControl;
@class BulletCast;
@class EnemyGenerator;
@class GameScene1;

@interface GamePlayLayer : GameLayer <GamePlayLayerDelegate /*, CCTargetedTouchDelegate*/>
{   
    CCSpriteBatchNode *gs1SpriteBatchNode;
    BackgroundLayer *backgroundLayer;
    EnemyMud *enemyMud;
    NSMutableArray *towerDelegateCollection;
    NSMutableArray *enemyCollection;
    
    NSMutableArray *effectsQueue;
    NSMutableArray *objectQueue;
    NSMutableArray *effectsToDelete;
    NSMutableArray *enemiesToDelete;
    NSMutableArray *bulletsToDelete;
    NSMutableArray *towersToDelete;
    ControlsLayer *controlsLayer;
    
    CGSize screenSize;
    float enemySpawnTimer;
    int countdownTimer;
    
    float powerButtonTimer;
    
    EnemyGenerator *enemyGenerator;
    
    NSMutableArray *towerPlacementSprites;
    
    BOOL initializeTalentButtonPriority;
    BOOL isMeditateActive;
    
    BulletCast *meditationRef;
    
}

@property (nonatomic, assign) float introDelay;
@property (nonatomic, assign) GameScene1 *gs1_reference;

@property (nonatomic, strong) CCSpriteBatchNode *gs1SpriteBatchNode;
@property (nonatomic, strong) EnemyMud *enemyMud;
@property (nonatomic, strong) NSMutableArray *towerDelegateCollection;
@property (nonatomic, strong) NSMutableArray *enemyCollection;
@property (nonatomic, strong) NSMutableArray *effectsQueue;
@property (nonatomic, strong) NSMutableArray *objectQueue;
@property (nonatomic, strong) NSMutableArray *effectsToDelete;
@property (nonatomic, strong) NSMutableArray *enemiesToDelete;
@property (nonatomic, strong) NSMutableArray *bulletsToDelete;
@property (nonatomic, strong) NSMutableArray *towersToDelete;
@property (nonatomic, assign) ControlsLayer *controlsLayer;
@property (nonatomic, assign) BackgroundLayer *backgroundLayer;

@property (nonatomic, assign) CGSize screenSize;
@property (nonatomic, assign) float enemySpawnTimer;
@property (nonatomic, assign) int countdownTimer;

@property (nonatomic, strong) EnemyGenerator *enemyGenerator;

@property (nonatomic, strong) NSMutableArray *towerPlacementSprites;

@property (nonatomic, assign) float powerButtonTimer;
@property (nonatomic, assign) BOOL isMeditateActive;
@property (nonatomic, assign) BulletCast *meditationRef;

- (void) createEffect: (CCNode *) effect;
- (void) queueEffectToDelete: (CCNode *) effect;

- (void) queueEnemyToDelete: (Enemy *) enemy;
- (void) queueBulletToDelete: (Bullet *) bullet;
- (void) queueTowerToDelete: (Tower *) tower;

- (void) initTowerPlacementPoints;

- (id) initWithLayer: (BackgroundLayer *) bg;

- (CGPoint) positionForTileCoord: (CGPoint) tileCoord withTileSize: (int) tS;

- (void) showDamageText: (int) damageTaken 
       andLabelPosition: (CGPoint) labelPosition
          andCritBullet: (BOOL) critBullet
               andColor: (ccColor3B) c;

- (void) showTextLabel: (NSString *) stringToShow 
      andLabelPosition: (CGPoint) labelPosition 
              andScale: (float) scaleValue
         andTimePeriod: (float) timePeriod
              andColor: (ccColor3B) colorToUse;

- (void) removeTextLabel: (CCLabelBMFont *) label;
- (void) removeBulletCast: (BulletCast *) bCast;

- (void) receiveCoins: (int) amountOfCoins;
- (void) receiveExperience: (int) amountOfExperience;

- (void) nextRoundLabel: (CCLabelBMFont *) label withString: (NSString *) textString;

- (void) updateTimer: (float *) timerPointer 
       withDeltaTime: (ccTime) deltaTime;

@end




















