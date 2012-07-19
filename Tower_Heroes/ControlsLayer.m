//
//  ControlsLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ControlsLayer.h"
#import "GamePlayLayer.h"
#import "TowerControl.h"
#import "TowerControlCastButton.h"
#import "TowerControlTowerSelectButton.h"
#import "TowerControlPowerSelectButton.h"
#import "TowerControlMenuButton.h"
#import "Tower.h"
#import "BackgroundLayer.h"
#import "TowerPlacement.h"

@implementation ControlsLayer

@synthesize towerStandardCostLabel;
@synthesize towerIceCostLabel;
@synthesize towerBombCostLabel;

@synthesize heroLevelLabel;

@synthesize roundNumberLabel;

@synthesize cSprite;
@synthesize sSprite;
@synthesize powerOneControl;
@synthesize powerTwoControl;
@synthesize powerThreeControl;
@synthesize powerFourControl;
@synthesize powerFiveControl;
@synthesize powerSixControl;
@synthesize bulletDamageMenuButton;
@synthesize bulletAccuracyMenuButton;
@synthesize critValueMenuButton;
@synthesize towerRemoveMenuButton;
@synthesize towerSelectButton;
@synthesize powerSelectButton;
@synthesize towerStandardControl;
@synthesize towerIceControl;
@synthesize towerBombControl;
@synthesize selectedTowerControl;
@synthesize towerTalentControl;
@synthesize towerInfoControl;
@synthesize towerItemControl;
@synthesize towerControls;
@synthesize towerMenuControls;
@synthesize towerPowerControls;
@synthesize towerOptionControls;
@synthesize gamePlayLayer;
@synthesize isMenuInitialized;
@synthesize isInsertMenuInitialized;
@synthesize isDeleteMenuInitialized;
@synthesize enemyKillCounterLabel;
@synthesize paused;
@synthesize lifeCounter;
@synthesize towerBounds;
@synthesize isInsertTowerMenuActive;
@synthesize talentButtonMenu;
@synthesize experienceCountLabel;
@synthesize coinCount;
@synthesize coins;
@synthesize lifeIcon;
@synthesize lifeCounterLabel;

@synthesize insertYesMenuButton;
@synthesize insertNoMenuButton;
@synthesize insertTowerMenuControls;
@synthesize deleteYesMenuButton;
@synthesize deleteNoMenuButton;
@synthesize deleteTowerMenuControls;

@synthesize powerOneCooldownLabel;
@synthesize powerTwoCooldownLabel;
@synthesize powerThreeCooldownLabel;
@synthesize insertTowerMenuLabel;

@synthesize touchState;

- (void) dealloc {
        
    self.towerStandardCostLabel = nil;
    self.towerIceCostLabel = nil;
    self.towerBombCostLabel = nil;
    self.roundNumberLabel = nil;
    self.cSprite = nil;
    self.sSprite = nil;
    self.powerOneControl = nil;
    self.powerTwoControl = nil;
    self.powerThreeControl = nil;
    self.powerFourControl = nil;
    self.powerFiveControl = nil;
    self.powerSixControl = nil;
    self.bulletDamageMenuButton = nil;
    self.bulletAccuracyMenuButton = nil;
    self.critValueMenuButton = nil;
    self.towerRemoveMenuButton = nil;
    self.towerSelectButton = nil;
    self.powerSelectButton = nil;
    self.towerStandardControl = nil;
    self.towerIceControl = nil;
    self.towerBombControl = nil;
    self.selectedTowerControl = nil;
    self.gamePlayLayer = nil;
    self.towerControls = nil;
    self.towerMenuControls = nil;
    self.towerPowerControls = nil;
    self.towerOptionControls = nil;
    self.towerTalentControl = nil;
    self.towerInfoControl = nil;
    self.towerItemControl = nil;
    self.enemyKillCounterLabel = nil;
    self.lifeCounter = nil;
    self.insertYesMenuButton = nil;
    self.insertNoMenuButton = nil;
    self.insertTowerMenuControls = nil;
    self.deleteYesMenuButton = nil;
    self.deleteNoMenuButton = nil;
    self.deleteTowerMenuControls = nil;
    self.towerBounds = nil;
    self.talentButtonMenu = nil;
    self.lifeIcon = nil;
    self.experienceCountLabel = nil;
    self.coinCount = nil;
    self.powerOneCooldownLabel = nil;
    self.powerTwoCooldownLabel = nil;
    self.powerThreeCooldownLabel = nil;
    self.lifeCounterLabel = nil;
    
    self.heroLevelLabel = nil;
    
    [super dealloc];
}

- (void) onEnter {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate: self priority: 9999 swallowsTouches: YES];
    [super onEnter];
}

- (void) onExit {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate: self];
    [super onExit];
}


- (void) playScene {
    [GameManager sharedGameManager].numberOfEnemiesKilled = 0;
    [[GameManager sharedGameManager] runSceneWithID: kPlayScene];
}

- (void) initTowerSelectButtons {
    
    // this method is no longer used
    
    NSString *tower1 = [NSString stringWithFormat: @"towerstandard_icon_1.png"];
    NSString *tower2 = [NSString stringWithFormat: @"towerice_icon_1.png"];
    NSString *tower3 = [NSString stringWithFormat: @"towerbomb_icon_1.png"];
    
    NSString *option1 = [NSString stringWithFormat: @"talent_button_1.png"];
    NSString *option2 = [NSString stringWithFormat: @"info_button_1.png"];
    NSString *option3 = [NSString stringWithFormat: @"item_button_1.png"];
        
    self.towerStandardControl = [TowerControlCastButton buttonWithSpriteName: tower1 
                                                           andDragSpriteName: tower1
                                                               andObjectType: kTowerType 
                                                                andTowerType: kTowerStandard];
    self.towerIceControl = [TowerControlCastButton buttonWithSpriteName: tower2 
                                                      andDragSpriteName: tower2
                                                          andObjectType: kTowerType 
                                                           andTowerType: kTowerIce];
    self.towerBombControl = [TowerControlCastButton buttonWithSpriteName: tower3
                                                       andDragSpriteName: tower3
                                                           andObjectType: kTowerType 
                                                            andTowerType: kTowerBomb];
    
     self.towerTalentControl = [TowerControlMenuButton buttonWithSpriteName: option1
                                                            andModifierType: kSelectScene
                                                               andSceneType: kItemScene];
     self.towerInfoControl = [TowerControlMenuButton buttonWithSpriteName: option2
                                                          andModifierType: kSelectScene
                                                             andSceneType: kInfoScene];
     self.towerItemControl = [TowerControlMenuButton buttonWithSpriteName: option3
                                                          andModifierType: kSelectScene
                                                             andSceneType: kTalentScene];
    
    NSArray *tmpArrayP = [NSArray arrayWithObjects: towerStandardControl, 
                          towerIceControl, towerBombControl, nil];
    NSArray *tmpArrayO = [NSArray arrayWithObjects: towerTalentControl, 
                          towerInfoControl, towerItemControl, nil];
    self.towerPowerControls = [CCArray arrayWithNSArray: tmpArrayP];
    self.towerOptionControls = [CCArray arrayWithNSArray: tmpArrayO];    
    
    // eventually, create a new factory method for TowerControlPowerSelectButton
    // so it's less confusing; these aren't actually the "power" and "option" controls
    self.towerSelectButton = [TowerControlPowerSelectButton buttonWithSpriteName: @"tower_select_button_1.png"
                                                           andListOfPowerButtons: towerPowerControls
                                                          andListOfOptionButtons: towerOptionControls];

    self.towerStandardControl.controlsLayer = self;
    self.towerIceControl.controlsLayer = self;
    self.towerBombControl.controlsLayer = self;
    self.towerTalentControl.controlsLayer = self;
    self.towerInfoControl.controlsLayer = self;
    self.towerItemControl.controlsLayer = self;
    self.towerSelectButton.controlsLayer = self;
    
    float cornerPadding = 7.0f; // in points
    float radiusPadding = 12.0f; // in points
    float radius = self.towerSelectButton.contentSize.width/2 + radiusPadding + 
    self.towerStandardControl.contentSize.width/2;
    CGPoint s1 = ccp(cornerPadding + self.towerSelectButton.contentSize.width/2,
                     cornerPadding + self.towerSelectButton.contentSize.height/2);
    CGPoint p1 = ccp(s1.x + radius, s1.y);
    CGPoint p2 = ccp(s1.x + radius*1.41/2.0f, s1.y + radius*1.41/2.0f);
    CGPoint p3 = ccp(s1.x, s1.y + radius);
    
    self.towerStandardControl.position = p1;
    self.towerIceControl.position = p2;
    self.towerBombControl.position = p3;
    self.towerTalentControl.position = p1;
    self.towerInfoControl.position = p2;
    self.towerItemControl.position = p3;
    self.towerSelectButton.position = s1;
    
}

- (void) checkToDisablePowers {
        
    if (self.powerFourControl.disabledSprite == nil) {
        
        self.powerFourControl.disabledSprite = [CCSprite node];
        NSString *dSpriteName = self.powerFourControl.disabledSpriteName;
        
        self.powerFourControl.disabledSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                            spriteFrameByName: dSpriteName];
        self.powerFourControl.disabledSprite.position = self.powerFourControl.position;
        self.powerFourControl.disabledSprite.zOrder = self.powerFourControl.zOrder + 1;
        [self addChild: self.powerFourControl.disabledSprite];
        
    }
    
    if (self.powerFiveControl.disabledSprite == nil) {
        
        self.powerFiveControl.disabledSprite = [CCSprite node];
        NSString *dSpriteName = self.powerFiveControl.disabledSpriteName;
        
        self.powerFiveControl.disabledSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                            spriteFrameByName: dSpriteName];
        self.powerFiveControl.disabledSprite.position = self.powerFiveControl.position;
        self.powerFiveControl.disabledSprite.zOrder = self.powerFiveControl.zOrder + 1;
        [self addChild: self.powerFiveControl.disabledSprite];
        
    }
    
    if (self.powerSixControl.disabledSprite == nil) {
        self.powerSixControl.disabledSprite = [CCSprite node];
        NSString *dSpriteName = self.powerSixControl.disabledSpriteName;
        
        self.powerSixControl.disabledSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                              spriteFrameByName: dSpriteName];
        self.powerSixControl.disabledSprite.position = self.powerSixControl.position;
        self.powerSixControl.disabledSprite.zOrder = self.powerSixControl.zOrder + 1;
        [self addChild: self.powerSixControl.disabledSprite];
        
    }
    
    if (self.powerOneCooldownLabel == nil) {
        
        NSString *s = [NSString stringWithFormat: @"%.f", self.gamePlayLayer.powerButtonTimer];
        
        self.powerOneCooldownLabel = [CCLabelBMFont labelWithString: s 
                                                            fntFile: @"MushroomTextSmall.fnt"];
        self.powerTwoCooldownLabel = [CCLabelBMFont labelWithString: s 
                                                            fntFile: @"MushroomTextSmall.fnt"];
        self.powerThreeCooldownLabel = [CCLabelBMFont labelWithString: s 
                                                              fntFile: @"MushroomTextSmall.fnt"];
        
        self.powerOneCooldownLabel.zOrder = self.powerFourControl.zOrder + 2;
        self.powerTwoCooldownLabel.zOrder = self.powerFiveControl.zOrder + 2;
        self.powerThreeCooldownLabel.zOrder = self.powerSixControl.zOrder + 2;
        
        self.powerOneCooldownLabel.position = self.powerFourControl.position;
        self.powerTwoCooldownLabel.position = self.powerFiveControl.position;
        self.powerThreeCooldownLabel.position = self.powerSixControl.position;
        
        self.powerOneCooldownLabel.scale = 1.0f;
        self.powerTwoCooldownLabel.scale = 1.0f;
        self.powerThreeCooldownLabel.scale = 1.0f;

        [self addChild: self.powerOneCooldownLabel];
        [self addChild: self.powerTwoCooldownLabel];
        [self addChild: self.powerThreeCooldownLabel];
    }
    
    self.powerOneCooldownLabel.visible = NO;
    self.powerTwoCooldownLabel.visible = NO;
    self.powerThreeCooldownLabel.visible = NO;
    
    self.powerFourControl.disabledSprite.visible = NO;
    self.powerFiveControl.disabledSprite.visible = NO;
    self.powerSixControl.disabledSprite.visible = NO;

    // need to modify this a bit later
    if (self.gamePlayLayer.powerButtonTimer > 0) {
        self.powerFourControl.disabledSprite.visible = YES;
        self.powerFiveControl.disabledSprite.visible = YES;
        self.powerSixControl.disabledSprite.visible = YES;
        
        self.powerOneCooldownLabel.visible = YES;
        self.powerTwoCooldownLabel.visible = YES;
        self.powerThreeCooldownLabel.visible = YES;
    }
    
}

- (void) checkToDisableTowerPurchasing {
    
    if (self.powerOneControl.disabledSprite == nil) {
        
        self.powerOneControl.disabledSprite = [CCSprite node];
        NSString *dSpriteName = self.powerOneControl.disabledSpriteName;
        
        self.powerOneControl.disabledSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                            spriteFrameByName: dSpriteName];
        self.powerOneControl.disabledSprite.position = self.powerOneControl.position;
        self.powerOneControl.disabledSprite.zOrder = self.powerOneControl.zOrder + 1;
        [self addChild: self.powerOneControl.disabledSprite];
        
    }
    
    if (self.powerTwoControl.disabledSprite == nil) {
        
        self.powerTwoControl.disabledSprite = [CCSprite node];
        NSString *dSpriteName = self.powerTwoControl.disabledSpriteName;
        
        self.powerTwoControl.disabledSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                            spriteFrameByName: dSpriteName];
        self.powerTwoControl.disabledSprite.position = self.powerTwoControl.position;
        self.powerTwoControl.disabledSprite.zOrder = self.powerTwoControl.zOrder + 1;
        [self addChild: self.powerTwoControl.disabledSprite];
        
    }

    if (self.powerThreeControl.disabledSprite == nil) {
        self.powerThreeControl.disabledSprite = [CCSprite node];
        NSString *dSpriteName = self.powerThreeControl.disabledSpriteName;
        
        self.powerThreeControl.disabledSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                              spriteFrameByName: dSpriteName];
        self.powerThreeControl.disabledSprite.position = self.powerThreeControl.position;
        self.powerThreeControl.disabledSprite.zOrder = self.powerThreeControl.zOrder + 1;
        [self addChild: self.powerThreeControl.disabledSprite];
        
    }
    
    self.powerOneControl.disabledSprite.visible = NO;
    self.powerTwoControl.disabledSprite.visible = NO;
    self.powerThreeControl.disabledSprite.visible = NO;

        
    if (self.coins < kTowerStandardCost) {
        
        self.powerOneControl.disabledSprite.visible = YES;
        
    }
    
    if (self.coins < kTowerIceCost) {
                
        self.powerTwoControl.disabledSprite.visible = YES;

    }
    
    if (self.coins < kTowerBombCost) {
                
        self.powerThreeControl.disabledSprite.visible = YES;
    }
    
}


- (void) initPowerSelectButtons {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    NSString *tower1 = [NSString stringWithFormat: @"towerstandard_icon_1.png"];
    NSString *selectedTower1 = [NSString stringWithFormat: @"towerstandard_icon_2.png"];
    NSString *tower2 = [NSString stringWithFormat: @"towerice_icon_1.png"];
    NSString *selectedTower2 = [NSString stringWithFormat: @"towerice_icon_2.png"];
    NSString *tower3 = [NSString stringWithFormat: @"towerbomb_icon_1.png"];
    NSString *selectedTower3 = [NSString stringWithFormat: @"towerbomb_icon_2.png"];

    NSString *actualTower1 = [NSString stringWithFormat: @"TowerStandard_1.png"];
    NSString *actualTower2 = [NSString stringWithFormat: @"TowerIce_1.png"];
    NSString *actualTower3 = [NSString stringWithFormat: @"TowerBomb_1.png"];
    
    NSString *power1;
    NSString *selectedPower1;
    CastType castType1;
    NSString *power2;
    NSString *selectedPower2;
    CastType castType2;
    NSString *power3;
    NSString *selectedPower3;
    CastType castType3;
        
    if ([GameManager sharedGameManager].selectedHero.characterID == 1) {
        power1 = [NSString stringWithFormat: @"c1_p1_icon_1.png"];
        selectedPower1 = [NSString stringWithFormat: @"c1_p1_icon_2.png"];
        castType1 = kCastOverclock;
        power2 = [NSString stringWithFormat: @"c1_p2_icon_1.png"];
        selectedPower2 = [NSString stringWithFormat: @"c1_p2_icon_2.png"];
        castType2 = kCastLongshot;
        power3 = [NSString stringWithFormat: @"c1_p3_icon_1.png"];
        selectedPower3 = [NSString stringWithFormat: @"c1_p3_icon_2.png"];
        castType3 = kCastMine;
        
    } else if ([GameManager sharedGameManager].selectedHero.characterID == 2) {
        power1 = [NSString stringWithFormat: @"c2_p1_icon_1.png"];
        selectedPower1 = [NSString stringWithFormat: @"c2_p1_icon_2.png"];
        castType1 = kCastBlizzard;
        power2 = [NSString stringWithFormat: @"c2_p2_icon_1.png"];
        selectedPower2 = [NSString stringWithFormat: @"c2_p2_icon_2.png"];
        castType2 = kCastPoison;
        power3 = [NSString stringWithFormat: @"c2_p3_icon_1.png"];
        selectedPower3 = [NSString stringWithFormat: @"c2_p3_icon_2.png"];
        castType3 = kCastSmite;

    } else if ([GameManager sharedGameManager].selectedHero.characterID == 3) {
        power1 = [NSString stringWithFormat: @"c3_p1_icon_1.png"];
        selectedPower1 = [NSString stringWithFormat: @"c3_p1_icon_2.png"];
        castType1 = kCastRage;
        power2 = [NSString stringWithFormat: @"c3_p2_icon_1.png"];
        selectedPower2 = [NSString stringWithFormat: @"c3_p2_icon_2.png"];
        castType2 = kCastSlow;
        power3 = [NSString stringWithFormat: @"c3_p3_icon_1.png"];
        selectedPower3 = [NSString stringWithFormat: @"c3_p3_icon_2.png"];
        castType3 = kCastMeditation;
    }
    
    // need to figure out if/how to change the drag sprite
    self.powerOneControl = [TowerControlCastButton buttonWithSpriteName: tower1 
                                                      andDragSpriteName: actualTower1
                                                          andObjectType: kTowerType 
                                                           andTowerType: kTowerStandard];
    self.powerOneControl.selectedSprite = selectedTower1;
    self.powerOneControl.disabledSpriteName = [NSString stringWithFormat: @"tower_icon_disabled_1.png"];
    
    self.powerTwoControl = [TowerControlCastButton buttonWithSpriteName: tower2 
                                                      andDragSpriteName: actualTower2
                                                          andObjectType: kTowerType 
                                                           andTowerType: kTowerIce];
    self.powerTwoControl.selectedSprite = selectedTower2;
    self.powerTwoControl.disabledSpriteName = [NSString stringWithFormat: @"tower_icon_disabled_1.png"];

    
    self.powerThreeControl = [TowerControlCastButton buttonWithSpriteName: tower3 
                                                        andDragSpriteName: actualTower3
                                                            andObjectType: kTowerType 
                                                             andTowerType: kTowerBomb];
    self.powerThreeControl.selectedSprite = selectedTower3;
    self.powerThreeControl.disabledSpriteName = [NSString stringWithFormat: @"tower_icon_disabled_1.png"];

    
    self.powerFourControl = [TowerControlCastButton buttonWithSpriteName: power1
                                                       andDragSpriteName: power1
                                                           andObjectType: kBulletType
                                                            andBulletType: kBulletCast
                                                             andCastType: castType1];
    self.powerFourControl.selectedSprite = selectedPower1;
    self.powerFourControl.disabledSpriteName = [NSString stringWithFormat: @"tower_icon_disabled_2.png"];
    self.powerFourControl.delegate = self.gamePlayLayer;

    
    self.powerFiveControl = [TowerControlCastButton buttonWithSpriteName: power2
                                                       andDragSpriteName: power2
                                                           andObjectType: kBulletType
                                                            andBulletType: kBulletCast
                                                             andCastType: castType2];
    self.powerFiveControl.selectedSprite = selectedPower2;
    self.powerFiveControl.disabledSpriteName = [NSString stringWithFormat: @"tower_icon_disabled_2.png"];
    self.powerFiveControl.delegate = self.gamePlayLayer;

    
    self.powerSixControl = [TowerControlCastButton buttonWithSpriteName: power3
                                                      andDragSpriteName: power3
                                                          andObjectType: kBulletType
                                                           andBulletType: kBulletCast
                                                            andCastType: castType3];
    self.powerSixControl.selectedSprite = selectedPower3;
    self.powerSixControl.disabledSpriteName = [NSString stringWithFormat: @"tower_icon_disabled_2.png"];
    self.powerSixControl.delegate = self.gamePlayLayer;
    
    // these are the TOWERS
    NSArray *tmpArrayP = [NSArray arrayWithObjects: powerOneControl, 
                          powerTwoControl, powerThreeControl, nil];
    
    // these are the POWERS
    NSArray *tmpArrayO = [NSArray arrayWithObjects: powerFourControl, 
                          powerFiveControl, powerSixControl, nil];
    
    // these are the TOWERS
    self.towerPowerControls = [CCArray arrayWithNSArray: tmpArrayP];
    
    // these are the POWERS
    self.towerOptionControls = [CCArray arrayWithNSArray: tmpArrayO];    
    
    
    self.powerSelectButton = [TowerControlPowerSelectButton buttonWithSpriteName: @"power_select_button_1.png"
                                                           andListOfPowerButtons: towerPowerControls
                                                          andListOfOptionButtons: towerOptionControls];
    
    self.powerOneControl.controlsLayer = self;
    self.powerTwoControl.controlsLayer = self;
    self.powerThreeControl.controlsLayer = self;
    self.powerFourControl.controlsLayer = self;
    self.powerFiveControl.controlsLayer = self;
    self.powerSixControl.controlsLayer = self;
    self.powerSelectButton.controlsLayer = self;
    
    float cornerPadding = 6.0f; // in points
    float radiusPadding = 9.0f; // in points
    float radius = self.powerSelectButton.contentSize.width/2 + radiusPadding + 
                    self.powerOneControl.contentSize.width/2;
    CGPoint s1 = ccp(screenSize.width - cornerPadding - self.powerSelectButton.contentSize.width/2,
                     cornerPadding + self.powerSelectButton.contentSize.height/2);
    CGPoint p1 = ccp(s1.x - radius, s1.y);
    CGPoint p2 = ccp(s1.x - radius*1.41/2.0f, s1.y + radius*1.41/2.0f);
    CGPoint p3 = ccp(s1.x, s1.y + radius);
    
    self.powerOneControl.position = p1;
    self.powerTwoControl.position = p2;
    self.powerThreeControl.position = p3;
    self.powerFourControl.position = p1;
    self.powerFiveControl.position = p2;
    self.powerSixControl.position = p3;
    self.powerSelectButton.position = s1;
    
    // initializing the tower cost labels here
    NSString *towerStandardCostString = [NSString stringWithFormat: @"%d", kTowerStandardCost];
    NSString *towerIceCostString = [NSString stringWithFormat: @"%d", kTowerIceCost];
    NSString *towerBombCostString = [NSString stringWithFormat: @"%d", kTowerBombCost];
    
    self.towerStandardCostLabel = [CCLabelBMFont labelWithString: towerStandardCostString fntFile: @"MushroomTextSmall.fnt"];
    self.towerIceCostLabel = [CCLabelBMFont labelWithString: towerIceCostString fntFile: @"MushroomTextSmall.fnt"];
    self.towerBombCostLabel = [CCLabelBMFont labelWithString: towerBombCostString fntFile: @"MushroomTextSmall.fnt"];
    
    self.towerStandardCostLabel.scale = 0.9f;
    self.towerIceCostLabel.scale = 0.9f;
    self.towerBombCostLabel.scale = 0.9f;
    
    self.towerStandardCostLabel.color = ccYELLOW;
    self.towerIceCostLabel.color = ccYELLOW;
    self.towerBombCostLabel.color = ccYELLOW;

    self.towerStandardCostLabel.zOrder = 99999;
    self.towerIceCostLabel.zOrder = self.towerStandardCostLabel.zOrder;
    self.towerBombCostLabel.zOrder = self.towerStandardCostLabel.zOrder;
    
    float offsetCostLabelY = 14.0f;
    
    self.towerStandardCostLabel.position = ccp(p1.x, p1.y + offsetCostLabelY);
    self.towerIceCostLabel.position = ccp(p2.x, p2.y + offsetCostLabelY);
    self.towerBombCostLabel.position = ccp(p3.x, p3.y + offsetCostLabelY);
    
    self.towerStandardCostLabel.visible = NO;
    self.towerIceCostLabel.visible = NO;
    self.towerBombCostLabel.visible = NO;
    
    [self addChild: towerStandardCostLabel];
    [self addChild: towerIceCostLabel];
    [self addChild: towerBombCostLabel];


}

- (void) initTowerPersonalMenuButtons {
    
    NSString *bulletDamage = [NSString stringWithFormat: @"tower_damage_icon_0.png"];
    NSString *bulletAccuracy = [NSString stringWithFormat: @"tower_accuracy_icon_0.png"];
    NSString *critValue = [NSString stringWithFormat: @"tower_crit_icon_0.png"];
    NSString *towerRemove = [NSString stringWithFormat: @"tower_remove_icon_1.png"];
    
    // tower menu buttons
    self.bulletDamageMenuButton = [TowerControlMenuButton buttonWithSpriteName: bulletDamage 
                                                               andModifierType: kBulletDamage];    
    self.bulletAccuracyMenuButton = [TowerControlMenuButton buttonWithSpriteName: bulletAccuracy 
                                                                 andModifierType: kBulletAccuracy];    
    self.critValueMenuButton = [TowerControlMenuButton buttonWithSpriteName: critValue 
                                                            andModifierType: kCritValue];    
    self.towerRemoveMenuButton = [TowerControlMenuButton buttonWithSpriteName: towerRemove 
                                                              andModifierType: kTowerRemove];
    self.bulletDamageMenuButton.controlsLayer = self;        
    self.bulletAccuracyMenuButton.controlsLayer = self;
    self.critValueMenuButton.controlsLayer = self;
    self.towerRemoveMenuButton.controlsLayer = self;
    
    // array for menu select button
    NSArray *tmpArrayM = [NSArray arrayWithObjects: bulletDamageMenuButton, bulletAccuracyMenuButton, 
                          critValueMenuButton, towerRemoveMenuButton, nil];
    self.towerMenuControls = [CCArray arrayWithNSArray: tmpArrayM];    
}

- (void) stopMusicAndGoToPlayScene {
    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [self playScene];
    
}

- (void) insertPauseAndResetButton {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    
    CCSprite *tmpSprite1 = [CCSprite node];
    CCSprite *tmpSprite2 = [CCSprite node];
    tmpSprite1.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: @"pause_button_1.png"];
    tmpSprite2.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                               spriteFrameByName: @"pause_button_2.png"];
    
    float cornerPadding = 5.0f;
    
    CCMenuItemSprite *pauseButton = [CCMenuItemSprite itemWithNormalSprite: tmpSprite1
                                                            selectedSprite: tmpSprite2
                                                                    target: self
                                                                  selector: @selector(pauseScene)];
        
    CCMenu *pauseAndResetMenu = [CCMenu menuWithItems: pauseButton, nil];
    
    float otherPadding = 5.0f;
    
    [pauseAndResetMenu alignItemsVerticallyWithPadding: screenSize.height*0.02f];
    pauseAndResetMenu.position = ccp(cornerPadding + tmpSprite1.contentSize.width/2 + otherPadding, 
                                     screenSize.height - cornerPadding - tmpSprite1.contentSize.height/2 - screenSize.height*0.02f/2.0f);
    
    [self addChild: pauseAndResetMenu
                 z: 1
               tag: kControlTagValue]; 
}

- (void) insertEnemyKillCounter {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.enemyKillCounterLabel = [CCLabelTTF labelWithString: @"Enemy Kill Count: 0"
                                                  dimensions: CGSizeMake(140,25) 
                                                   alignment: UITextAlignmentLeft
                                                    fontName: @"Helvetica"
                                                    fontSize: 14];
    self.enemyKillCounterLabel.position = ccp(screenSize.width*17/20, screenSize.height*19/20);
    
    [self addChild: enemyKillCounterLabel
                 z: 1
               tag: kControlTagValue];

}

- (void) updateEnemyKillCount {
    NSString *kills = [NSString stringWithFormat: @"Enemy Kill Count: %d",
                       [[GameManager sharedGameManager] numberOfEnemiesKilled]];
    self.enemyKillCounterLabel.string = kills;
}

- (void) initTalentButton {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];    
    
    CCSprite *tmpSprite = [CCSprite node];
    tmpSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                              spriteFrameByName: @"talent_button_1.png"];
    
    CCSprite *tmpSprite2 = [CCSprite node];
    tmpSprite2.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                               spriteFrameByName: @"talent_button_2.png"];

    CCMenuItemSprite *talentItem = [CCMenuItemSprite itemWithNormalSprite: tmpSprite
                                                           selectedSprite: tmpSprite2
                                                                   target: self
                                                                 selector: @selector(pushTalentScene)];
        
    self.talentButtonMenu = [CCMenu menuWithItems: talentItem, nil];
    
    float paddingX = 104.0f;
    float paddingY = 22.0f;
    
    talentButtonMenu.position = ccp(screenSize.width - paddingX, screenSize.height - paddingY);
    
    [self addChild: talentButtonMenu
                 z: 100
               tag: kControlTagValue];
}

- (void) initInsertTowerMenuButtons {
    NSString *yesIcon = [NSString stringWithFormat: @"tower_yes_icon_1.png"];
    NSString *noIcon = [NSString stringWithFormat: @"tower_no_icon_1.png"];
    
    self.insertYesMenuButton = [TowerControlMenuButton buttonWithSpriteName: yesIcon
                                                            andModifierType: kInsertYes];
    self.insertNoMenuButton = [TowerControlMenuButton buttonWithSpriteName: noIcon
                                                           andModifierType: kInsertNo];
    
    self.insertYesMenuButton.controlsLayer = self;
    self.insertNoMenuButton.controlsLayer = self;
        
    // array for insert tower menu buttons
    NSArray *tmpArrayM = [NSArray arrayWithObjects: insertYesMenuButton, insertNoMenuButton, nil];
    
    self.insertTowerMenuControls = [CCArray arrayWithNSArray: tmpArrayM];    
}

// i may not need this method
- (void) initDeleteTowerMenuButtons {
    NSString *yesIcon = [NSString stringWithFormat: @"tower_yes_icon_1.png"];
    NSString *noIcon = [NSString stringWithFormat: @"tower_no_icon_1.png"];
    
    self.deleteYesMenuButton = [TowerControlMenuButton buttonWithSpriteName: yesIcon
                                                            andModifierType: kDeleteYes];
    self.deleteNoMenuButton = [TowerControlMenuButton buttonWithSpriteName: noIcon
                                                           andModifierType: kDeleteNo];
    
    self.deleteYesMenuButton.controlsLayer = self;
    self.deleteNoMenuButton.controlsLayer = self;
    
    // array for insert tower menu buttons
    NSArray *tmpArrayM = [NSArray arrayWithObjects: deleteYesMenuButton, deleteNoMenuButton, nil];
    
    self.deleteTowerMenuControls = [CCArray arrayWithNSArray: tmpArrayM];
}

// this menu appears when you're about to DELETE the tower
- (void) insertTowerMenuAppear: (CGPoint) towerLocation {
    
    self.isInsertTowerMenuActive = YES;
    
    self.insertYesMenuButton.modifierType = kDeleteYes;
    self.insertNoMenuButton.modifierType = kDeleteNo;
    
    if (self.isInsertMenuInitialized == NO) {
        self.isInsertMenuInitialized = YES;
        
        for (TowerControlMenuButton *b in self.insertTowerMenuControls) {
            [self addChild: b
                         z: 200
                       tag: kControlTagValue];
        }
    }
    
    for (TowerControlMenuButton *b in self.insertTowerMenuControls) {
        b.isActive = YES;
        b.visible = YES;
    }
    
    float padding = 40.0f;    
    
    self.insertYesMenuButton.position = ccp(towerLocation.x, towerLocation.y + padding);
    self.insertNoMenuButton.position = ccp(towerLocation.x, towerLocation.y - padding);
    
    // label to show when you're about the DELETE the tower
    if (self.insertTowerMenuLabel == nil) {
        self.insertTowerMenuLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
        self.insertTowerMenuLabel.color = ccYELLOW;
        self.insertTowerMenuLabel.zOrder = 200 + 1;
        [self addChild: self.insertTowerMenuLabel];
    }
    
    Tower *t = (Tower *) self.selectedTowerControl;
    
    int sellValue = (int) (SELL_VALUE_MULTIPLIER*((float) t.towerTotalValue) + 0.5f);
    
    NSString *sellString = [NSString stringWithFormat: @"Sell for %d gold?", sellValue];
    
    [self.insertTowerMenuLabel setString: sellString];
    self.insertTowerMenuLabel.visible = YES;
    self.insertTowerMenuLabel.position = towerLocation;
    
}

// this menu appears when you're about to PLACE the towers
- (void) insertTowerMenuAppear: (CGPoint) touchLocation 
                 withTowerType: (TowerType) tType 
         andPlacementReference: (TowerPlacement *) placementReference{
    
    self.isInsertTowerMenuActive = YES;
    self.insertYesMenuButton.modifierType = kInsertYes;
    self.insertNoMenuButton.modifierType = kInsertNo;
    
    NSString *towerString;
    int towerCost;
    
    switch (tType) {
            
        case kTowerStandard:
            towerString = [NSString stringWithFormat: @"TowerStandard_1.png"];
            towerCost = kTowerStandardCost;
            break;
            
        case kTowerIce:
            towerString = [NSString stringWithFormat: @"TowerIce_1.png"];
            towerCost = kTowerIceCost;
            break;
            
        case kTowerBomb:
            towerString = [NSString stringWithFormat: @"TowerBomb_1.png"];
            towerCost = kTowerBombCost;
            break;
            
        default:
            CCLOG(@"unrecognized");
            break;
    }
    
    self.sSprite = [CCSprite spriteWithSpriteFrameName: towerString];
    self.sSprite.position = touchLocation;
    [self addChild: sSprite];
    
    if (self.isInsertMenuInitialized == NO) {
        self.isInsertMenuInitialized = YES;
        
        for (TowerControlMenuButton *b in self.insertTowerMenuControls) {
            [self addChild: b
                         z: 200
                       tag: kControlTagValue];
        }
    }
    
    for (TowerControlMenuButton *b in self.insertTowerMenuControls) {
        b.isActive = YES;
        b.visible = YES;
    }
    
    float padding = 40.0f;
    
    self.insertYesMenuButton.towerType = tType;
    self.insertYesMenuButton.towerPlacement = placementReference;
    
    self.insertYesMenuButton.position = ccp(touchLocation.x, touchLocation.y + padding);
    self.insertNoMenuButton.position = ccp(touchLocation.x, touchLocation.y - padding);
    
    self.towerBounds.visible = YES;
    self.towerBounds.position = ccp(touchLocation.x, touchLocation.y);
    
    // label to show when you're about the PLACE the tower
    if (self.insertTowerMenuLabel == nil) {
        self.insertTowerMenuLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
        self.insertTowerMenuLabel.color = ccYELLOW;
        self.insertTowerMenuLabel.zOrder = 200 + 1;
        [self addChild: self.insertTowerMenuLabel];
    }
    
    NSString *towerCostString = [NSString stringWithFormat: @"Buy for %d gold?", towerCost];
    
    [self.insertTowerMenuLabel setString: towerCostString];
    self.insertTowerMenuLabel.visible = YES;
    self.insertTowerMenuLabel.position = touchLocation;

}

- (void) insertTowerMenuDisappear {
    
    self.isInsertTowerMenuActive = NO;
    
    if (self.sSprite != nil) {
        [self.sSprite removeFromParentAndCleanup: YES];
    }
    
    for (TowerControlMenuButton *b in self.insertTowerMenuControls) {
        b.isActive = NO;
        b.visible = NO;
        b.position = ccp(0,0);        
    }
    
    /*
    if (self.gamePlayLayer.backgroundLayer.tileMap.visible == YES) {
        self.gamePlayLayer.backgroundLayer.tileMap.visible = NO;
    }
    */
    
    // label is set to invisible
    self.insertTowerMenuLabel.visible = NO;
}

- (void) initTowerBounds {
    self.towerBounds = [CCSprite node];
    self.towerBounds.visible = NO;
    self.towerBounds.scale = 0.8f;
    
    self.towerBounds.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                     spriteFrameByName: @"tower_icon_bound_1.png"];
    
    // animate tower bounds
    id actionRotate = [CCRotateBy actionWithDuration: 8.0f angle: 360];
    
    id actionScaleUp1 = [CCScaleTo actionWithDuration: 4.0f scale: 0.9f];
    id actionScaleDown1 = [CCScaleTo actionWithDuration: 4.0f scale: 0.8f];
    id actionSequence = [CCSequence actions: actionScaleUp1, actionScaleDown1, nil];
    
    id actionSpawn = [CCSpawn actions: actionRotate, actionSequence, nil];
    
    id actionForever = [CCRepeatForever actionWithAction: actionSpawn];
    
    [self.towerBounds runAction: actionForever];
    
    [self addChild: self.towerBounds
                 z: 150
               tag: kControlTagValue];
}

- (BOOL) ccTouchBegan: (UITouch *) touch withEvent: (UIEvent *) event {
    
    // note: ControlsLayer has a very low priority touch delegate
    // if no buttons are touched, then ControlsLayer will claim the touch
    // and it will check whether towerBounds are visible
    // if they are, then ControlsLayer will make towerBounds disappear
    
    if (self.towerBounds.visible == YES) {
        self.towerBounds.visible = NO;
    }
    
    if  (self.isInsertTowerMenuActive == YES) {
        [self insertTowerMenuDisappear];
    }
    
    self.selectedTowerControl = nil;
    
    return YES;
}

- (void) initLabels {
    
    // THIS IS WHERE SELECTED HERO XP is initialized
    
    int experience = [GameManager sharedGameManager].selectedHero.experiencePoints;
    int experienceLimit = [GameManager sharedGameManager].selectedHero.currentExperienceLimit;
    
    NSString *xpString = [NSString stringWithFormat: @"%d", experience];
    NSString *xpLimit = [NSString stringWithFormat: @"%d", experienceLimit];
    NSString *combinedExperienceString = [NSString stringWithFormat: @"%@/%@", xpString, xpLimit];
    
    self.experienceCountLabel = [CCLabelBMFont labelWithString: combinedExperienceString fntFile: @"MushroomTextSmall.fnt"];
    
    self.experienceCountLabel.anchorPoint = ccp(1.0,0.5);
    self.experienceCountLabel.position = ccp(269, 299);
    self.experienceCountLabel.zOrder = 9999;
    // self.experienceCountLabel.color = ccYELLOW;
    
    NSString *startingCoinsString = [NSString stringWithFormat: @"%d", self.coins];
    
    self.coinCount = [CCLabelBMFont labelWithString: startingCoinsString fntFile: @"MushroomTextSmall.fnt"];
    self.coinCount.anchorPoint = ccp(1.0,0.5);
    self.coinCount.position = ccp(347, 299);
    self.coinCount.zOrder = 9999;
    self.coinCount.color = ccYELLOW;
    
    // adding hero icon
    GameManager *m = [GameManager sharedGameManager];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    float paddingX = 57.0f;
    float paddingY = 30.0f;
    
    CCSprite *heroSprite = [CCSprite node];
    heroSprite.position = ccp(screenSize.width - paddingX, screenSize.height - paddingY);
    heroSprite.zOrder = 99999;
    heroSprite.scale = 1.0f;
    
    if (m.selectedHero.characterID == 1) {
        heroSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                   spriteFrameByName: @"hero_1_small.png"];
    } else if (m.selectedHero.characterID == 2) {
        heroSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                   spriteFrameByName: @"hero_2_small.png"];
    } else if (m.selectedHero.characterID == 3) {
        heroSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                   spriteFrameByName: @"hero_3_small.png"];
    }
    
    [self addChild: experienceCountLabel];
    [self addChild: coinCount];
    [self addChild: heroSprite];
}

- (void) initLifeIcon {
    
    self.lifeIcon = [CCSprite node];
    self.lifeIcon.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                  spriteFrameByName: @"life_icon_1.png"];
    self.lifeIcon.position = ccp(460,273);
    self.lifeIcon.zOrder = 9999;
    
    // adding life counter label
    self.lifeCounterLabel = [CCLabelBMFont labelWithString: @"10" fntFile: @"MushroomTextSmall.fnt"];
    self.lifeCounterLabel.scale = 0.9f;
    self.lifeCounterLabel.position = self.lifeIcon.position;
    self.lifeCounterLabel.zOrder = self.lifeIcon.zOrder + 1;
    // self.lifeCounterLabel.color = ccYELLOW;
    
    [self addChild: lifeIcon];
    [self addChild: lifeCounterLabel];
}

- (void) insertRoundNumberLabel {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    float paddingX = 103.0f;
    float paddingY = 21.0f;
    
    self.roundNumberLabel = [CCLabelBMFont labelWithString: @"Round 1 of 20" fntFile: @"MushroomTextSmall.fnt"];
    self.roundNumberLabel.zOrder = 0;
    self.roundNumberLabel.scale = 0.9f;
    self.roundNumberLabel.position = ccp(paddingX, screenSize.height - paddingY);
    
    [self addChild: roundNumberLabel];
    
}

- (void) loseSequence {
    
    // stop background music
    SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
    
    if (s.isBackgroundMusicPlaying) {
        [s stopBackgroundMusic];
    }
    
    // delay for 2 seconds
    id actionDelay = [CCDelayTime actionWithDuration: 2.0f];
    id actionCall = [CCCallFunc actionWithTarget: [GameManager sharedGameManager] selector: @selector(lose)];
    id actionSequence = [CCSequence actions: actionDelay, actionCall, nil];
    
    [self runAction: actionSequence];
    
}

- (void) winSequence {
 
    // stop background music
    SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
    
    if (s.isBackgroundMusicPlaying) {
        [s stopBackgroundMusic];
    }
    
    // delay for 2 seconds
    id actionDelay = [CCDelayTime actionWithDuration: 2.0f];
    id actionCall = [CCCallFunc actionWithTarget: [GameManager sharedGameManager] selector: @selector(win)];
    id actionSequence = [CCSequence actions: actionDelay, actionCall, nil];
    
    [self runAction: actionSequence];
    
}

- (void) insertHeroLevelLabel {
    
    GameManager *m = [GameManager sharedGameManager];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    int heroLevel = m.selectedHero.characterLevel;
    NSString *heroLevelString = [NSString stringWithFormat: @"Level %d", heroLevel];
    
    self.heroLevelLabel = [CCLabelBMFont labelWithString: heroLevelString fntFile: @"MushroomTextSmall.fnt"];
    self.heroLevelLabel.zOrder = 999999;
    // self.heroLevelLabel.position = ccp(screenSize.width/2 - 28.0f, screenSize.height - 32.0f);
    self.heroLevelLabel.position = ccp(screenSize.width - 57.0f, screenSize.height - 11.0f);
    self.heroLevelLabel.scale = 0.9f;
    //self.heroLevelLabel.color = ccYELLOW;
    
    [self addChild: heroLevelLabel];
    
    
}

- (id) initWithLayer: (GamePlayLayer *) gp {
        
    if (self = [super init]) {

        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.gamePlayLayer = gp;
        self.touchState = kStateReset;
        self.isMenuInitialized = NO;
        self.isInsertMenuInitialized = NO;
        self.isDeleteMenuInitialized = NO;
        self.paused = NO;
        self.coins = kStartingCoins;
        
        [self initLabels];
        [self initLifeIcon];
        
        // power select button
        [self initPowerSelectButtons];
        
        [self addChild: powerSelectButton
                     z: 1
                   tag: kControlTagValue];
        
        [self initInsertTowerMenuButtons];
        [self initDeleteTowerMenuButtons];
        
        // button overlay
        CCSprite *tmpSprite = [CCSprite node];
        tmpSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                  spriteFrameByName: @"profile_button_overlay_1.png"];
        tmpSprite.anchorPoint = ccp(1,1);        
        tmpSprite.position = ccp(screenSize.width, screenSize.height);
        
        [self addChild: tmpSprite
                     z: 6
                   tag: kControlTagValue];
        
        [self initTalentButton];
        [self insertPauseAndResetButton];
        [self initTowerPersonalMenuButtons];
        [self initTowerBounds];
        
        [self insertRoundNumberLabel];
        
        // heart with 10 lives
        self.lifeCounter = [CCSprite node];
        self.lifeCounter.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                         spriteFrameByName: @"overlay_life_10.png"];
        
        self.lifeCounter.anchorPoint = ccp(0.5, 0);
        self.lifeCounter.position = ccp(460,276);
        
        [self addChild: self.lifeCounter
                     z: 6
                   tag: kControlTagValue];
        
        // all the buttons put into an array
        self.towerControls = [NSMutableArray arrayWithObjects: 
                              powerSelectButton.tDelegate, powerOneControl.tDelegate, 
                              powerTwoControl.tDelegate, powerThreeControl.tDelegate, 
                              powerFourControl.tDelegate, powerFiveControl.tDelegate, 
                              powerSixControl.tDelegate, bulletDamageMenuButton.tDelegate, 
                              bulletAccuracyMenuButton.tDelegate, critValueMenuButton.tDelegate, 
                              towerRemoveMenuButton.tDelegate, insertYesMenuButton.tDelegate,
                              insertNoMenuButton.tDelegate, deleteYesMenuButton.tDelegate, 
                              deleteNoMenuButton.tDelegate, nil];
        
        
        // insert hero level label
        [self insertHeroLevelLabel];
        
        
    }
    return self;
}

- (id) init {
    if (self = [super init]) {        
        CCLOG(@"don't use this method");
        
    }
    
    return self;
    
} // init

@end

























