//
//  GameScene1.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BackgroundLayer;
@class GamePlayLayer;
@class ControlsLayer;
@class HelpLayer;

@interface GameScene1 : CCScene

@property (nonatomic, strong) BackgroundLayer *bgLayer;
@property (nonatomic, strong) GamePlayLayer *gpLayer;
@property (nonatomic, strong) ControlsLayer *coLayer;
@property (nonatomic, strong) HelpLayer *hLayer;

- (void) showIntro;
- (void) endIntro;

@end