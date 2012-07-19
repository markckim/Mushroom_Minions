//
//  Tower.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tower.h"
#import "ControlsLayer.h"
#import "GamePlayLayer.h"
#import "TowerControlMenuButton.h"
#import "TowerControlCastButton.h"
#import "Bullet.h"

@implementation Tower

@synthesize delegate;
@synthesize tDelegate;
@synthesize controlsLayer;
@synthesize towerPersonalSpace;

@synthesize bulletTimer;
@synthesize buttonType;
@synthesize towerType;
@synthesize bulletType;
@synthesize targetEnemy;
@synthesize firingAction;
@synthesize bulletActive;
@synthesize shootBulletInUpdate;

@synthesize firingRate;
@synthesize bulletDamageEffect;
@synthesize bulletAccuracyEffect;
@synthesize critEffect;
@synthesize towerRange;
@synthesize menuSquishFactor;
@synthesize removeSignal;
@synthesize firingActive;
@synthesize targetToShoot;

@synthesize bulletDamageEffectUpgradeLevel;
@synthesize bulletAccuracyEffectUpgradeLevel;
@synthesize critEffectUpgradeLevel;

@synthesize damageUpgradeCost1;
@synthesize damageUpgradeCost2;
@synthesize damageUpgradeCost3;

@synthesize accuracyUpgradeCost1;
@synthesize accuracyUpgradeCost2;
@synthesize accuracyUpgradeCost3;

@synthesize critUpgradeCost1;
@synthesize critUpgradeCost2;
@synthesize critUpgradeCost3;

@synthesize towerTotalValue;
@synthesize towerBulletDamage;
@synthesize towerNormalBulletDamage;

@synthesize maxString;
@synthesize towerPlacementReference;

@synthesize towerStatusEffectSprite;
@synthesize towerProcEffectSprite;
@synthesize isTowerStatusEffectActive;
@synthesize overclockEffect;
@synthesize longshotEffect;
@synthesize rageEffect;
@synthesize overclockEffectTimer;
@synthesize longshotEffectTimer;
@synthesize rageEffectTimer;
@synthesize procEffect;
@synthesize procEffectBulletCount;
@synthesize procEffectTimer;

@synthesize bulletArray;

- (void) dealloc {
    
    CCLOG(@"Tower dealloc");
    
    self.delegate = nil;
    self.tDelegate = nil;
    self.controlsLayer = nil;
    self.targetEnemy = nil;
    self.firingAction = nil;
    self.towerPersonalSpace = nil;
    self.maxString = nil;
    self.towerStatusEffectSprite = nil;
    self.towerProcEffectSprite = nil;
    self.towerPlacementReference = nil;
    
    self.bulletArray = nil;
    
    [super dealloc];
}

- (void) deletingSelf {
    
    if (self.towerStatusEffectSprite != nil) {
        [self.delegate queueEffectToDelete: self.towerStatusEffectSprite];
    }
    
    if (self.towerProcEffectSprite != nil) {
        [self.delegate queueEffectToDelete: self.towerProcEffectSprite];
    }
    
    // re-activate the tower placement
    self.towerPlacementReference.isActive = YES;
    
    [self.delegate queueTowerToDelete: self];
    
    // remove all references that currently active bullets may have on this tower
    // this is to prevent a crash when activating the proc effect
    // e.g., a tower is removed that has shot a bullet that is going to crit
    // tower will be removed, bullet will crit, bullet will call it's tower reference to activate
    // the proc effect, but there will be no tower that exists and the game will crash
    for (Bullet *b in self.bulletArray) {
        b.towerRef = nil;
    }
    
}

- (void) onEnter {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate: self priority: 20 swallowsTouches: YES];
    [super onEnter];
}

- (void) onExit {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate: self];
    [super onExit];
}

- (void) upgradeBulletDamageEffect: (int) bDamage {
    
    if (self.bulletDamageEffectUpgradeLevel < 3) {
        self.bulletDamageEffectUpgradeLevel = self.bulletDamageEffectUpgradeLevel + 1;
        
        self.bulletDamageEffect = self.bulletDamageEffect + ((float)(bDamage))/((float)(self.towerNormalBulletDamage));
        self.towerBulletDamage = self.towerBulletDamage + bDamage;
        
        // subtracting the cost of the upgrade
        // increasing the total value of the tower
        switch (self.bulletDamageEffectUpgradeLevel) {
                
            case 1:
                PLAYSOUNDEFFECT(upgrade_sound);
                [delegate receiveCoins: - (damageUpgradeCost1)];
                self.towerTotalValue = self.towerTotalValue + damageUpgradeCost1;
                break;
                
            case 2:
                PLAYSOUNDEFFECT(upgrade_sound);
                [delegate receiveCoins: - (damageUpgradeCost2)];
                self.towerTotalValue = self.towerTotalValue + damageUpgradeCost2;
                break;
                
            case 3:
                PLAYSOUNDEFFECT(upgrade_max_sound);
                [delegate receiveCoins: - (damageUpgradeCost3)];
                self.towerTotalValue = self.towerTotalValue + damageUpgradeCost3;
                break;
                
            default:
                CCLOG(@"tower: unrecognized upgrade number");
                break;
        }
        
        [self showAppropriatePersonalMenu];
        
    } else {
        CCLOG(@"can't upgrade bullet DAMAGE anymore!");
    }
}

- (void) upgradeBulletAccuracyEffect: (float) percentIncrease {
    
    if (self.bulletAccuracyEffectUpgradeLevel < 3) {
        self.bulletAccuracyEffectUpgradeLevel = self.bulletAccuracyEffectUpgradeLevel + 1;
        self.bulletAccuracyEffect = self.bulletAccuracyEffect + (percentIncrease);
        
        // subtracting the cost of the upgrade
        switch (self.bulletAccuracyEffectUpgradeLevel) {
                
            case 1:
                PLAYSOUNDEFFECT(upgrade_sound);
                [delegate receiveCoins: - (accuracyUpgradeCost1)];
                self.towerTotalValue = self.towerTotalValue + accuracyUpgradeCost1;
                break;
                
            case 2:
                PLAYSOUNDEFFECT(upgrade_sound);
                [delegate receiveCoins: - (accuracyUpgradeCost2)];
                self.towerTotalValue = self.towerTotalValue + accuracyUpgradeCost2;
                break;
                
            case 3:
                PLAYSOUNDEFFECT(upgrade_max_sound);
                [delegate receiveCoins: - (accuracyUpgradeCost3)];
                self.towerTotalValue = self.towerTotalValue + accuracyUpgradeCost3;
                break;
                
            default:
                CCLOG(@"tower: unrecognized upgrade number");
                break;
        }
        
        [self showAppropriatePersonalMenu];

    } else {
        CCLOG(@"can't upgrade bullet ACCURACY anymore!");
    }
}

- (void) upgradeCritEffect: (float) percentIncrease {
    
    if (self.critEffectUpgradeLevel < 3) {
        self.critEffectUpgradeLevel = self.critEffectUpgradeLevel + 1;
        self.critEffect = self.critEffect + (percentIncrease);
        
        // subtracting the cost of the upgrade
        switch (self.critEffectUpgradeLevel) {
                
            case 1:
                PLAYSOUNDEFFECT(upgrade_sound);
                [delegate receiveCoins: - (critUpgradeCost1)];
                self.towerTotalValue = self.towerTotalValue + critUpgradeCost1;
                break;
                
            case 2:
                PLAYSOUNDEFFECT(upgrade_sound);
                [delegate receiveCoins: - (critUpgradeCost2)];
                self.towerTotalValue = self.towerTotalValue + critUpgradeCost2;
                break;
                
            case 3:
                PLAYSOUNDEFFECT(upgrade_max_sound);
                [delegate receiveCoins: - (critUpgradeCost3)];
                self.towerTotalValue = self.towerTotalValue + critUpgradeCost3;
                break;
                
            default:
                CCLOG(@"tower: unrecognized upgrade number");
                break;
        }

        [self showAppropriatePersonalMenu];
    
    } else {
        CCLOG(@"can't upgrade CRIT EFFECT anymore!");
    }
}

- (void) showAppropriatePersonalMenu {
    
    
    self.controlsLayer.bulletDamageMenuButton.disabledSprite.visible = NO;
    self.controlsLayer.bulletAccuracyMenuButton.disabledSprite.visible = NO;
    self.controlsLayer.critValueMenuButton.disabledSprite.visible = NO;
    
    // showing the appropriate bullet damage effect image
    switch (self.bulletDamageEffectUpgradeLevel) {
            
        case 0:
            self.controlsLayer.bulletDamageMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                      spriteFrameByName: @"tower_damage_icon_0.png"];
            self.controlsLayer.bulletDamageMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", damageUpgradeCost1];
            self.controlsLayer.bulletDamageMenuButton.statsLabel.string = [NSString stringWithFormat: @"+%d", self.towerBulletDamage];
            self.controlsLayer.bulletDamageMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                 spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (damageUpgradeCost1 > self.controlsLayer.coins) {
                self.controlsLayer.bulletDamageMenuButton.disabledSprite.visible = YES;
            }
            break;
        case 1:
            self.controlsLayer.bulletDamageMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                      spriteFrameByName: @"tower_damage_icon_1.png"];
            self.controlsLayer.bulletDamageMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", damageUpgradeCost2];
            self.controlsLayer.bulletDamageMenuButton.statsLabel.string = [NSString stringWithFormat: @"+%d", self.towerBulletDamage];
            self.controlsLayer.bulletDamageMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                 spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (damageUpgradeCost2 > self.controlsLayer.coins) {
                self.controlsLayer.bulletDamageMenuButton.disabledSprite.visible = YES;
            }
            break;
            
        case 2:
            self.controlsLayer.bulletDamageMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                      spriteFrameByName: @"tower_damage_icon_2.png"];
            self.controlsLayer.bulletDamageMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", damageUpgradeCost3];
            self.controlsLayer.bulletDamageMenuButton.statsLabel.string = [NSString stringWithFormat: @"+%d", self.towerBulletDamage];
            self.controlsLayer.bulletDamageMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                 spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (damageUpgradeCost3 > self.controlsLayer.coins) {
                self.controlsLayer.bulletDamageMenuButton.disabledSprite.visible = YES;
            }
            break;
            
        case 3:
            self.controlsLayer.bulletDamageMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                      spriteFrameByName: @"tower_damage_icon_3.png"];
            self.controlsLayer.bulletDamageMenuButton.costLabel.string = self.maxString;
            self.controlsLayer.bulletDamageMenuButton.statsLabel.string = [NSString stringWithFormat: @"+%d", self.towerBulletDamage];
            
            self.controlsLayer.bulletDamageMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                   spriteFrameByName: @"upgrade_cost_label_3.png"];
            break;
            
        default:
            CCLOG(@"tower: unrecognized bullet damage effect upgrade level");
            break;
    }
    
    // showing the appropriate bullet accuracy effect image
    switch (self.bulletAccuracyEffectUpgradeLevel) {
            
        case 0:
            self.controlsLayer.bulletAccuracyMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                      spriteFrameByName: @"tower_accuracy_icon_0.png"];
            self.controlsLayer.bulletAccuracyMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", accuracyUpgradeCost1];
            self.controlsLayer.bulletAccuracyMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*self.bulletAccuracyEffect];
            self.controlsLayer.bulletAccuracyMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                   spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (accuracyUpgradeCost1 > self.controlsLayer.coins) {
                self.controlsLayer.bulletAccuracyMenuButton.disabledSprite.visible = YES;
            }
            break;                                                                      
        case 1:
            self.controlsLayer.bulletAccuracyMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                        spriteFrameByName: @"tower_accuracy_icon_1.png"];
            self.controlsLayer.bulletAccuracyMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", accuracyUpgradeCost2];
            self.controlsLayer.bulletAccuracyMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*self.bulletAccuracyEffect];
            self.controlsLayer.bulletAccuracyMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                   spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (accuracyUpgradeCost2 > self.controlsLayer.coins) {
                self.controlsLayer.bulletAccuracyMenuButton.disabledSprite.visible = YES;
            }
            break;
            
        case 2:
            self.controlsLayer.bulletAccuracyMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                        spriteFrameByName: @"tower_accuracy_icon_2.png"];
            self.controlsLayer.bulletAccuracyMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", accuracyUpgradeCost3];
            self.controlsLayer.bulletAccuracyMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*self.bulletAccuracyEffect];
            self.controlsLayer.bulletAccuracyMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                   spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (accuracyUpgradeCost3 > self.controlsLayer.coins) {
                self.controlsLayer.bulletAccuracyMenuButton.disabledSprite.visible = YES;
            }
            break;
            
        case 3:
            self.controlsLayer.bulletAccuracyMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                        spriteFrameByName: @"tower_accuracy_icon_3.png"];
            self.controlsLayer.bulletAccuracyMenuButton.costLabel.string = self.maxString;
            self.controlsLayer.bulletAccuracyMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*self.bulletAccuracyEffect];
            
            self.controlsLayer.bulletAccuracyMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                                   spriteFrameByName: @"upgrade_cost_label_3.png"];
            break;
            
        default:
            CCLOG(@"tower: unrecognized bullet accuracy effect upgrade level");
            break;
    }

    // showing the appropriate crit effect image
    switch (self.critEffectUpgradeLevel) {
            
        case 0:
            self.controlsLayer.critValueMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                    spriteFrameByName: @"tower_crit_icon_0.png"];
            self.controlsLayer.critValueMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", critUpgradeCost1];
            self.controlsLayer.critValueMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*(self.critEffect+self.rageEffect)];
            self.controlsLayer.critValueMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                              spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (critUpgradeCost1 > self.controlsLayer.coins) {
                self.controlsLayer.critValueMenuButton.disabledSprite.visible = YES;
            }
            break;
            
        case 1:
            self.controlsLayer.critValueMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                   spriteFrameByName: @"tower_crit_icon_1.png"];
            self.controlsLayer.critValueMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", critUpgradeCost2];
            self.controlsLayer.critValueMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*(self.critEffect+self.rageEffect)];
            self.controlsLayer.critValueMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                              spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (critUpgradeCost2 > self.controlsLayer.coins) {
                self.controlsLayer.critValueMenuButton.disabledSprite.visible = YES;
            }
            break;
            
        case 2:
            self.controlsLayer.critValueMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                   spriteFrameByName: @"tower_crit_icon_2.png"];
            self.controlsLayer.critValueMenuButton.costLabel.string = [NSString stringWithFormat: @"%d", critUpgradeCost3];
            self.controlsLayer.critValueMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*(self.critEffect+self.rageEffect)];
            self.controlsLayer.critValueMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                              spriteFrameByName: @"upgrade_cost_label_1.png"];
            if (critUpgradeCost3 > self.controlsLayer.coins) {
                self.controlsLayer.critValueMenuButton.disabledSprite.visible = YES;
            }
            break;
            
        case 3:
            self.controlsLayer.critValueMenuButton.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                   spriteFrameByName: @"tower_crit_icon_3.png"];
            self.controlsLayer.critValueMenuButton.costLabel.string = self.maxString;

            self.controlsLayer.critValueMenuButton.statsLabel.string = [NSString stringWithFormat: @"%.f%%", 100*(self.critEffect+self.rageEffect)];
            
            self.controlsLayer.critValueMenuButton.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                                              spriteFrameByName: @"upgrade_cost_label_3.png"];
            break;
            
        default:
            CCLOG(@"tower: unrecognized bullet accuracy effect upgrade level");
            break;
    }
    
    if (self.rageEffect > 0.0f) {
        self.controlsLayer.critValueMenuButton.statsLabel.color = ccYELLOW;
    } else {
        self.controlsLayer.critValueMenuButton.statsLabel.color = ccWHITE;
    }
    
    self.controlsLayer.bulletDamageMenuButton.costLabel.visible = YES;
    self.controlsLayer.bulletAccuracyMenuButton.costLabel.visible = YES;
    self.controlsLayer.critValueMenuButton.costLabel.visible = YES;
    
    self.controlsLayer.bulletDamageMenuButton.costSprite.visible = YES;
    self.controlsLayer.bulletAccuracyMenuButton.costSprite.visible = YES;
    self.controlsLayer.critValueMenuButton.costSprite.visible = YES;
    
}

- (void) menuAppear {
    
    CGPoint upperLeftPoint = ccp(self.position.x - self.contentSize.width*menuSquishFactor, 
                                 self.position.y + self.contentSize.height*menuSquishFactor);
    CGPoint upperRightPoint = ccp(self.position.x + self.contentSize.width*menuSquishFactor, 
                                  self.position.y + self.contentSize.height*menuSquishFactor);
    CGPoint lowerLeftPoint = ccp(self.position.x - self.contentSize.width*menuSquishFactor, 
                                 self.position.y - self.contentSize.height*menuSquishFactor);
    CGPoint lowerRightPoint = ccp(self.position.x + self.contentSize.width*menuSquishFactor, 
                                  self.position.y - self.contentSize.height*menuSquishFactor);
    
    if (self.controlsLayer.isMenuInitialized == NO) {
        self.controlsLayer.isMenuInitialized = YES;
        
        for (TowerControlMenuButton *tc in self.controlsLayer.towerMenuControls) {
            
            [self.controlsLayer addChild: tc
                                       z: 200
                                     tag: kControlTagValue];
            
            if (tc.modifierType != kTowerRemove) {
                tc.costSprite = [CCSprite node];
                tc.costSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                              spriteFrameByName: @"upgrade_cost_label_1.png"];
                [self.controlsLayer addChild: tc.costSprite
                                           z: 200 + 1
                                         tag:kControlTagValue];
                
                tc.costLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
                [self.controlsLayer addChild: tc.costLabel
                                           z: 200 + 2
                                         tag: kControlTagValue];
                
                tc.menuLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
                [self.controlsLayer addChild: tc.menuLabel
                                           z: 200 + 2
                                         tag: kControlTagValue];
                
                tc.statsLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
                tc.statsLabel.scale = 0.85f;
                [self.controlsLayer addChild: tc.statsLabel
                                           z: 200 + 2
                                         tag: kControlTagValue];
                
                tc.disabledSprite = [CCSprite node];
                tc.disabledSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                  spriteFrameByName: @"upgrade_cost_label_2.png"];
                [self.controlsLayer addChild: tc.disabledSprite
                                           z: 200 + 3
                                         tag: kControlTagValue];
                
            } else if (tc.modifierType == kTowerRemove) {
                
                // this is for the tower remove button
                // it needs a label button
                tc.menuLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
                [self.controlsLayer addChild: tc.menuLabel
                                           z: 200 + 2
                                         tag: kControlTagValue];
                
            }
            
            float labelScale = 0.75f;
            float menuLabelScale = 0.75f;

            self.controlsLayer.bulletDamageMenuButton.costLabel.scale = labelScale;
            self.controlsLayer.bulletDamageMenuButton.costLabel.color = ccYELLOW;
            self.controlsLayer.bulletDamageMenuButton.costLabel.anchorPoint = ccp(1,0.5);
            self.controlsLayer.bulletDamageMenuButton.menuLabel.scale = menuLabelScale;
            
            self.controlsLayer.bulletAccuracyMenuButton.costLabel.scale = labelScale;
            self.controlsLayer.bulletAccuracyMenuButton.costLabel.color = ccYELLOW;
            self.controlsLayer.bulletAccuracyMenuButton.costLabel.anchorPoint = ccp(1,0.5);
            self.controlsLayer.bulletAccuracyMenuButton.menuLabel.scale = menuLabelScale;

            self.controlsLayer.critValueMenuButton.costLabel.scale = labelScale;
            self.controlsLayer.critValueMenuButton.costLabel.color = ccYELLOW;
            self.controlsLayer.critValueMenuButton.costLabel.anchorPoint = ccp(1,0.5);
            self.controlsLayer.critValueMenuButton.menuLabel.scale = menuLabelScale;
            
            self.controlsLayer.towerRemoveMenuButton.menuLabel.scale = menuLabelScale;
            
            tc.isActive = YES;
        }
        
        self.controlsLayer.bulletDamageMenuButton.menuLabel.string = @"Damage";
        self.controlsLayer.bulletAccuracyMenuButton.menuLabel.string = @"Accuracy";
        self.controlsLayer.critValueMenuButton.menuLabel.string = @"Critical";
        self.controlsLayer.towerRemoveMenuButton.menuLabel.string = @"Remove";
                
        if (self.controlsLayer.isInsertTowerMenuActive == YES) {
            [self.controlsLayer insertTowerMenuDisappear];
            [self.controlsLayer.sSprite removeFromParentAndCleanup: YES];
        }
    }
    
    [self showAppropriatePersonalMenu];
    
    for (TowerControlMenuButton *tc in self.controlsLayer.towerMenuControls) {
        tc.visible = YES;
        tc.isActive = YES;
        
        tc.menuLabel.visible = YES;
        tc.statsLabel.visible = YES;
        
        //[[[CCDirector sharedDirector] touchDispatcher] 
         //addTargetedDelegate: tc priority: 0 swallowsTouches: YES];
    }
    
    float offsetX = self.controlsLayer.bulletDamageMenuButton.contentSize.width/4 + 2;
    float offsetY = self.controlsLayer.bulletDamageMenuButton.contentSize.height/2 - 5;
    
    self.controlsLayer.bulletDamageMenuButton.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.costSprite.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.disabledSprite.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.menuLabel.position = ccp(upperLeftPoint.x, upperLeftPoint.y + 1.3*offsetY);
    self.controlsLayer.bulletDamageMenuButton.statsLabel.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.costLabel.position = ccp(upperLeftPoint.x + offsetX + 1, upperLeftPoint.y - offsetY + 1);
    
    self.controlsLayer.bulletAccuracyMenuButton.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.costSprite.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.disabledSprite.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.menuLabel.position = ccp(upperRightPoint.x, upperRightPoint.y + 1.3*offsetY);
    self.controlsLayer.bulletAccuracyMenuButton.statsLabel.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.costLabel.position = ccp(upperRightPoint.x + offsetX + 1, upperLeftPoint.y - offsetY + 1);
  
    
    self.controlsLayer.critValueMenuButton.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.costSprite.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.disabledSprite.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.menuLabel.position = ccp(lowerLeftPoint.x, lowerLeftPoint.y + 1.3*offsetY);
    self.controlsLayer.critValueMenuButton.statsLabel.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.costLabel.position = ccp(lowerLeftPoint.x + offsetX + 1, lowerLeftPoint.y - offsetY + 1);
    
    self.controlsLayer.towerRemoveMenuButton.position = lowerRightPoint;
    self.controlsLayer.towerRemoveMenuButton.menuLabel.position = ccp(lowerRightPoint.x, lowerRightPoint.y + 1.3*offsetY);
    
    self.controlsLayer.towerBounds.visible = YES;
    self.controlsLayer.towerBounds.position = self.position;
}

- (void) menuDisappear {
    CGPoint originPoint = ccp(-100,-100);

    for (TowerControlMenuButton *tc in self.controlsLayer.towerMenuControls) {
        tc.scale = 1.0f;
        tc.visible = NO;
        tc.isActive = NO;
        
        tc.costSprite.visible = NO;
        tc.costSprite.position = originPoint;
        
        tc.costLabel.visible = NO;
        tc.costLabel.position = originPoint;
        
        tc.disabledSprite.visible = NO;
        tc.disabledSprite.position = originPoint;
        
        tc.menuLabel.visible = NO;
        tc.menuLabel.position = originPoint;
        
        tc.statsLabel.visible = NO;
        tc.statsLabel.position = originPoint;
        
        //[[[CCDirector sharedDirector] touchDispatcher] removeDelegate: tc];
        
        tc.position = originPoint;
    }    
    self.controlsLayer.towerBounds.visible = NO;
}

- (void) menuDisappearFromTowerRemove {
    CGPoint originPoint = ccp(-100,-100);
    
    for (TowerControlMenuButton *tc in self.controlsLayer.towerMenuControls) {
        tc.scale = 1.0f;
        tc.visible = NO;
        tc.isActive = NO;
        tc.position = originPoint;
        
        //[[[CCDirector sharedDirector] touchDispatcher] removeDelegate: tc];
        
        tc.costSprite.visible = NO;
        tc.costSprite.position = originPoint;
        
        tc.costLabel.visible = NO;
        tc.costLabel.position = originPoint;
        
        tc.disabledSprite.visible = NO;
        tc.disabledSprite.position = originPoint;
        
        tc.menuLabel.visible = NO;
        tc.menuLabel.position = originPoint;
        
        tc.statsLabel.visible = NO;
        tc.statsLabel.position = originPoint;
    }    
}

- (void) menuMoveToNewTower {
        
    CGPoint upperLeftPoint = ccp(self.position.x - self.contentSize.width*menuSquishFactor, 
                                 self.position.y + self.contentSize.height*menuSquishFactor);
    CGPoint upperRightPoint = ccp(self.position.x + self.contentSize.width*menuSquishFactor, 
                                  self.position.y + self.contentSize.height*menuSquishFactor);
    CGPoint lowerLeftPoint = ccp(self.position.x - self.contentSize.width*menuSquishFactor, 
                                 self.position.y - self.contentSize.height*menuSquishFactor);
    CGPoint lowerRightPoint = ccp(self.position.x + self.contentSize.width*menuSquishFactor, 
                                  self.position.y - self.contentSize.height*menuSquishFactor);
    
    float offsetX = self.controlsLayer.bulletDamageMenuButton.contentSize.width/4 + 2;
    float offsetY = self.controlsLayer.bulletDamageMenuButton.contentSize.height/2 - 5;
    
    self.controlsLayer.bulletDamageMenuButton.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.costSprite.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.disabledSprite.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.menuLabel.position = ccp(upperLeftPoint.x, upperLeftPoint.y + 1.3*offsetY);
    self.controlsLayer.bulletDamageMenuButton.statsLabel.position = upperLeftPoint;
    self.controlsLayer.bulletDamageMenuButton.costLabel.position = ccp(upperLeftPoint.x + offsetX + 1, upperLeftPoint.y - offsetY + 1);

    self.controlsLayer.bulletAccuracyMenuButton.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.costSprite.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.disabledSprite.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.menuLabel.position = ccp(upperRightPoint.x, upperRightPoint.y + 1.3*offsetY);
    self.controlsLayer.bulletAccuracyMenuButton.statsLabel.position = upperRightPoint;
    self.controlsLayer.bulletAccuracyMenuButton.costLabel.position = ccp(upperRightPoint.x + offsetX + 1, upperLeftPoint.y - offsetY + 1);

    self.controlsLayer.critValueMenuButton.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.costSprite.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.disabledSprite.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.menuLabel.position = ccp(lowerLeftPoint.x, lowerLeftPoint.y + 1.3*offsetY);
    self.controlsLayer.critValueMenuButton.statsLabel.position = lowerLeftPoint;
    self.controlsLayer.critValueMenuButton.costLabel.position = ccp(lowerLeftPoint.x + offsetX + 1, lowerLeftPoint.y - offsetY + 1);

    self.controlsLayer.towerRemoveMenuButton.position = lowerRightPoint; 
    self.controlsLayer.towerRemoveMenuButton.menuLabel.position = ccp(lowerRightPoint.x, lowerRightPoint.y + 1.3*offsetY);
    
    [self showAppropriatePersonalMenu];
    
    self.controlsLayer.towerBounds.position = self.position;
    
    for (TowerControlMenuButton *tc in self.controlsLayer.towerMenuControls) {
        if (tc.visible == NO) {
            tc.visible = YES;
            tc.isActive = YES;
            
            tc.menuLabel.visible = YES;
            tc.statsLabel.visible = YES;
        }
    }
}

- (void) selected {
    
    PLAYSOUNDEFFECT(select_power_sound);
    
    id action = [CCScaleTo actionWithDuration: 0.1f scale: 1.15f];
    [self runAction: action];    
    self.controlsLayer.selectedTowerControl = self.tDelegate;
    
    if  (self.controlsLayer.isInsertTowerMenuActive == YES) {
        [self.controlsLayer insertTowerMenuDisappear];
    }
}

- (void) unselected {
    
    id action = [CCScaleTo actionWithDuration: 0.1f scale: 1.0f];
    [self runAction: action];    
    self.controlsLayer.selectedTowerControl = nil;
}

- (CGRect) rect {
    CGSize s = [self contentSize];
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (BOOL) containsTouchLocation: (UITouch *) touch {
    return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL) touchLogic: (UITouch *) touch {
    

    for (TowerControlMenuButton *tc in self.controlsLayer.towerMenuControls) {
        if ([tc containsTouchLocation: touch]) {
            return NO;
        }
    }
        
    if ([self containsTouchLocation: touch] && self.isActive == YES) {
        
        // this case happens when a Cast Button is active 
        // and it can cast on a tower
        // and it touches a tower
                
        if (self.controlsLayer.isInsertTowerMenuActive == YES) {
            [self.controlsLayer insertTowerMenuDisappear];
        }
        
        if (self.controlsLayer.selectedTowerControl == nil) {
            [self selected];
            [self menuAppear];            
            return YES;
        } else if (self.controlsLayer.selectedTowerControl != nil && self.controlsLayer.selectedTowerControl != self.tDelegate) {
            // do nothing
        } else if (self.controlsLayer.selectedTowerControl == self.tDelegate) {
            [self unselected];
            [self menuDisappear];
            return YES;
        }
    } else if (![self containsTouchLocation: touch] && self.isActive == YES) {
        if (self.controlsLayer.selectedTowerControl != self) {
            // do nothing
        } else if (self.controlsLayer.selectedTowerControl == self) {
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            [tmpArray addObjectsFromArray: self.controlsLayer.towerControls];
            [tmpArray addObjectsFromArray: self.controlsLayer.gamePlayLayer.towerDelegateCollection];

            for (id <TowerControlDelegate> tc in tmpArray) {
                if (tc != self.tDelegate) {
                    CGPoint touchLocation = [touch locationInView: [touch view]];
                    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
                    if (CGRectContainsPoint(tc.boundingBox, touchLocation) && tc.isActive == YES) {
                        // if previous touch was a tower and current touch is a different tower
                        // simply move the menu to the new tower's location
                        if (tc.buttonType == kTowerButton) {
                            Tower *tmpTower = (Tower *) tc;
                            [tmpTower menuMoveToNewTower];
                            if (self.controlsLayer.isInsertTowerMenuActive == YES) {
                                [self.controlsLayer insertTowerMenuDisappear];
                            }
                        } else {
                            [self menuDisappear];
                        }
                        
                        if (tc.buttonType == kTowerMenuButton) {
                            return NO;
                        }

                        [self unselected];
                        [tc selected];
                        return YES;
                    }
                }
            }
            if (self.buttonType != kCastButton) {
                [self unselected];
                [self menuDisappear];
            }
        }
    }
    return NO;
}

- (BOOL) ccTouchBegan: (UITouch *) touch withEvent: (UIEvent *) event {
        
    return [self touchLogic: touch];
}

- (float) distanceToTarget: (GameCharacter *) gameCharacter
{
    float deltaX = [gameCharacter position].x - [self position].x;
    float deltaY = [gameCharacter position].y - [self position].y;
    float distance = sqrt(pow(deltaX,2) + pow(deltaY,2));
    
    return distance;
}

- (void) showTowerPersonalSpace {
    self.towerPersonalSpace.visible = YES;
    
    id actionScaleUp = [CCScaleTo actionWithDuration: 0.25f scale: 1.2f];
    id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 1.1f];
    id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
    id actionRepeatForever = [CCRepeatForever actionWithAction: actionSequence];
    
    [self.towerPersonalSpace runAction: actionRepeatForever];
}

- (void) hideTowerPersonalSpace {
    [self.towerPersonalSpace stopAllActions];
    self.towerPersonalSpace.visible = NO;
}

- (void) updateTimer: (float *) timerPointer 
       withDeltaTime: (ccTime) deltaTime
           andTarget: (float *) targetPointer
       andResetValue: (float) targetValue {
    
    if (*timerPointer < 0.0f) {
        return;
    }
    
    *timerPointer = *timerPointer - deltaTime;
    
    if (*timerPointer < 0.0f) {
        *targetPointer = targetValue;
        
        if (targetPointer == &rageEffect) {
            self.controlsLayer.critValueMenuButton.statsLabel.color = ccWHITE;
            
            NSString *s = [NSString stringWithFormat: @"%.f%%", 100*(self.critEffect+self.rageEffect)];
            
            self.controlsLayer.critValueMenuButton.statsLabel.string = s;
        }
        
        if (targetPointer == &procEffect) {
                        
            self.procEffectBulletCount = 0;
            
            id actionFadeOut = [CCFadeTo actionWithDuration: 1.0f opacity: 0];
            
            [self.towerProcEffectSprite runAction: actionFadeOut];
            
        }
        *timerPointer = -1.0f;
    }

    
}


- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects {
    
    if (self.removeSignal == 1) {
        [self deletingSelf];
    }
    
    // update timers
    [self updateTimer: &overclockEffectTimer 
        withDeltaTime: deltaTime
            andTarget: &overclockEffect
        andResetValue: 1.0f];
    
    [self updateTimer: &longshotEffectTimer 
        withDeltaTime: deltaTime
            andTarget: &longshotEffect
        andResetValue: 1.0f];
    
    [self updateTimer: &rageEffectTimer 
        withDeltaTime: deltaTime
            andTarget: &rageEffect
        andResetValue: 0.0f];
    
    [self updateTimer: &procEffectTimer
        withDeltaTime: deltaTime
            andTarget: &procEffect
        andResetValue: 1.0f];
    
    if (self.towerPersonalSpace == nil) {
        self.towerPersonalSpace = [CCSprite node];
        self.towerPersonalSpace.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                spriteFrameByName: @"tower_personal_space_1.png"];
        self.towerPersonalSpace.visible = NO;
        self.towerPersonalSpace.position = self.position;
        
        [self.delegate createEffect: self.towerPersonalSpace];
        self.towerPersonalSpace.zOrder = self.zOrder - 1;
    }
    
    if (self.firingActive == YES) {
        return;
    }
        
    if (self.bulletActive == NO) {
        self.bulletActive = YES;
        return;
    }
    
    if (self.shootBulletInUpdate == YES) {
        self.shootBulletInUpdate = NO;
        [self shootBullet];
    }
    
    CCArray *listOfEnemyObjects = [CCArray array];
    
    if (bulletTimer < 0.0f) {
        for (GameCharacter *object in listOfGameObjects) {
            if ([object tag] == kEnemyTagValue && [object state] != kStateDead)
            {
                [listOfEnemyObjects addObject: object];
            }
        }
        
        if ([listOfEnemyObjects count] == 0) {
            return;
        } else {
            float minimumDistance = [self distanceToTarget: [listOfEnemyObjects objectAtIndex: 0]];
            GameCharacter *enemyObjectToTarget = [listOfEnemyObjects objectAtIndex: 0];
            
            for (int i=1; i<[listOfEnemyObjects count]; i++)
            {
                float distanceToCompare = [self distanceToTarget: [listOfEnemyObjects objectAtIndex: i]];
                
                if (distanceToCompare < minimumDistance)
                {
                    enemyObjectToTarget = [listOfEnemyObjects objectAtIndex: i];
                    minimumDistance = distanceToCompare;
                }
            }
            
            if ([self distanceToTarget: enemyObjectToTarget] <= self.towerRange*(self.longshotEffect))
            {
                self.targetEnemy = enemyObjectToTarget;
                self.targetToShoot = enemyObjectToTarget.position;
                self.firingActive = YES;
                [self firingSequence];
            } else {
                return;
            }
        }
    } else {
        bulletTimer = bulletTimer - deltaTime;
    }
}

- (void) firingSequence {
    
    CCLOG(@"Tower: this method should be overridden; it should include a call to shootBullet");
}

- (void) shootBullet {
    
    self.bulletTimer = 1/(self.firingRate*self.overclockEffect);
    
    [delegate createBulletType: self.bulletType
           withInitialPosition: self.position
             andTargetPosition: self.targetEnemy.position
         andBulletDamageEffect: self.bulletDamageEffect
             andAccuracyEffect: self.bulletAccuracyEffect
                 andCritEffect: (self.critEffect + self.rageEffect)
             andTowerReference: self];
}

- (void) timeToShootBullet {
    self.firingActive = NO;
    self.shootBulletInUpdate = YES;
}

- (CGPoint) myPosition {
    return self.position;
}

- (void) activateProcEffect {
    
    PLAYSOUNDEFFECT(proc_sound);
    
    if (self.towerProcEffectSprite == nil) {
        self.towerProcEffectSprite = [CCSprite node];
        self.towerProcEffectSprite.zOrder = kGroundZOrder;
        self.towerProcEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                   spriteFrameByName: @"c3_proc_1.png"];
        
        self.towerProcEffectSprite.position = self.position;
        
        [self.delegate createEffect: self.towerProcEffectSprite];
    }
    
    [self.towerProcEffectSprite stopAllActions];
    
    // set the proc effect
    // set the bullet counts to 3
    self.procEffect = kProcEffect;
    self.procEffectTimer = kProcEffectTimer;
    self.procEffectBulletCount = kProcEffectBulletCount;
    self.towerProcEffectSprite.visible = YES;
    self.towerProcEffectSprite.opacity = 255;
    
    id actionAnimation = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache]
                                                          animationByName: @"c3_proc_"]];
    id actionForever = [CCRepeatForever actionWithAction: actionAnimation];
    
    [self.towerProcEffectSprite runAction: actionForever];
        
    // use bullet counts as the "timer" for the proc effect
}

- (void) activateTowerStatusEffect: (CastType) cType {
        
    if (self.towerStatusEffectSprite == nil) {
        
        self.towerStatusEffectSprite = [CCSprite node];
        self.towerStatusEffectSprite.zOrder = self.zOrder + 1;
        self.towerStatusEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                     spriteFrameByName: @"rage_effect_1.png"];
        
        //float offsetX = self.contentSize.width/3;
        float offsetY = self.contentSize.height/2;
        
        self.towerStatusEffectSprite.position = ccp(self.position.x, self.position.y + offsetY);
        
        [self.delegate createEffect: self.towerStatusEffectSprite];
    }
    
    // i don't think this variable does anything
    // should delete
    self.isTowerStatusEffectActive = YES;
    
    [self.towerStatusEffectSprite stopAllActions];
    self.towerStatusEffectSprite.scale = 1.0f;
    self.towerStatusEffectSprite.opacity = 255;
    float statusDuration;
    
    
    id action1;
    id actionFadeTo = [CCFadeTo actionWithDuration: 1.0f opacity: 0];
    id actionCallFunc = [CCCallFunc actionWithTarget: self selector: @selector(deactivateTowerStatusEffect)];

    switch (cType) {
            
        case kCastRage:
            PLAYSOUNDEFFECT(rage_sound);
            self.towerStatusEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                         spriteFrameByName: @"rage_effect_1.png"];
            statusDuration = kRageDuration;
            self.rageEffectTimer = kRageDuration;
            self.rageEffect = kRageEffect;
            
            id actionScaleUp2 = [CCScaleTo actionWithDuration: 0.25f scale: 1.2f];
            id actionScaleDown2 = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
            id actionSeq2 = [CCSequence actions: actionScaleUp2, actionScaleDown2, nil];
            id actionRepeat2 = [CCRepeat actionWithAction: actionSeq2 times: 2.0f*(kRageDuration-1.0f)];
            
            action1 = actionRepeat2;
            
            break;
            
        case kCastOverclock:
            PLAYSOUNDEFFECT(overclock_sound);
            self.towerStatusEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                         spriteFrameByName: @"overclock_effect_1.png"];
            self.towerStatusEffectSprite.scale = 0.8f;
            statusDuration = kOverclockDuration;
            self.overclockEffectTimer = kOverclockDuration;
            self.overclockEffect = kOverclockEffect;
            
            action1 = [CCRotateBy actionWithDuration: statusDuration - 1.0f angle: statusDuration*120];
            break;
            
        case kCastLongshot:
            PLAYSOUNDEFFECT(longshot_sound);
            self.towerStatusEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                         spriteFrameByName: @"longshot_effect_1.png"];
            statusDuration = kLongshotDuration;
            self.longshotEffectTimer = kLongshotDuration;
            self.longshotEffect = kLongshotEffect;
            self.towerStatusEffectSprite.scale = 0.95f;
            self.towerStatusEffectSprite.rotation = 0;
            
            id actionScaleUp = [CCScaleTo actionWithDuration: 0.25f scale: 1.2f];
            id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
            id actionSeq = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
            id actionRepeat = [CCRepeat actionWithAction: actionSeq times: 2.0f*(kLongshotDuration-1.0f)];
            
            action1 = actionRepeat;
            break;
            
        default:
            CCLOG(@"Tower: unrecognized status effect");
            break;
    }
    
    id actionSequence = [CCSequence actions: action1, actionFadeTo, actionCallFunc, nil];
    
    [self.towerStatusEffectSprite runAction: actionSequence];
}

- (void) deactivateTowerStatusEffect {
    
    self.isTowerStatusEffectActive = NO;
    
}

- (id) init
{
    if (self = [super init]) {
        self.objectType = kTowerType;
        self.buttonType = kTowerButton;
        self.tDelegate = self;
        self.menuSquishFactor = 0.99f;
        self.removeSignal = 0;
        self.firingActive = NO;
                
        self.bulletDamageEffect = 1.0f;
        self.bulletAccuracyEffect = 0.0f;
        self.critEffect = 0.0f;
        
        self.bulletDamageEffectUpgradeLevel = 0;
        self.bulletAccuracyEffectUpgradeLevel = 0;
        self.critEffectUpgradeLevel = 0; 
        
        self.maxString = [NSString stringWithFormat: @"MAX"];
        
        self.isTowerStatusEffectActive = NO;
        
        self.overclockEffect = 1.0f;
        self.longshotEffect = 1.0f;
        self.rageEffect = 0.0f;
        self.procEffect = 1.0f;
        self.procEffectBulletCount = 0;
        
        self.overclockEffectTimer = -1.0f;
        self.longshotEffectTimer = -1.0f;
        self.rageEffectTimer = -1.0f;
        self.procEffectTimer = -1.0f;
        
        self.bulletArray = [NSMutableArray array];
    }
    
    return self;
}

@end


















