//
//  TowerControlMenuButton.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControlMenuButton.h"
#import "ControlsLayer.h"
#import "GamePlayLayer.h"
#import "TowerControlCastButton.h"
#import "BackgroundLayer.h"
#import "Tower.h"

@implementation TowerControlMenuButton

@synthesize modifierType;
@synthesize sceneType;
@synthesize towerType;
@synthesize costSprite;
@synthesize costLabel;
@synthesize disabledSprite;
@synthesize towerPlacement;

@synthesize menuLabel;
@synthesize statsLabel;

- (void) dealloc {
    
    self.costSprite = nil;
    self.costLabel = nil;
    self.disabledSprite = nil;
    self.towerPlacement = nil;
    
    self.menuLabel = nil;
    self.statsLabel = nil;
    
    [super dealloc];
}

- (void) selected {
    
    // if player can't afford the upgrade, then return
    if (self.disabledSprite.visible == YES) {
        return;
    }
    
    float menuLabelScale = 0.7f;
            
    if (self.modifierType == kSelectScene) {
        self.touchState = kStateGrabbed;
        return;
    }
    
    if (self.modifierType == kBulletDamage || self.modifierType == kBulletAccuracy || self.modifierType == kCritValue) {
        id actionExpand = [CCScaleTo actionWithDuration: self.expandDuration scale: self.expandFactor];
        id actionShrink = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 1.0f];
        id actionSequence = [CCSequence actions: actionExpand, actionShrink, nil];
        
        id actionExpand2 = [CCScaleTo actionWithDuration: self.expandDuration scale: self.expandFactor*menuLabelScale];
        id actionShrink2 = [CCScaleTo actionWithDuration: self.shrinkDuration scale: menuLabelScale];
        id actionSequence2 = [CCSequence actions: actionExpand2, actionShrink2, nil];
        
        id actionExpand3 = [CCScaleTo actionWithDuration: self.expandDuration scale: self.expandFactor];
        id actionShrink3 = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 1.0f];
        id actionSequence3 = [CCSequence actions: actionExpand3, actionShrink3, nil];
        
        [self runAction: actionSequence];
        [self.menuLabel runAction: actionSequence2];
        [self.statsLabel runAction: actionSequence3];
    }
    
    Tower *t = (Tower *) self.controlsLayer.selectedTowerControl;
    
    switch (self.modifierType) {
        
        case kBulletDamage:            
            [t upgradeBulletDamageEffect: 1];
            //CCLOG(@"Button: new Damage: %f", t.bulletDamageEffect);
            break;
            
        case kBulletAccuracy:
            [t upgradeBulletAccuracyEffect: 0.05f];
            //CCLOG(@"Button: new accuracy: %f", t.bulletAccuracyEffect);
            break;
            
        case kCritValue:
            [t upgradeCritEffect: 0.05f];
            //CCLOG(@"Button: new crit: %f", t.critEffect);
            break;
            
        case kTowerRemove:
            PLAYSOUNDEFFECT(tower_remove_button_sound);
            [t menuDisappearFromTowerRemove];
            [self.controlsLayer insertTowerMenuAppear: t.position];
            break;
            
        case kSelectScene:
            //[[GameManager sharedGameManager] pushSceneWithID: sceneType];
            break;
            
        case kInsertYes:
            PLAYSOUNDEFFECT(select_power_sound);
            [self.gamePlayLayer createTowerType: self.controlsLayer.insertYesMenuButton.towerType
                            withInitialPosition: self.controlsLayer.towerBounds.position
                          andPlacementReference: self.towerPlacement];
            [self.controlsLayer.sSprite removeFromParentAndCleanup: YES];
            [self.controlsLayer insertTowerMenuDisappear];
            self.controlsLayer.towerBounds.visible = NO;
            break;
            
        case kInsertNo:
            PLAYSOUNDEFFECT(select_power_sound);
            [self.controlsLayer.sSprite removeFromParentAndCleanup: YES];
            [self.controlsLayer insertTowerMenuDisappear];
            self.controlsLayer.towerBounds.visible = NO;
            break;
            
        case kDeleteYes:
            PLAYSOUNDEFFECT(tower_remove_sound);
            t.removeSignal = 1;
            
            [self.controlsLayer insertTowerMenuDisappear];
            self.controlsLayer.towerBounds.visible = NO;
            int sellValue = (int) (SELL_VALUE_MULTIPLIER*((float) t.towerTotalValue) + 0.5f);
            [self.gamePlayLayer receiveCoins: sellValue];
            
            self.controlsLayer.selectedTowerControl = nil;
            break;
            
        case kDeleteNo:
            PLAYSOUNDEFFECT(select_power_sound);
            //[t menuDisappear];
            [t unselected];
            [self.controlsLayer insertTowerMenuDisappear];
            self.controlsLayer.towerBounds.visible = NO;
            break;
            
        default:
            CCLOG(@"TowerControlMenuButton: not recognized");
            break;
    }
}

- (void) castWithTouchLocation: (CGPoint) pointLocation {
        
    [[GameManager sharedGameManager] pushSceneWithID: sceneType];
}

- (void) unselected {
    id actionShrink = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 1.0f];
    [self runAction: actionShrink];
}

- (id) initWithSpriteName: (NSString *) spriteName andModifierType: (ModifierType) mType {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: spriteName];
        self.modifierType = mType;
        self.buttonType = kTowerMenuButton;
    }
    return self;
}

- (id) initWithSpriteName: (NSString *) spriteName 
          andModifierType: (ModifierType) mType 
             andSceneType: (SceneType) sType {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: spriteName];
        self.modifierType = mType;
        self.buttonType = kTowerMenuButton;
        self.sceneType = sType;
    }
    return self;
}

+ (id) buttonWithSpriteName: (NSString *) spriteName 
            andModifierType: (ModifierType) mType {
    return [[[self alloc] initWithSpriteName: spriteName 
                             andModifierType: mType] autorelease];
}

+ (id) buttonWithSpriteName: (NSString *) spriteName 
            andModifierType: (ModifierType) mType 
               andSceneType: (SceneType) sType {
    return [[[self alloc] initWithSpriteName: spriteName 
                             andModifierType: mType 
                                andSceneType: sType] autorelease];
}


@end









