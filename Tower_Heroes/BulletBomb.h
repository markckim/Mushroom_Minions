//
//  BulletBomb.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"

@interface BulletBomb : Bullet {
    
    CCSprite *bulletBombEffectSprite;
    
}

@property (nonatomic, strong) CCSprite *bulletBombEffectSprite;

@end
