//
//  PauseScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseScene.h"
#import "PauseLayer.h"

@implementation PauseScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [PauseLayer node]];
    }
    return self;
}

@end
