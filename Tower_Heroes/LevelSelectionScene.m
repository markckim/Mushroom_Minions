//
//  LevelSelectionScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectionScene.h"
#import "LevelSelectionLayer.h"

@implementation LevelSelectionScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [LevelSelectionLayer node]];
    }
    return self;
}

@end
