//
//  CharacterScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterSelectionScene.h"
#import "CharacterSelectionLayer.h"

@implementation CharacterSelectionScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [CharacterSelectionLayer node]];
    }
    return self;
}

@end
