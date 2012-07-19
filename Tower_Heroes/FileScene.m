//
//  FileScene.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileScene.h"
#import "FileLayer.h"

@implementation FileScene

- (id) init {
    if (self = [super init]) {
        [self addChild: [FileLayer node]];
    }
    return self;
}
@end
