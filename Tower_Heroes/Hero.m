//
//  Hero.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Hero.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"

@implementation Hero

@synthesize fileID;
@synthesize characterID;
@synthesize lastLevelCompleted;
@synthesize characterLevel;
@synthesize experiencePoints;
@synthesize currentExperienceLimit;
@synthesize talentTree;
@synthesize talentPointsLeft;
@synthesize totalExperiencePoints;
@synthesize isNewFile;
@synthesize introSeen;

- (void) dealloc {
    
    self.talentTree = nil;
    
    [super dealloc];
}

- (void) nextLevel {
    
    if (self.characterLevel < MAX_LEVEL) {
        
        GameManager *m = [GameManager sharedGameManager];
        
        self.characterLevel += 1;
        self.talentPointsLeft += 1;
        
        PLAYSOUNDEFFECT(level_up_sound);
        
        // flurry analytics
        NSString *heroCharacterID_string = [NSString stringWithFormat: @"%d", m.selectedHero.characterID];
        NSString *heroLevel_string = [NSString stringWithFormat: @"%d", m.selectedHero.characterLevel];
        NSString *selectedLevel_string = [NSString stringWithFormat: @"%d", m.selectedLevel];
        NSString *roundNumber_string = [NSString stringWithFormat: @"%d", m.roundNumber];
        
        NSDictionary *fDict = [NSDictionary dictionaryWithObjectsAndKeys: 
                               heroCharacterID_string, @"hero id",
                               heroLevel_string, @"hero level",
                               selectedLevel_string, @"game level",
                               roundNumber_string, @"round number", nil];
        
        [FlurryAnalytics logEvent: @"level up" withParameters: fDict];

        
        self.currentExperienceLimit = (STARTING_EXPERIENCE_LIMIT*pow(self.characterLevel,EXPERIENCE_EXPONENT) + 0.5f);
        self.experiencePoints = 0; // note: any remaining experience points gained before leveling up are calculated and added in elsewhere
    }
}

- (void) reset {
    self.fileID = 0;
    self.characterID = 0;
    self.lastLevelCompleted = STARTING_LAST_LEVEL_COMPLETED;
    self.characterLevel = STARTING_TALENT_POINTS;
    self.experiencePoints = 0;
    self.currentExperienceLimit = STARTING_EXPERIENCE_LIMIT;
    
    self.talentPointsLeft = STARTING_TALENT_POINTS;
    self.introSeen = NO;
    
    self.totalExperiencePoints = 0;
    
    // initialize the talent tree
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"Optimization"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"TowerCooling"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedMines"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"BulletPropulsion"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ArmorPiercing"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedPoison"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedBlizzard"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedSmite"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"DeepFreeze"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"FocusedFire"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"Sharpshooter"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedRage"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedMeditation"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedSlow"];
    [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"Nirvana"];
    
    self.isNewFile = YES;

    
}

- (void) encodeWithCoder: (NSCoder *) coder {
    
    [coder encodeInt: self.fileID forKey: @"fileID"];
    [coder encodeInt: self.characterID forKey: @"characterID"];
    [coder encodeInt: self.talentPointsLeft forKey: @"talentPointsLeft"];
    [coder encodeInt: self.lastLevelCompleted forKey: @"lastLevelCompleted"];
    [coder encodeInt: self.characterLevel forKey: @"characterLevel"];
    [coder encodeInt: self.experiencePoints forKey: @"experiencePoints"];
    [coder encodeInt: self.currentExperienceLimit forKey: @"currentExperienceLimit"];
    [coder encodeInt: self.totalExperiencePoints forKey: @"totalExperiencePoints"];
    [coder encodeBool: self.isNewFile forKey: @"isNewFile"];
    [coder encodeBool: self.introSeen forKey: @"introSeen"];
    
    [coder encodeObject: self.talentTree forKey: @"talentTree"];
    
}

- (id) initWithCoder: (NSCoder *) coder {
    
    if (self = [super init]) {
        
        self.fileID = [coder decodeIntForKey: @"fileID"];
        self.characterID = [coder decodeIntForKey: @"characterID"];
        self.talentPointsLeft = [coder decodeIntForKey: @"talentPointsLeft"];
        self.lastLevelCompleted = [coder decodeIntForKey: @"lastLevelCompleted"];
        self.characterLevel = [coder decodeIntForKey: @"characterLevel"];
        self.experiencePoints = [coder decodeIntForKey: @"experiencePoints"];
        self.currentExperienceLimit = [coder decodeIntForKey: @"currentExperienceLimit"];
        self.totalExperiencePoints = [coder decodeIntForKey: @"totalExperiencePoints"];
        self.isNewFile = [coder decodeBoolForKey: @"isNewFile"];
        self.introSeen = [coder decodeBoolForKey: @"introSeen"];
        
        self.talentTree = [coder decodeObjectForKey: @"talentTree"];
    }
    
    return self;
}

- (id) init {
    if (self = [super init]) {
        self.fileID = 0;
        self.characterID = 0;
        self.lastLevelCompleted = STARTING_LAST_LEVEL_COMPLETED;
        self.characterLevel = STARTING_TALENT_POINTS;
        self.experiencePoints = 0;
        self.currentExperienceLimit = STARTING_EXPERIENCE_LIMIT;
        self.talentPointsLeft = STARTING_TALENT_POINTS;
        
        self.introSeen = NO;
        
        self.totalExperiencePoints = 0;
        self.talentTree = [NSMutableDictionary dictionary];
        
        // initialize the talent tree
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"Optimization"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"TowerCooling"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedMines"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"BulletPropulsion"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ArmorPiercing"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedPoison"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedBlizzard"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedSmite"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"DeepFreeze"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"FocusedFire"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"Sharpshooter"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedRage"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedMeditation"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"ImprovedSlow"];
        [talentTree setObject: [NSNumber numberWithInt: 0] forKey: @"Nirvana"];
        
        self.isNewFile = YES;
        
    }
    return self;
}

+ (id) createHero {
    return [[[self alloc] init] autorelease];
}


@end























