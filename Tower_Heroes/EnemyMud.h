//
//  EnemyMud.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

@interface EnemyMud : Enemy
{
    CCSprite *eyes;
}

@property (nonatomic, strong) CCSprite *eyes;

@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *animationMovementString;
@property (nonatomic, copy) NSString *animationFrozenString;

- (id) initWithEnemyType: (EnemyType) eType;

@end
