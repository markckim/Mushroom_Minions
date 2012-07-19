//
//  HelpLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@class GameScene1;

@interface HelpLayer : GameLayer

@property (nonatomic, strong) CCMenuItemSprite *leftButton;
@property (nonatomic, strong) CCMenuItemSprite *rightButton;

@property (nonatomic, assign) GameScene1 *gs1_reference;

@property (nonatomic, strong) CCSprite *pageSprite1;
@property (nonatomic, strong) CCSprite *pageSprite2;
@property (nonatomic, strong) CCSprite *pageSprite3;
@property (nonatomic, strong) CCSprite *pageSprite4;
@property (nonatomic, strong) CCSprite *pageSprite5;

@property (nonatomic, strong) NSArray *arrayOfSprites;

- (void) goToPage: (CCMenuItemSprite *) sender;
- (void) chooseVisibleSpriteFromArray: (int) index;


@end





