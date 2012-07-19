//
//  BulletStandard.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"

@interface BulletStandard : Bullet
{
    CCSprite *bulletStandardEffectSprite;
    
    float bulletStandardTrailTimer;
}

@property (nonatomic, strong) CCSprite *bulletStandardEffectSprite;
@property (nonatomic, assign) float bulletStandardTrailTimer;

- (void) deleteEffect: (CCSprite *) sender;

@end
