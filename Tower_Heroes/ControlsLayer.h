//
//  ControlsLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@class TowerControl;
@class TowerControlCastButton;
@class TowerControlTowerSelectButton;
@class TowerControlPowerSelectButton;
@class GamePlayLayer;
@class Tower;
@class TowerControlMenuSelectButton;
@class TowerControlMenuButton;
@class TowerPlacement;
@class GameScene1;

@interface ControlsLayer : GameLayer <CCTargetedTouchDelegate>
{
    // controls on the bottom right corner
    TowerControlCastButton *powerOneControl;
    TowerControlCastButton *powerTwoControl;
    TowerControlCastButton *powerThreeControl;
    TowerControlCastButton *powerFourControl;
    TowerControlCastButton *powerFiveControl;
    TowerControlCastButton *powerSixControl;
    CCArray *towerPowerControls;
    CCArray *towerOptionControls;
    TowerControlPowerSelectButton *powerSelectButton;
    
    // controls on the bottom left corner
    TowerControlCastButton *towerStandardControl;
    TowerControlCastButton *towerIceControl;
    TowerControlCastButton *towerBombControl;
    TowerControlMenuButton *towerTalentControl;
    TowerControlMenuButton *towerInfoControl;
    TowerControlMenuButton *towerItemControl;
    TowerControlPowerSelectButton *towerSelectButton;
    
    // controls for the tower personal menu
    TowerControlMenuButton *bulletDamageMenuButton;
    TowerControlMenuButton *bulletAccuracyMenuButton;
    TowerControlMenuButton *critValueMenuButton;
    TowerControlMenuButton *towerRemoveMenuButton;
    CCArray *towerMenuControls;
    
    // controls for inserting a new tower
    TowerControlMenuButton *insertYesMenuButton;
    TowerControlMenuButton *insertNoMenuButton;
    CCArray *insertTowerMenuConttrols;
    
    // controls for deleting a tower
    TowerControlMenuButton *deleteYesMenuButton;
    TowerControlMenuButton *deleteNoMenuButton;
    CCArray *deleteTowerMenuControls;
    
    // this is the "cast" sprite; this is what's visible as you drag your tower to place it
    CCSprite *cSprite;
    
    // this is the "selected" sprite; this it what's visible after you have placed your tower
    // and you are about to confirm whether to keep or delete the tower
    CCSprite *sSprite;
    
    CCSprite *lifeCounter;
    CCSprite *towerBounds;
    CCSprite *lifeIcon;
    
    CCLabelBMFont *lifeCounterLabel;
    
    CCMenu *talentButtonMenu;
    
    // collection of all the tower controls
    NSMutableArray *towerControls;
    
    id <TowerControlDelegate> selectedTowerControl;
    
    GamePlayLayer *gamePlayLayer;
    CCLabelTTF *enemyKillCounterLabel;
    
    CCLabelBMFont *experienceCountLabel;
    CCLabelBMFont *coinCount;
    int coins;
    
    CCLabelBMFont *powerOneCooldownLabel;
    CCLabelBMFont *powerTwoCooldownLabel;
    CCLabelBMFont *powerThreeCooldownLabel;
    CCLabelBMFont *insertTowerMenuLabel;
    
    TouchState touchState;
    BOOL isMenuInitialized;
    BOOL isInsertMenuInitialized;
    BOOL isDeleteMenuInitialized;
    BOOL isInsertTowerMenuActive;
    BOOL paused;
    
}

@property (nonatomic, strong) CCLabelBMFont *towerStandardCostLabel;
@property (nonatomic, strong) CCLabelBMFont *towerIceCostLabel;
@property (nonatomic, strong) CCLabelBMFont *towerBombCostLabel;

@property (nonatomic, strong) CCLabelBMFont *roundNumberLabel;

@property (nonatomic, strong) TowerControlCastButton *powerOneControl;
@property (nonatomic, strong) TowerControlCastButton *powerTwoControl;
@property (nonatomic, strong) TowerControlCastButton *powerThreeControl;
@property (nonatomic, strong) TowerControlCastButton *powerFourControl;
@property (nonatomic, strong) TowerControlCastButton *powerFiveControl;
@property (nonatomic, strong) TowerControlCastButton *powerSixControl;
@property (nonatomic, strong) CCArray *towerPowerControls;
@property (nonatomic, strong) CCArray *towerOptionControls;
@property (nonatomic, strong) TowerControlPowerSelectButton *powerSelectButton;

@property (nonatomic, strong) TowerControlCastButton *towerStandardControl;
@property (nonatomic, strong) TowerControlCastButton *towerIceControl;
@property (nonatomic, strong) TowerControlCastButton *towerBombControl;
@property (nonatomic, strong) TowerControlMenuButton *towerTalentControl;
@property (nonatomic, strong) TowerControlMenuButton *towerInfoControl;
@property (nonatomic, strong) TowerControlMenuButton *towerItemControl;
@property (nonatomic, strong) TowerControlPowerSelectButton *towerSelectButton;

@property (nonatomic, strong) TowerControlMenuButton *bulletDamageMenuButton;
@property (nonatomic, strong) TowerControlMenuButton *bulletAccuracyMenuButton;
@property (nonatomic, strong) TowerControlMenuButton *critValueMenuButton;
@property (nonatomic, strong) TowerControlMenuButton *towerRemoveMenuButton;
@property (nonatomic, strong) CCArray *towerMenuControls;

@property (nonatomic, strong) TowerControlMenuButton *insertYesMenuButton;
@property (nonatomic, strong) TowerControlMenuButton *insertNoMenuButton;
@property (nonatomic, strong) CCArray *insertTowerMenuControls;

@property (nonatomic, strong) TowerControlMenuButton *deleteYesMenuButton;
@property (nonatomic, strong) TowerControlMenuButton *deleteNoMenuButton;
@property (nonatomic, strong) CCArray *deleteTowerMenuControls;

@property (nonatomic, strong) CCSprite *cSprite;
@property (nonatomic, strong) CCSprite *sSprite;

@property (nonatomic, strong) CCMenu *talentButtonMenu;

@property (nonatomic, strong) CCSprite *lifeCounter;
@property (nonatomic, strong) CCSprite *towerBounds;
@property (nonatomic, strong) CCSprite *lifeIcon;

@property (nonatomic, strong) CCLabelBMFont *lifeCounterLabel;

@property (nonatomic, strong) NSMutableArray *towerControls;

@property (nonatomic, assign) id <TowerControlDelegate> selectedTowerControl;
@property (nonatomic, assign) GamePlayLayer *gamePlayLayer;
@property (nonatomic, strong) CCLabelTTF *enemyKillCounterLabel;
@property (nonatomic, strong) CCLabelBMFont *experienceCountLabel;
@property (nonatomic, strong) CCLabelBMFont *coinCount;
@property (nonatomic, assign) int coins;

@property (nonatomic, assign) TouchState touchState;
@property (nonatomic, assign) BOOL isMenuInitialized;
@property (nonatomic, assign) BOOL isInsertMenuInitialized;
@property (nonatomic, assign) BOOL isDeleteMenuInitialized;
@property (nonatomic, assign) BOOL isInsertTowerMenuActive;
@property (nonatomic, assign) BOOL paused;

@property (nonatomic, strong) CCLabelBMFont *powerOneCooldownLabel;
@property (nonatomic, strong) CCLabelBMFont *powerTwoCooldownLabel;
@property (nonatomic, strong) CCLabelBMFont *powerThreeCooldownLabel;
@property (nonatomic, strong) CCLabelBMFont *insertTowerMenuLabel;

@property (nonatomic, strong) CCLabelBMFont *heroLevelLabel;

- (void) updateEnemyKillCount;
- (void) initPowerSelectButtons;
- (void) initTowerSelectButtons;
- (void) initTowerPersonalMenuButtons;
- (void) initInsertTowerMenuButtons;
- (void) initDeleteTowerMenuButtons;
- (void) initTowerBounds;
- (void) insertEnemyKillCounter;
- (void) insertPauseAndResetButton;
- (void) initTalentButton;
- (void) initLabels;
- (void) initLifeIcon;
- (void) playScene;
- (void) checkToDisableTowerPurchasing;
- (void) checkToDisablePowers;

- (void) stopMusicAndGoToPlayScene;

- (void) insertTowerMenuAppear: (CGPoint) towerLocation;
- (void) insertTowerMenuAppear: (CGPoint) touchLocation
                 withTowerType: (TowerType) tType
         andPlacementReference: (TowerPlacement *) placementReference;
- (void) insertTowerMenuDisappear;
- (void) insertRoundNumberLabel;

- (void) loseSequence;
- (void) winSequence;

- (void) insertHeroLevelLabel;

/*
- (void) deleteTowerMenuAppear;
- (void) deleteTowerMenuDisappear;
*/

- (id) initWithLayer: (GamePlayLayer *) gp;

@end







