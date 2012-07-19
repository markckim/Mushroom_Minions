//
//  BackgroundLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

- (void) dealloc {
    
    [super dealloc];
}

- (void) initializeMap {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    int level = [GameManager sharedGameManager].selectedLevel;
    
    CCSprite *tmpSprite;
    
    switch (level) {
            
        case 1:
            tmpSprite = [CCSprite spriteWithFile: @"map_forest_1.png"];
            break;
            
        case 2:
            tmpSprite = [CCSprite spriteWithFile: @"map_forest_2.png"];
            break;
            
        case 3:
            tmpSprite = [CCSprite spriteWithFile: @"map_forest_3.png"];
            break;
            
        case 4:
            tmpSprite = [CCSprite spriteWithFile: @"map_forest_4.png"];
            break;
            
        case 5:
            tmpSprite = [CCSprite spriteWithFile: @"map_water_1.png"];
            break;
            
        case 6:
            tmpSprite = [CCSprite spriteWithFile: @"map_water_2.png"];
            break;
            
        case 7:
            tmpSprite = [CCSprite spriteWithFile: @"map_snow_1.png"];        
            break;
            
        case 8:
            tmpSprite = [CCSprite spriteWithFile: @"map_snow_2.png"];
            break;
            
        case 9:
            tmpSprite = [CCSprite spriteWithFile: @"map_snow_3.png"];
            break;
            
        case 10:
            tmpSprite = [CCSprite spriteWithFile: @"map_snow_4.png"];
            break;
            
        default:
            CCLOG(@"BGLayer: unrecognized map name");
            break;
            
    }
    
    tmpSprite.position = ccp(screenSize.width/2, screenSize.height/2);
    tmpSprite.zOrder = 0;
    
    [self addChild: tmpSprite];
    
}

- (id) init {
    if (self = [super init]) {
        
        [self initializeMap];
    }
    return self;
    
} // init

@end




















