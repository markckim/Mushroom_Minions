//
//  TalentScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TalentScene.h"
#import "TalentLayer.h"

@implementation TalentScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [TalentLayer node]];
    }
    return self;
}

@end
