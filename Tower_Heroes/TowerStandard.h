//
//  TowerStandard.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tower.h"

@interface TowerStandard : Tower
{
    DirectionState directionState;
}

@property (nonatomic, assign) DirectionState directionState;

- (int) stepsClockwiseTo: (DirectionState) dState;
- (int) stepsCounterClockwiseTo: (DirectionState) dState;

- (CCAnimation *) addFramesClockwiseTo: (DirectionState) dState;
- (CCAnimation *) addFramesCounterClockwiseTo: (DirectionState) dState;

@end
