//
//  TowerPlacement.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerPlacement.h"

@implementation TowerPlacement

@synthesize isActive;

- (id) init {
    
    if (self = [super init]) {
        
        self.isActive = YES;
    }
    return self;
}

@end
