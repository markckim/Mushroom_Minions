//
//  TowerControlPowerSelectButton.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControlPowerSelectButton.h"
#import "TowerControlCastButton.h"
#import "ControlsLayer.h"

@implementation TowerControlPowerSelectButton

@synthesize listOfPowerButtons;
@synthesize listOfOptionButtons;

@synthesize buttonState;
@synthesize isInitialized;

- (void) dealloc {
    
    self.listOfPowerButtons = nil;
    self.listOfOptionButtons = nil;
    
    [super dealloc];
}

- (void) selected {
    
    PLAYSOUNDEFFECT(power_select_button_sound);
    
    if  (self.controlsLayer.isInsertTowerMenuActive == YES) {
        [self.controlsLayer insertTowerMenuDisappear];
    }
    
    id actionExpand = [CCScaleTo actionWithDuration: self.expandDuration scale: self.expandFactor];
    id actionShrink = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 1.0f];
    id actionSequence = [CCSequence actions: actionExpand, actionShrink, nil];
    [self runAction: actionSequence];
    
    if (self.controlsLayer.towerBounds.visible == YES) {
        self.controlsLayer.towerBounds.visible = NO;
        
    }
    
    self.controlsLayer.selectedTowerControl = nil;
    
    if (self.isInitialized == NO) {
        self.isInitialized = YES;
        
        for (TowerControlCastButton *tc in listOfPowerButtons) {
            
            [self.controlsLayer addChild: tc
                                       z: 1
                                     tag: kControlTagValue];
        }
        
        // make the tower cost labels visible
        self.controlsLayer.towerStandardCostLabel.visible = YES;
        self.controlsLayer.towerIceCostLabel.visible = YES;
        self.controlsLayer.towerBombCostLabel.visible = YES;

        for (TowerControlCastButton *tc in listOfOptionButtons) {
            [self.controlsLayer addChild: tc
                                       z: 0
                                     tag: kControlTagValue];
            tc.visible = NO;
            tc.isActive = NO;
            
            //[[[CCDirector sharedDirector] touchDispatcher] removeDelegate: tc];
        }
        return;
    }
    
    if (self.buttonState == NO) {
        self.buttonState = YES;
                
        for (TowerControlCastButton *tc in listOfPowerButtons) {
            tc.zOrder = -1;
            tc.scale = 1.0f;
            tc.visible = NO;
            tc.isActive = NO;
            
            if (tc.disabledSprite != nil) {
                tc.disabledSprite.visible = NO;
            }
            
            //[[[CCDirector sharedDirector] touchDispatcher] removeDelegate: tc];
        }
        
        // make the tower cost labels not visible
        self.controlsLayer.towerStandardCostLabel.visible = NO;
        self.controlsLayer.towerIceCostLabel.visible = NO;
        self.controlsLayer.towerBombCostLabel.visible = NO;
        
        for (TowerControlCastButton *tc in listOfOptionButtons) {
            tc.visible = YES;
            tc.isActive = YES;
            
            if (tc.disabledSprite != nil) {
                
                // this checks to disable 
                [self.controlsLayer checkToDisablePowers];
            }
            
            //[[[CCDirector sharedDirector] touchDispatcher] 
             //addTargetedDelegate: tc priority: 0 swallowsTouches: YES];
        }
    } else if (self.buttonState == YES) {
        self.buttonState = NO;
        

        for (TowerControlCastButton *tc in listOfPowerButtons) {
            tc.zOrder = 1;
            tc.visible = YES;
            tc.isActive = YES;
            
            if (tc.disabledSprite != nil) {
                [self.controlsLayer checkToDisableTowerPurchasing];
            }

            //[[[CCDirector sharedDirector] touchDispatcher] 
             //addTargetedDelegate: tc priority: 0 swallowsTouches: YES];
        }
        
        // make the tower cost labels visible
        self.controlsLayer.towerStandardCostLabel.visible = YES;
        self.controlsLayer.towerIceCostLabel.visible = YES;
        self.controlsLayer.towerBombCostLabel.visible = YES;
        
        for (TowerControlCastButton *tc in listOfOptionButtons) {
            tc.scale = 1.0f;
            tc.visible = NO;
            tc.isActive = NO;
            
            if (tc.disabledSprite != nil) {
                tc.disabledSprite.visible = NO;
            }
            
            //[[[CCDirector sharedDirector] touchDispatcher] removeDelegate: tc];
        }
        
        if (self.controlsLayer.powerOneCooldownLabel != nil) {
            
            self.controlsLayer.powerOneCooldownLabel.visible = NO;
            self.controlsLayer.powerTwoCooldownLabel.visible = NO;
            self.controlsLayer.powerThreeCooldownLabel.visible = NO;

        }
    }
}

- (void) castWithTouchLocation: (CGPoint) touchLocation {
    CCLOG(@"TowerControlTowerSelectButton, castWithTouchLocation method: ERROR, if called");
}

- (void) unselected {
    CCLOG(@"TowerControlTowerSelectButton, unselected method: ERROR, if called");    
}

- (id) initWithSpriteName: (NSString *) spriteName {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: spriteName];
        self.buttonState = NO;
        self.buttonType = kMenuButton;
        self.isInitialized = NO;
    }
    return self;
}

- (id) initWithSpriteName: (NSString *) spriteName 
    andListOfPowerButtons: (CCArray *) pButtons 
   andListOfOptionButtons: (CCArray *) oButtons {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                             spriteFrameByName: spriteName];
        self.listOfPowerButtons = [CCArray arrayWithArray: pButtons];
        self.listOfOptionButtons = [CCArray arrayWithArray: oButtons];
        self.buttonState = NO;
        self.buttonType = kMenuButton;
        self.isInitialized = NO;
        
    }
    return self;
}

+ (id) buttonWithSpriteName: (NSString *) spriteName {
    return [[[self alloc] initWithSpriteName: spriteName] autorelease];
    
}

+ (id) buttonWithSpriteName: (NSString *) spriteName 
      andListOfPowerButtons: (CCArray *) pButtons 
     andListOfOptionButtons: (CCArray *) oButtons {
    return [[[self alloc] initWithSpriteName: spriteName 
                       andListOfPowerButtons: pButtons 
                      andListOfOptionButtons: oButtons] autorelease];
}

@end


















