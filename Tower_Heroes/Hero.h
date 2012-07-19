//
//  Hero.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface Hero : CCSprite <NSCoding> {
    int fileID; // 1 = first save file, 2 = second save file, 3 = third save file
    int characterID; // 1 = standard, 2 = magic, 3 = precision
    int talentPointsLeft;
    int lastLevelCompleted;
    int characterLevel;
    int experiencePoints;
    int currentExperienceLimit;
    
    int totalExperiencePoints;
    
    // this dictionary will contain all the keys for all the heroes (15 keys)
    // the objects will be the number of points put into each talent
    // the objects will be initialized to 0
    NSMutableDictionary *talentTree;
    
    BOOL isNewFile;
    
}

- (void) nextLevel;

- (void) reset;

@property (nonatomic, assign) int fileID;
@property (nonatomic, assign) int characterID;
@property (nonatomic, assign) int talentPointsLeft;
@property (nonatomic, assign) int lastLevelCompleted;
@property (nonatomic, assign) int characterLevel;
@property (nonatomic, assign) int experiencePoints;
@property (nonatomic, assign) int currentExperienceLimit;
@property (nonatomic, assign) int totalExperiencePoints;
@property (nonatomic, strong) NSMutableDictionary *talentTree;
@property (nonatomic, assign) BOOL isNewFile;
@property (nonatomic, assign) BOOL introSeen; // checks whether player has seen the introductory tutorial; if not, it shows at the first level

+ createHero;

// for the NSCoding protocol
- (void) encodeWithCoder: (NSCoder *) coder;
- (id) initWithCoder: (NSCoder *) coder;

@end





