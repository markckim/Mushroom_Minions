//
//  Bullet.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"

@class Tower;

@interface Bullet : GameCharacter 
{
    id <GamePlayLayerDelegate> delegate;
    Tower *towerRef;
    
    float originalDeltaX;
    float originalDeltaY;
    float originalDistanceToTarget;
    float rotationAngle;
    
    float bulletDamage;
    BulletType bulletType;
    
    CGPoint target;
    int originalPositionInitializationCount;
    CGPoint originalPosition;
    
    BOOL dud;
    BOOL critBullet;
        
}

@property (nonatomic, assign) id <GamePlayLayerDelegate> delegate;
@property (nonatomic, assign) Tower *towerRef;

@property (nonatomic, assign) float rotationAngle;
@property (nonatomic, assign) float bulletDamage;
@property (nonatomic, assign) BulletType bulletType;
@property (nonatomic, assign) CGPoint target;
@property (nonatomic, assign) int originalPositionInitializationCount;
@property (nonatomic, assign) CGPoint originalPosition;
@property (nonatomic, assign) BOOL dud;
@property (nonatomic, assign) BOOL critBullet;

- (void) deletingSelf;

@end
