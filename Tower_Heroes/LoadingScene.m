//
//  LoadingScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingScene.h"
#import "LoadingLayer.h"

@implementation LoadingScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [LoadingLayer node]];
    }
    return self;
}

@end
