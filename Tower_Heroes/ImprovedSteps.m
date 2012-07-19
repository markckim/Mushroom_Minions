//
//  ImprovedSteps.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImprovedSteps.h"

@implementation ImprovedSteps

@synthesize position;
@synthesize gScore;
@synthesize hScore;
@synthesize parent;

- (id) initWithPosition: (CGPoint) pos
{
    if (self = [super init]) {
        position = pos;
        gScore = 0;
        hScore = 0;
        parent = nil;
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat: @"%@ pos = [%.0f; %.0f] g=%d h=%d f=%d", 
            [super description], self.position.x, self.position.y, self.gScore, self.hScore, [self fScore]];
}

- (BOOL) isEqual: (ImprovedSteps *) other {
    return CGPointEqualToPoint(self.position, other.position);
}

- (int) fScore {
    return self.gScore + self.hScore;
}

@end















