//
//  TowerControlCastButton.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControlCastButton.h"
#import "ControlsLayer.h"
#import "GamePlayLayer.h"
#import "BackgroundLayer.h"
#import "TowerPlacement.h"
#import "Tower.h"

@implementation TowerControlCastButton

@synthesize objectType;
@synthesize towerType;
@synthesize bulletType;
@synthesize disabledSprite;
@synthesize disabledSpriteName;
@synthesize delegate;
@synthesize castType;

@synthesize descriptionLabel;

- (void) dealloc {
    
    self.disabledSprite = nil;
    self.disabledSpriteName = nil;
    self.delegate = nil;
    
    self.descriptionLabel = nil;
    
    [super dealloc];
}

- (void) selected {
    
    PLAYSOUNDEFFECT(select_power_sound);
    
    if (self.disabledSprite.visible == YES) {
        
        if (self.controlsLayer.isInsertTowerMenuActive == YES) {
            [self.controlsLayer insertTowerMenuDisappear];
        }
        
        return;
    }
    
    self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                         spriteFrameByName: selectedSprite];
    
    id action = [CCScaleTo actionWithDuration: self.expandDuration scale: self.expandFactor];
    [self runAction: action];
    
    if  (self.controlsLayer.isInsertTowerMenuActive == YES) {
        [self.controlsLayer insertTowerMenuDisappear];
    }
    
    if (self.controlsLayer.towerBounds.visible == YES) {
        self.controlsLayer.towerBounds.visible = NO;
        
    }
    
    self.controlsLayer.selectedTowerControl = self.tDelegate;
    
    if (self.objectType == kTowerType) {
                
        // check which cost label should be expanded
        
        id actionScaleLabel = [CCScaleTo actionWithDuration: self.expandDuration scale: 1.1f];
        
        if (self.towerType == kTowerStandard) {
            [self.controlsLayer.towerStandardCostLabel runAction: actionScaleLabel];
        } else if (self.towerType == kTowerIce) {
            [self.controlsLayer.towerIceCostLabel runAction: actionScaleLabel];
        } else if (self.towerType == kTowerBomb) {
            [self.controlsLayer.towerBombCostLabel runAction: actionScaleLabel];
        }
        
        for (TowerPlacement *s in self.gamePlayLayer.towerPlacementSprites) {
            
            if (s.isActive == YES) {
                s.visible = YES;
            }            
        }
        
        for (id <TowerControlDelegate> tDel in self.gamePlayLayer.towerDelegateCollection) {
            
            // show tower personal space
            if (tDel.buttonType == kTowerButton) {
                [tDel showTowerPersonalSpace];
            }
        }
    } else if (self.objectType == kBulletType) {
        
        if (self.castType == kCastRage || self.castType == kCastOverclock || self.castType == kCastLongshot) {
            
            // show tower personal space
            for (id <TowerControlDelegate> tDel in self.gamePlayLayer.towerDelegateCollection) {
                
                if (tDel.buttonType == kTowerButton) {
                    [tDel showTowerPersonalSpace];
                }
            }
        }
        
    }
}

- (void) castWithTouchLocation: (CGPoint) touchLocation {
    
    if (self.objectType == kTowerType) {
        
        for (TowerPlacement *s in self.gamePlayLayer.towerPlacementSprites) {
            
            // if touch intersects with a tower placement point
            if (CGRectContainsPoint(s.boundingBox,touchLocation)) {
                
                if (s.isActive == YES) {
                    
                    // ask if player wants to insert the tower here
                    [self.controlsLayer insertTowerMenuAppear: s.position 
                                                withTowerType: self.towerType
                                        andPlacementReference: s];
                    return;
                    
                }                
            }
        }
        
        // touch doesn't intersect with any of the tower placement points
        // self.gamePlayLayer.backgroundLayer.tileMap.visible = NO;
        return;
                        
    } else if (self.objectType == kBulletType) {
        
        if (self.castType == kCastRage || self.castType == kCastOverclock || self.castType == kCastLongshot) {
            
            // check to see if a tower is touching touchlocation
            
            // otherwise, do nothing
            
            GameManager *m = [GameManager sharedGameManager];
            NSMutableDictionary *tD = m.selectedHero.talentTree;
            
            for (id <TowerControlDelegate> tDel in self.gamePlayLayer.towerDelegateCollection) {
                
                if (tDel.buttonType == kTowerButton) {
                    float deltaX = [tDel myPosition].x - touchLocation.x;
                    float deltaY = [tDel myPosition].y - touchLocation.y;
                    float distance = sqrt(pow(deltaX,2) + pow(deltaY,2));
                    
                    // if touch is within a close distance to the tower, activate the status effect
                    if (distance < (0.75)*TOWER_PERSONAL_SPACE_RADIUS) {
                        
                        [tDel activateTowerStatusEffect: self.castType];
                        
                        if (self.castType == kCastRage) {
                            self.gamePlayLayer.powerButtonTimer = kPowerOneDuration - ((float)[[tD objectForKey: @"ImprovedRage"] intValue]);
                        } else if (self.castType == kCastOverclock) {
                            self.gamePlayLayer.powerButtonTimer = kPowerOneDuration - ((float)[[tD objectForKey: @"TowerCooling"] intValue]);
                        } else if (self.castType == kCastLongshot) {
                            self.gamePlayLayer.powerButtonTimer = kPowerTwoDuration;
                        }
                        [self.controlsLayer checkToDisablePowers];

                    }
                }
                
            }
            
        } else {
            [delegate createBulletCastWithPosition: touchLocation
                                       andCastType: self.castType];
        }        
    }
}

- (void) unselected {
        
    self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                         spriteFrameByName: normalSprite];
    
    [self.controlsLayer.cSprite removeFromParentAndCleanup: YES];
    
    id action = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 1.0f];
    [self runAction: action];
    
    if (self.objectType == kTowerType) {
        for (id <TowerControlDelegate> tDel in self.gamePlayLayer.towerDelegateCollection) {
            
            if (tDel.buttonType == kTowerButton) {
                [tDel hideTowerPersonalSpace];
            }
        }
        
        // check which cost label should be expanded
        
        id actionScaleLabel = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 0.9f];
        
        if (self.towerType == kTowerStandard) {
            [self.controlsLayer.towerStandardCostLabel runAction: actionScaleLabel];
        } else if (self.towerType == kTowerIce) {
            [self.controlsLayer.towerIceCostLabel runAction: actionScaleLabel];
        } else if (self.towerType == kTowerBomb) {
            [self.controlsLayer.towerBombCostLabel runAction: actionScaleLabel];
        }
        
    } else if (self.objectType == kBulletType) {
        if (self.castType == kCastRage || self.castType == kCastOverclock || self.castType == kCastLongshot) {
            for (id <TowerControlDelegate> tDel in self.gamePlayLayer.towerDelegateCollection) {
                
                if (tDel.buttonType == kTowerButton) {
                    [tDel hideTowerPersonalSpace];
                }
            }
        }
    }
    
    // MODIFIED
    for (TowerPlacement *s in self.gamePlayLayer.towerPlacementSprites) {
        s.visible = NO;
    }
    
    /*
    if (self.controlsLayer.isInsertTowerMenuActive == NO) {
        self.gamePlayLayer.backgroundLayer.tileMap.visible = NO;
    }
    */
    
    self.controlsLayer.selectedTowerControl = nil;
}

- (id) initWithSpriteName: (NSString *) spriteName
        andDragSpriteName: (NSString *) dSpriteName
            andObjectType: (ObjectType) oType 
             andTowerType: (TowerType) tType {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: spriteName];
        self.dragSpriteName = dSpriteName;
        self.objectType = oType;
        self.towerType = tType;
        self.buttonType = kCastButton;
        
        self.normalSprite = spriteName;
    }
    return self;
}

- (id) initWithSpriteName: (NSString *) spriteName
        andDragSpriteName: (NSString *) dSpriteName
            andObjectType: (ObjectType) oType 
            andBulletType: (BulletType) bType 
              andCastType: (CastType) cType {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: spriteName];
        self.dragSpriteName = dSpriteName;
        self.objectType = oType;
        self.bulletType = bType;
        self.buttonType = kCastButton;
        self.castType = cType;
        
        self.normalSprite = spriteName;
    }
    return self;
}

+ (id) buttonWithSpriteName: (NSString *) spriteName 
          andDragSpriteName: (NSString *) dSpriteName
              andObjectType: (ObjectType) oType 
               andTowerType: (TowerType) tType {
    return [[[self alloc] initWithSpriteName: spriteName andDragSpriteName: dSpriteName 
                               andObjectType: oType andTowerType: tType] autorelease];
}

+ (id) buttonWithSpriteName: (NSString *) spriteName 
          andDragSpriteName: (NSString *) dSpriteName
              andObjectType: (ObjectType) oType 
              andBulletType: (BulletType) bType 
                andCastType: (CastType) cType {
    return [[[self alloc] initWithSpriteName: spriteName andDragSpriteName: dSpriteName 
                               andObjectType: oType andBulletType: bType andCastType: cType] autorelease];
}

@end

















