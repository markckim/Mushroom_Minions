//
//  TowerPlacement.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface TowerPlacement : CCSprite
{
    BOOL isActive;
}

@property (nonatomic, assign) BOOL isActive;

@end
