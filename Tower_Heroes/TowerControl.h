//
//  TowerControl.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameCharacter.h"

@class ControlsLayer;
@class GamePlayLayer;
@class TowerStandard;
@class TowerIce;
@class TowerBomb;

@interface TowerControl : CCSprite <TowerControlDelegate, CCTargetedTouchDelegate> {    
    NSString *dragSpriteName;
    ControlsLayer *controlsLayer;
    GamePlayLayer *gamePlayLayer;
    id <TowerControlDelegate> tDelegate;

    BOOL isActive;
    CGPoint originalPosition;
    TouchState touchState;
    ButtonType buttonType;   
    float expandDuration;
    float expandFactor;
    float shrinkDuration;
    
    NSString *normalSprite;
    NSString *selectedSprite;
}

@property (nonatomic, assign) ControlsLayer *controlsLayer;
@property (nonatomic, assign) GamePlayLayer *gamePlayLayer;
@property (nonatomic, strong) NSString *dragSpriteName;
@property (nonatomic, assign) id <TowerControlDelegate> tDelegate;

@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) CGPoint originalPosition;
@property (nonatomic, assign) TouchState touchState;
@property (nonatomic, assign) ButtonType buttonType;
@property (nonatomic, assign) float expandDuration;
@property (nonatomic, assign) float expandFactor;
@property (nonatomic, assign) float shrinkDuration;

@property (nonatomic, copy) NSString *normalSprite;
@property (nonatomic, copy) NSString *selectedSprite;

- (BOOL) touchLogic: (UITouch *) touch;
- (BOOL) containsTouchLocation:(UITouch *)touch;
- (CGRect) rect;
- (void) selected;
- (void) castWithTouchLocation: (CGPoint) pointLocation;
- (void) unselected;

@end






