//
//  BulletCast.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "Bullet.h"

@class GamePlayLayer;

@interface BulletCast : Bullet
{    
    CastType castType;
    float mineTimer;
    GamePlayLayer *gamePlayLayer;    
}

@property (nonatomic, assign) CastType castType;
@property (nonatomic, assign) float mineTimer;
@property (nonatomic, assign) GamePlayLayer *gamePlayLayer;

- (void) activateMine;
- (void) explosionSequence;

- (id) initWithLocation: (CGPoint) pos 
            andCastType: (CastType) cType;
@end
