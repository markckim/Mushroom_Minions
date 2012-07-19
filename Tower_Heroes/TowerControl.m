//
//  TowerControl.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControl.h"
#import "TowerStandard.h"
#import "TowerIce.h"
#import "TowerBomb.h"
#import "ControlsLayer.h"
#import "GamePlayLayer.h"
#import "TowerControlMenuButton.h"
#import "TowerControlCastButton.h"

@implementation TowerControl

@synthesize controlsLayer;
@synthesize gamePlayLayer;
@synthesize dragSpriteName;
@synthesize tDelegate;

@synthesize isActive;
@synthesize touchState;
@synthesize originalPosition;
@synthesize buttonType;
@synthesize expandDuration;
@synthesize expandFactor;
@synthesize shrinkDuration;

@synthesize normalSprite;
@synthesize selectedSprite;

- (void) dealloc {
    
    self.controlsLayer = nil;
    self.gamePlayLayer = nil;
    self.dragSpriteName = nil;
    self.tDelegate = nil;
    
    self.normalSprite = nil;
    self.selectedSprite = nil;
    
    [super dealloc];
}

- (void) onEnter {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate: self priority: 10 swallowsTouches: YES];
    [super onEnter];
}

- (void) onExit {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate: self];
    [super onExit];
}

- (CGRect) rect {
    CGSize s = [self contentSize];
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (BOOL) containsTouchLocation: (UITouch *) touch {
    return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL) touchLogic: (UITouch *) touch {
    
    
    if (self.buttonType == kCastButton && self.isActive == YES) {
                
        TowerControlCastButton *tccb = (TowerControlCastButton *) self;
        
        if (tccb.disabledSprite.visible == YES) {            
            return NO;
        }
        
    }
    
    if ([self containsTouchLocation: touch] && self.buttonType == kTowerMenuButton && self.isActive == YES) {
        [self selected];
        return YES;
    }
    
    if ([self containsTouchLocation: touch] && self.isActive == YES) {
        if (self.controlsLayer.selectedTowerControl == nil) {
            [self selected];
            return YES;
        } else if (self.controlsLayer.selectedTowerControl != nil && self.controlsLayer.selectedTowerControl != self.tDelegate) {
            // do nothing
        } else if (self.controlsLayer.selectedTowerControl == self.tDelegate) {
            [self unselected];
            return YES;
        }
    } else if (![self containsTouchLocation: touch] && self.isActive == YES) {
        if (self.controlsLayer.selectedTowerControl != self) {
            // do nothing
        } else if (self.controlsLayer.selectedTowerControl == self) {
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            [tmpArray addObjectsFromArray: self.controlsLayer.towerControls];
            [tmpArray addObjectsFromArray: self.gamePlayLayer.towerDelegateCollection];
            
            for (id <TowerControlDelegate> tc in tmpArray) {
                if (tc != self.tDelegate) {
                    CGPoint touchLocation = [touch locationInView: [touch view]];
                    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
                    
                    if (CGRectContainsPoint(tc.boundingBox, touchLocation) && tc.isActive == YES) {
                        
                        if (tc.buttonType == kTowerButton && self.buttonType == kCastButton) {
                            
                            [self castWithTouchLocation: touchLocation];
                            [self unselected];
                            return YES;
                        }
                        
                        // note: the isActive variable is important here
                        // isActive is set to NO if the button is currently disabled
                        // via Power/Tower select buttons
                        [self unselected];
                        [tc selected];
                                                                        
                        if (tc.buttonType == kTowerButton) {
                            Tower *tmpTower = (Tower *) tc;
                            [tmpTower menuAppear];
                        }
                        return YES;
                    }
                }
            }
            if (self.buttonType == kCastButton) {
                self.touchState = kStateGrabbed;
                
                CGPoint touchLocation = [touch locationInView: [touch view]];
                touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
                id actionExpand = [CCScaleTo actionWithDuration: self.expandDuration scale: self.expandFactor];
                id actionShrink = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 1.0f];
                id actionSequence = [CCSequence actions: actionExpand, actionShrink, nil];
                
                self.controlsLayer.cSprite = [CCSprite spriteWithSpriteFrameName: self.dragSpriteName];
                self.controlsLayer.cSprite.scale = 1.3f;
                self.controlsLayer.cSprite.opacity = 150;
                self.controlsLayer.cSprite.position = touchLocation;
                [self.controlsLayer.cSprite runAction: [CCRepeatForever actionWithAction: actionSequence]];
                [self.controlsLayer addChild: self.controlsLayer.cSprite];
                
                return YES;
            } else if (self.buttonType != kCastButton) {
                [self unselected];
            }
        }
    }
    return NO;
}

- (BOOL) ccTouchBegan: (UITouch *) touch withEvent: (UIEvent *) event {
    
    return [self touchLogic: touch];
}

- (void) ccTouchMoved: (UITouch *) touch withEvent: (UIEvent *) event {
    
    if (self.touchState == kStateGrabbed) {    
        if (self.buttonType == kCastButton) {
            
            TowerControlCastButton *tc = (TowerControlCastButton *) self;
            
            if (tc.objectType == kTowerType) {
                tc.controlsLayer.isInsertTowerMenuActive = YES;
            }
            
            CGPoint touchLocation = [touch locationInView: [touch view]];
            touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
            self.controlsLayer.cSprite.position = touchLocation;
        }
    }
}

- (void) ccTouchEnded: (UITouch *) touch withEvent: (UIEvent *) event {
    
    if (self.touchState == kStateGrabbed) {
        self.touchState = kStateReset;
        
        CGPoint touchLocation = [touch locationInView: [touch view]];
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        
        if (self.buttonType == kCastButton) {
            [self castWithTouchLocation: touchLocation];
        } else if (self.buttonType == kTowerMenuButton) {
            if ([self containsTouchLocation: touch]) {
                [self castWithTouchLocation: touchLocation];
            }
        }
        [self unselected];
    }    
}

- (void) selected {
    CCLOG(@"selected method: this will be overrided by subclasses");
}

- (void) castWithTouchLocation: (CGPoint) touchLocation {
    CCLOG(@"cast method: this will be overrided by subclasses");
}

- (void) unselected {
    CCLOG(@"unselected method: this will be overrided by subclasses");
}

- (id) init {
    if (self = [super init]) {
        self.isActive = YES;
        self.tDelegate = self;
        self.expandDuration = 0.1f;
        self.expandFactor = 1.2f;
        self.shrinkDuration = 0.15f;
    }
    return self;
}

@end














