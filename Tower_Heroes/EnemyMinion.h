//
//  EnemyMinion.h
//  
//
//  Created by Mark Kim on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

@interface EnemyMinion : Enemy
{
    CCSprite *helmEffect;
}

@property (nonatomic, strong) CCSprite *helmEffect;

@end
