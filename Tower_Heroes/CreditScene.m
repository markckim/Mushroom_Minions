//
//  CreditScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreditScene.h"
#import "CreditLayer.h"

@implementation CreditScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [CreditLayer node]];
    }
    return self;
}

@end
