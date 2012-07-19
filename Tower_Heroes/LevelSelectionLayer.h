//
//  LevelSelectionLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@interface LevelSelectionLayer : GameLayer

- (void) insertLevelSelectionMenu;

- (void) loadingSceneWithLevel: (id) sender;
- (void) backScene;

@end
