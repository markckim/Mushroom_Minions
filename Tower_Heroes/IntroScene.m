//
//  IntroScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntroScene.h"
#import "IntroLayer.h"

@implementation IntroScene

- (id) init
{
    if (self = [super init]) {
        [self addChild: [IntroLayer node]];
    }
    
    return self;
}

@end
