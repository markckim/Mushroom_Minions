//
//  PlayScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayScene.h"
#import "PlayLayer.h"

@implementation PlayScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [PlayLayer node]];
    }
    return self;
}

@end
