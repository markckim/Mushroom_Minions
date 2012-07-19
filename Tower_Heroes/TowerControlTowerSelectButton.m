//
//  TowerControlTowerSelectButton.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControlTowerSelectButton.h"
#import "TowerControlCastButton.h"
#import "GamePlayLayer.h"
#import "ControlsLayer.h"

@implementation TowerControlTowerSelectButton

@synthesize listOfCastButtons;

@synthesize buttonState;
@synthesize isInitialized;

- (void) dealloc {
    
    self.listOfCastButtons = nil;
    
    [super dealloc];
}

- (void) selected {    
    id actionExpand = [CCScaleTo actionWithDuration: self.expandDuration scale: self.expandFactor];
    id actionShrink = [CCScaleTo actionWithDuration: self.shrinkDuration scale: 1.0f];
    id actionSequence = [CCSequence actions: actionExpand, actionShrink, nil];
    [self runAction: actionSequence];
    
    self.controlsLayer.selectedTowerControl = nil;
    
    if (self.isInitialized == NO) {
        self.isInitialized = YES;
        
        for (TowerControl *tc in listOfCastButtons) {
            [self.controlsLayer addChild: tc 
                                       z: 1 
                                     tag: kControlTagValue];
        }        
        return;
    }
    
    if (self.buttonState == NO) {
        self.buttonState = YES;
        
        for (TowerControl *tc in listOfCastButtons) {
            tc.scale = 1.0f;
            tc.visible = NO;
            tc.isActive = NO;
            //[[[CCDirector sharedDirector] touchDispatcher] removeDelegate: tc];
        }
    } else if (self.buttonState == YES) {
        self.buttonState = NO;
        
        for (TowerControl *tc in listOfCastButtons) {
            tc.visible = YES;
            tc.isActive = YES;
            //[[[CCDirector sharedDirector] touchDispatcher] 
             //addTargetedDelegate: tc priority: 0 swallowsTouches: YES];
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
        self.buttonType = kMenuButton;
        self.buttonState = NO;
        self.isInitialized = NO;
    }
    return self;
}

- (id) initWithSpriteName: (NSString *) spriteName andListOfCastButtons: (NSMutableArray *) cButtons {
    if (self = [super init]) {
        self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: spriteName];
        self.buttonType = NO;
        self.buttonState = NO;
        self.isInitialized = NO;
        self.listOfCastButtons = [NSMutableArray arrayWithArray: cButtons];
    }
    return self;
}

+ (id) buttonWithSpriteName: (NSString *) spriteName {
    return [[[self alloc] initWithSpriteName: spriteName] autorelease];
}

+ (id) buttonWithSpriteName: (NSString *) spriteName andListOfCastButtons: (NSMutableArray *) cButtons {
    return [[[self alloc] initWithSpriteName: spriteName andListOfCastButtons: cButtons] autorelease];
}

@end


















