//
//  Bullet.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "Bullet.h"

@implementation Bullet

@synthesize delegate;

@synthesize rotationAngle;
@synthesize bulletDamage;
@synthesize bulletType;
@synthesize target;
@synthesize originalPositionInitializationCount;
@synthesize originalPosition;
@synthesize dud;
@synthesize critBullet;
@synthesize towerRef;

- (void) dealloc {
    
    self.delegate = nil;
    self.towerRef = nil;
    
    [super dealloc];
}

- (void) changeState: (CharacterState) newState {
    [self setState: newState];
    
    if (newState == kStateDead) {
        
        self.isActive = NO;
    }
}

- (void) deletingSelf {
    
    [self.delegate queueBulletToDelete: self];
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime
             andListOfGameObjects: (CCArray *) listOfGameObjects {
    
    // bullet position initialization (set by the tower shooting it)
    if ([self originalPositionInitializationCount] == 1) {
        [self setOriginalPositionInitializationCount: 0];
        [self setOriginalPosition: [self position]];
        
        originalDeltaX = [self target].x - [self originalPosition].x;
        originalDeltaY = [self target].y - [self originalPosition].y;
        originalDistanceToTarget = sqrt(pow(originalDeltaX,2) + pow(originalDeltaY,2));
    }
    
    // if bullet has exploded in the previous frame, set it to dead
    if ([self state] == kStateExploding) {
        [self changeState: kStateDead];
    }
    
    // if bullet is dead
    if ([self state] == kStateDead) {
        
        if ([self numberOfRunningActions] == 0) {
            self.visible = NO;
            [self deletingSelf];
            return;
        } else {
            return;
        }
    }
    
    float newDeltaX = [self position].x - [self originalPosition].x;
    float newDeltaY = [self position].y - [self originalPosition].y;
    float bulletDistanceTraveled = sqrt(pow(newDeltaX,2) + pow(newDeltaY,2));
    
    // if bullet has reached its destination, change it's state to dead
    // if bullet is a bomb, change it's state to exploding instead
    if (bulletDistanceTraveled > originalDistanceToTarget) {
        if ([self bulletType] == kBulletBomb && self.dud == NO) {
            [self changeState: kStateExploding];
            return;
        }
        [self changeState: kStateDead];
        return;
    }
        
    // the actual movement of the bullet for each frame
    float newPositionX = [self position].x + [self velocity]*(deltaTime)*(originalDeltaX)/(originalDistanceToTarget);
    float newPositionY = [self position].y + [self velocity]*(deltaTime)*(originalDeltaY)/(originalDistanceToTarget);
    [self setPosition: ccp(newPositionX, newPositionY)];
}

- (id) init {
    if (self = [super init]) {
        self.originalPositionInitializationCount = 1;
        self.objectType = kBulletType;
        self.dud = NO;
        self.critBullet = NO;
    }
    
    return self;
}

@end


