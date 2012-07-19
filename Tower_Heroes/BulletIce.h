//
//  BulletIce.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"

@interface BulletIce : Bullet {
    
    CCSprite *bulletIceEffectSprite;
    
    float bulletIceTrailTimer;
}

@property (nonatomic, strong) CCSprite *bulletIceEffectSprite;
@property (nonatomic, assign) float bulletIceTrailTimer;

- (void) deleteEffect: (CCSprite *) sender;

@end
