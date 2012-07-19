//
//  ImprovedSteps.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ImprovedSteps : NSObject
{
    CGPoint position;
    int gScore;
    int hScore;
    
    ImprovedSteps *parent;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int gScore;
@property (nonatomic, assign) int hScore;
@property (nonatomic, assign) ImprovedSteps *parent;

- (id) initWithPosition: (CGPoint) pos;
- (int) fScore;

@end
