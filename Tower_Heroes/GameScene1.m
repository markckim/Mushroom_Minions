//
//  GameScene1.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene1.h"
#import "BackgroundLayer.h"
#import "GamePlayLayer.h"
#import "ControlsLayer.h"
#import "TowerControlCastButton.h"
#import "TowerControlPowerSelectButton.h"
#import "TowerControlTowerSelectButton.h"
#import "TowerControlMenuButton.h"
#import "HelpLayer.h"

@implementation GameScene1

@synthesize bgLayer;
@synthesize gpLayer;
@synthesize coLayer;
@synthesize hLayer;

- (void) dealloc {
    
    self.bgLayer = nil;
    self.gpLayer = nil;
    self.coLayer = nil;
    self.hLayer = nil;
    
    [super dealloc];
    
}

- (void) showIntro {
    
    // pause the current layers
    [self.bgLayer onExit];
    [self.gpLayer onExit];
    [self.coLayer onExit];
    
    // show intro
    [self addChild: hLayer];
    
}

- (void) endIntro {
    
    [self removeChild: hLayer cleanup: YES];
    
    [self.bgLayer onEnter];
    [self.gpLayer onEnter];
    [self.coLayer onEnter];
}

- (id) init {
    if (self = [super init]) {
        
        // choose background music to play based on the level
        
        GameManager *m = [GameManager sharedGameManager];
        
        int level = m.selectedLevel;
        
        if (level >= 1 && level <= 4) {
            [m playBackgroundTrack: BACKGROUND_TRACK_SAND_THEME_1];
            m.backgroundMusicConstant = 2;
            
        } else if (level >= 5 && level <= 6) {
            [m playBackgroundTrack: BACKGROUND_TRACK_WATER_THEME_1];
            m.backgroundMusicConstant = 3;

        } else if (level >= 7 && level <= 10) {
            [m playBackgroundTrack: BACKGROUND_TRACK_SNOW_THEME_1];
            m.backgroundMusicConstant = 4;
            
        }
                        
        self.bgLayer = [BackgroundLayer node];
        [self addChild: bgLayer
                     z: 0
                   tag: 0];
        
        self.gpLayer = [[[GamePlayLayer alloc] initWithLayer: bgLayer] autorelease];
        [self addChild: gpLayer 
                     z: 1 
                   tag: 1];
        
        self.coLayer = [[[ControlsLayer alloc] initWithLayer: gpLayer] autorelease];
        [self addChild: coLayer
                     z: 2
                   tag: 2];
        
        self.hLayer = [HelpLayer node];
        self.hLayer.gs1_reference = self;
        self.hLayer.zOrder = 9999;
        
        // initialize references
        gpLayer.controlsLayer = coLayer;
        gpLayer.gs1_reference = self;
        
        coLayer.powerOneControl.gamePlayLayer = gpLayer;
        coLayer.powerTwoControl.gamePlayLayer = gpLayer;
        coLayer.powerThreeControl.gamePlayLayer = gpLayer;
        coLayer.powerFourControl.gamePlayLayer = gpLayer;
        coLayer.powerFiveControl.gamePlayLayer = gpLayer;
        coLayer.powerSixControl.gamePlayLayer = gpLayer;
        
        coLayer.bulletDamageMenuButton.gamePlayLayer = gpLayer;
        coLayer.bulletAccuracyMenuButton.gamePlayLayer = gpLayer;
        coLayer.critValueMenuButton.gamePlayLayer = gpLayer;
        coLayer.towerRemoveMenuButton.gamePlayLayer = gpLayer;
        coLayer.insertYesMenuButton.gamePlayLayer = gpLayer;
        coLayer.insertNoMenuButton.gamePlayLayer = gpLayer;
        coLayer.deleteYesMenuButton.gamePlayLayer = gpLayer;
        coLayer.deleteNoMenuButton.gamePlayLayer = gpLayer;
        
        coLayer.towerStandardControl.gamePlayLayer = gpLayer;
        coLayer.towerIceControl.gamePlayLayer = gpLayer;
        coLayer.towerBombControl.gamePlayLayer = gpLayer;
                
        m.numberOfLives = STARTING_LIVES;
        m.controlsLayer = coLayer;
        m.gs1_reference = self;        
    }
    
    return self;
    
} // init

- (void) onEnter {
    
    // prevents application from auto-dimming during gameplay
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    [super onEnter];
}

- (void) onExit {
    
    // restores application's ability for auto-dimming once player has exited gameplay
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    [super onExit];
}

@end









