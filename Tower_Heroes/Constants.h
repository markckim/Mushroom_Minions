//
//  Constants.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class Enemy;
@class Tower;
@class Bullet;
@class GameCharacter;
@class ControlsLayer;
@class TowerPlacement;

#define ARC4RANDOM_MAX 0x100000000
#define STARTING_LIVES 10
#define TOWER_PERSONAL_SPACE_RADIUS 20.0f
#define STARTING_EXPERIENCE_LIMIT 500
#define EXPERIENCE_EXPONENT 0.5f
#define kStartingCoins 125
#define AUDIO_MAX_WAITTIME 150
#define DELAY_BETWEEN_ROUNDS 5.0f
#define EXPERIENCE_MULTIPLIER 5.0f
#define MAX_LEVEL 25
#define SELL_VALUE_MULTIPLIER 0.75f
#define RANGE_UNIT 10
#define STARTING_TALENT_POINTS 1
#define STARTING_LAST_LEVEL_COMPLETED 0
#define HERO_NAME_1 @"Cassiel"
#define HERO_NAME_2 @"Severus"
#define HERO_NAME_3 @"Despina"

// for audio
#define SFX_NOTLOADED NO
#define SFX_LOADED YES

#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect: @#__VA_ARGS__]

#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect: __VA_ARGS__]

#define BACKGROUND_TRACK_MAIN_MENU @"MenuTheme.wav"

#define BACKGROUND_TRACK_SAND_THEME_1 @"SandTheme.wav"
#define BACKGROUND_TRACK_WATER_THEME_1 @"WaterTheme.wav"
#define BACKGROUND_TRACK_SNOW_THEME_1 @"SnowTheme.wav"

// tag values
#define kGroundTagValue 100
#define kEnemyTagValue 200
#define kEffectTagValue 300
#define kEffectsTagValue 300
#define kBulletTagValue 400
#define kBulletMeditationTagValue 401 // this is a temporary tag; it gets changed back to kBulletTagValue shortly after
#define kMineTagValue 450
#define kTowerTagValue 500
#define kControlTagValue 600

// z order for typical layers
#define kBackgroundZOrder 0
#define kImagesZOrder 1
#define kTitleZOrder 2
#define kButtonZOrder 3

// z order for game play layer
#define kGroundZOrder 0
#define kEnemyZOrder 1
#define kEffectZOrder 2
#define kEffectsZOrder 2
#define kTowerZOrder 3
#define kBulletZOrder 9999

// bullet standard trail timer
#define kBulletStandardTrailTimer 0.04f;
#define kBulletIceTrailTimer 0.04f;

// TOWER firing rate
#define kTowerStandardFiringRate 2.9f
#define kTowerIceFiringRate 2.2f
#define kTowerBombFiringRate 1.2f

// TOWER range
#define kTowerStandardTowerRange 95.0f
#define kTowerIceTowerRange 95.0f
#define kTowerBombTowerRange 95.0f

// TOWER accuracy effect
#define kTowerStandardBulletAccuracyEffect 0.70f
#define kTowerIceBulletAccuracyEffect 0.70f
#define kTowerBombBulletAccuracyEffect 0.70f

// TOWER damage effect
#define kTowerStandardBulletDamageEffect 1.0f
#define kTowerIceBulletDamageEffect 1.0f
#define kTowerBombBulletDamageEffect 1.0f

// TOWER base crit effect
#define kTowerStandardCritEffect 0.05f
#define kTowerIceCritEffect 0.05f
#define kTowerBombCritEffect 0.05f

// TOWER standard upgrade costs
#define kTowerStandardDamageUpgrade1 25
#define kTowerStandardDamageUpgrade2 40
#define kTowerStandardDamageUpgrade3 65
#define kTowerStandardAccuracyUpgrade1 10
#define kTowerStandardAccuracyUpgrade2 25
#define kTowerStandardAccuracyUpgrade3 45
#define kTowerStandardCritUpgrade1 20
#define kTowerStandardCritUpgrade2 35
#define kTowerStandardCritUpgrade3 55

// TOWER ice upgrade costs
#define kTowerIceDamageUpgrade1 20
#define kTowerIceDamageUpgrade2 30
#define kTowerIceDamageUpgrade3 45
#define kTowerIceAccuracyUpgrade1 10
#define kTowerIceAccuracyUpgrade2 20
#define kTowerIceAccuracyUpgrade3 35
#define kTowerIceCritUpgrade1 15
#define kTowerIceCritUpgrade2 25
#define kTowerIceCritUpgrade3 40

// TOWER bomb upgrade costs
#define kTowerBombDamageUpgrade1 25
#define kTowerBombDamageUpgrade2 40
#define kTowerBombDamageUpgrade3 65
#define kTowerBombAccuracyUpgrade1 10
#define kTowerBombAccuracyUpgrade2 25
#define kTowerBombAccuracyUpgrade3 45
#define kTowerBombCritUpgrade1 20
#define kTowerBombCritUpgrade2 35
#define kTowerBombCritUpgrade3 55

// TOWER cost
#define kTowerStandardCost 25
#define kTowerIceCost 25
#define kTowerBombCost 35

// BULLET damage
#define kBulletStandardDamage 4.0f
#define kBulletIceDamage 3.0f
#define kBulletBombDamage 4.0f

// BULLET velocity
#define kBulletStandardVelocity 300.0f
#define kBulletIceVelocity 180.0f
#define kBulletBombVelocity 200.0f

// EFFECT timer
#define kBombEffectTimer 0.25f
#define kPoisonedEffectTimer 0.25f
#define kFrozenEffectTimer 10.0f

// EFFECT velocity
#define kVelocityEffectOnFire 0.7f
#define kVelocityEffectPoisoned 0.7f
#define kVelocityEffectFrozen 0.7f
#define kBaseVelocityEffectSlow 0.6f

// ENEMY health
#define kEnemyMudHealth 100.0f
#define kEnemyDreadlingHealth 60.0f
#define kEnemyMinionHealth 50.0f
#define kEnemyPhibHealth 240.0f
#define kEnemyCritlingHealth 140.0f
#define kEnemyPinkiHealth 40.0f
#define kEnemyTarlingHealth 100.0f

// ENEMY armor
#define kEnemyMudArmorValue 0.0f
#define kEnemyDreadlingArmorValue 2.0f
#define kEnemyMinionArmorValue 4.0f
#define kEnemyPhibArmorValue 1.0f
#define kEnemyCritlingArmorValue 2.0f
#define kEnemyPinkiArmorValue 5.0f
#define kEnemyTarlingArmorValue 4.0f

// ENEMY velocity
#define kEnemyMudNormalVelocity 22.0f
#define kEnemyDreadlingNormalVelocity 28.0f
#define kEnemyMinionNormalVelocity 18.0f
#define kEnemyPhibNormalVelocity 15.0f
#define kEnemyCritlingNormalVelocity 26.0f
#define kEnemyPinkiNormalVelocity 35.0f
#define kEnemyTarlingNormalVelocity 18.0f

// ENEMY coin values
#define kEnemyMudCoinValue 2
#define kEnemyDreadlingCoinValue 3
#define kEnemyMinionCoinValue 4
#define kEnemyPhibCoinValue 4
#define kEnemyCritlingCoinValue 3
#define kEnemyPinkiCoinValue 3
#define kEnemyTarlingCoinValue 4

// CHARACTER static powers
#define ACCURACY_STATIC_POWER 0.05f
#define RANGE_STATIC_POWER 20.0f

// CHARACTER power durations
#define kOverclockDuration 20.0f
#define kLongshotDuration 30.0f
#define kMineDuration 20.0f
#define kBlizzardDuration 0.75f
#define kPoisonDuration 2.0f // duration of time between poison damage
#define kPoisonCastDuration 0.75f
#define kSmiteDuration 0.75f
#define kRageDuration 20.0f // duration of rage CHANGED to 20 sec
#define kSlowDuration 0.75f
#define kMeditationDuration 7.0f

#define kBasePoisonDamage 3.0f
#define kMineDamage 100.0f
#define kBaseSmiteDamage 80.0f

// power cool downs
#define kPowerOneDuration 10.0f
#define kPowerTwoDuration 10.0f
#define kPowerThreeDuration 15.0f

// CHARACTER power effects
#define kRageEffect 0.2f // increases crit effect by 20%
#define kLongshotEffect 2.0f // increases tower range by 2x
#define kOverclockEffect 1.4f // increases firing rate by 40%
#define kFocusedFireEffect 0.1f // increases spell crit effect by 10% for each talent point in it
#define kImprovedSmiteEffect 0.1f // increases smite damage by 10% for each talent point in it
#define kSlowStatusDuration 7.0f // slow lasts for 7 seconds
#define kSlowEffect 0.05f // increases slow effect by 5% for each talent point in it
#define kDeepFreezeEffect 0.05f // increases freeze effect by 5% for each talent point in it
#define kMeditationEffect 0.4f // increases critical strike in meditate area by 40%
#define kProcEffect 1.5f // increases firing rate by 50%; stacks with any other effects
#define kProcEffectBulletCount 3 // when proc activates, 3 bullets will be affected by the proc before it de-activates
#define kProcEffectTimer 3.0f // if 3 seconds pass before the 3 bullets are shot, proc de-activates
#define kNirvanaEffect 0.07f // 7% firing rate for each point in Nirvana
#define kMineEffect 1.0f // -1 second cooldown on mine for each point in Mine+

typedef enum {
    kGameStatePlaying,
    kGameStatePaused
} GameState;

typedef enum {
    kSceneNone,
    kPlayScene,
    kCreditScene,
    kOptionScene,
    kFileScene,
    kCharacterSelectionScene,
    kNameScene,
    kIntroScene,
    kLevelSelectionScene,
    kLoadingScene,
    kGameScene1,
    kPauseScene,
    kItemScene,
    kInfoScene,
    kTalentScene,
    kItemScene2,
    kInfoScene2,
    kTalentScene2,
    kCharacterSelectionScene2
} SceneType;

typedef enum {
    kDirectionNone, // 0
    kSouth, // 1
    kSouthWest, // 2
    kWest, // 3
    kNorthWest, // 4
    kNorth, // 5
    kNorthEast, // 6
    kEast, // 7
    kSouthEast // 8
} DirectionState;

typedef enum {
    kStateNone,
    kStateNormal,
    kStateFrozen,
    kStateOnFire,
    kStateExploding,
    kStateDead
} CharacterState;

typedef enum {
    kEffectNone,
    kEffectBomb,
    kEffectFrozen,
    kEffectPoisoned
} CharacterEffect;

typedef enum {
    kTypeNone,
    kTowerType,
    kEnemyType,
    kBulletType
} ObjectType;

typedef enum {
    kTowerNone,
    kTowerStandard,
    kTowerIce,
    kTowerBomb,
    kTowerMissile,
    kTowerSilence
} TowerType;

typedef enum {
    kBulletNone,
    kBulletStandard,
    kBulletIce,
    kBulletBomb,
    kBulletMine,
    kBulletCast
} BulletType;

typedef enum {
    kEnemyNone,
    kEnemyMud,
    kEnemyMinion,
    kEnemyDreadling,
    kEnemyPhib,
    kEnemyCritling,
    kEnemyPinki,
    kEnemyTarling
} EnemyType;

typedef enum {
    kStateReset,
    kStateTouched,
    kStateGrabbed,
    kStateDropped
} TouchState;

typedef enum {
    kCastButton,
    kMenuButton,
    kTowerMenuButton,
    kTowerButton
} ButtonType;

typedef enum {
    kBulletDamage,
    kBulletAccuracy,
    kCritValue,
    kTowerRemove,
    kSelectScene,
    kInsertYes,
    kInsertNo,
    kDeleteYes,
    kDeleteNo
} ModifierType;

typedef enum {
    kCastRage,
    kCastOverclock,
    kCastLongshot,
    kCastMeditation,
    kCastSlow,
    kCastBlizzard,
    kCastPoison,
    kCastSmite,
    kCastMine,
} CastType;

typedef enum {
    kDamageUpgrade,
    kAccuracyUpgrade,
    kCritUpgrade
} UpgradeType;

typedef enum {
    kAudioManagerUninitialized = 0,
    kAudioManagerFailed = 1,
    kAudioManagerInitializing = 2,
    kAudioManagerInitialized = 100,
    kAudioManagerLoading = 200,
    kAudioManagerReady = 300
} GameManagerSoundState;


@protocol GamePlayLayerDelegate

- (void) createTowerType: (TowerType) towerType 
     withInitialPosition: (CGPoint) initialPosition
   andPlacementReference: (TowerPlacement *) placementReference;

- (void) createEnemyType: (EnemyType) enemyType;

- (void) createBulletType: (BulletType) bulletType 
      withInitialPosition: (CGPoint) initialPosition
        andTargetPosition: (CGPoint) targetPosition
    andBulletDamageEffect: (float) bEffect 
        andAccuracyEffect: (float) aEffect
            andCritEffect: (float) cEffect
        andTowerReference: (Tower *) ref;

- (void) createBulletCastWithPosition: (CGPoint) position
                          andCastType: (CastType) cType;

- (void) queueEnemyToDelete: (Enemy *) enemy;

- (void) queueBulletToDelete: (Bullet *) bullet;

- (void) queueTowerToDelete: (Tower *) tower;

- (void) createEffect: (CCNode *) effect;

- (void) queueEffectToDelete: (CCNode *) effect;

- (void) showTextLabel: (NSString *) stringToShow 
      andLabelPosition: (CGPoint) labelPosition 
              andScale: (float) scaleValue
         andTimePeriod: (float) timePeriod
              andColor: (ccColor3B) colorToUse;

- (void) showDamageText: (int) damageTaken 
       andLabelPosition: (CGPoint) labelPosition
          andCritBullet: (BOOL) critBullet
               andColor: (ccColor3B) c;

- (void) receiveCoins: (int) amountOfCoins;
- (void) receiveExperience: (int) amountOfExperience;

- (void) nextRoundLabel: (CCLabelBMFont *) label withString: (NSString *) textString;

@property (nonatomic, assign) ControlsLayer *controlsLayer;
@property (nonatomic, strong) NSMutableArray *enemyCollection;

@end

@protocol TowerControlDelegate

@required

@property (nonatomic, assign) id controlsLayer;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) ButtonType buttonType;

- (CGRect) boundingBox;
- (void) selected;
- (void) unselected;
- (BOOL) touchLogic: (UITouch *) touch;
- (CGRect) rect;
- (BOOL) containsTouchLocation: (UITouch *) touch;

@optional

@property (nonatomic, assign) CastType castType;

- (void) castWithTouchLocation: (CGPoint) pointLocation;
- (void) unselectedAndRemoved;
- (void) showTowerPersonalSpace;
- (void) hideTowerPersonalSpace;
- (CGPoint) myPosition;

- (void) activateTowerStatusEffect: (CastType) cType;

@end




















