//
//  EnemyGenerator.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyGenerator.h"
#import "GameManager.h"
#import "ControlsLayer.h"

@implementation EnemyGenerator

@synthesize roundNumber;
@synthesize enemyCount;
@synthesize enemyDictionary;
@synthesize enemySpawnTimer;
@synthesize delegate;
@synthesize delayBetweenRounds;
@synthesize minimumDelayBetweenEnemies;

- (void) dealloc {
    
    self.enemyDictionary = nil;
    self.delegate = nil;
    
    [super dealloc];
}

- (void) updateGenerator: (ccTime) deltaTime {
    
    if (lastMessageShown == YES) {
        return;
    }
    
    // if all rounds are done but there are enemies still left
    if (self.roundNumber > 20 && [delegate.enemyCollection count] > 0) {
        return;
        
        // this is the case when all rounds are finished and there are no more enemies left on the field
    } else if (self.roundNumber > 20 && [delegate.enemyCollection count] == 0 && lastMessageShown == NO) {
        
        // check if hero's life is at 0 and should actually lose (instead of win)
        // if player should lose, then wait for lose sequence to kick in
        GameManager *m = [GameManager sharedGameManager];
        
        if (m.numberOfLives == 0) {
            return;
        }
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        NSString *levelCompleteString = [NSString stringWithFormat: @"Level Complete"];
        [delegate showTextLabel: levelCompleteString
               andLabelPosition: ccp(screenSize.width/2, screenSize.height/2)
                       andScale: 0.7f
                  andTimePeriod: 1.0f
                       andColor: ccWHITE];
        
        lastMessageShown = YES;
        
        // level beaten
        [delegate.controlsLayer winSequence];
        return;
    }
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
    // calculate how many enemies should be generated in the next round
    if (self.enemyCount == 0) {
        
        self.delayBetweenRounds = DELAY_BETWEEN_ROUNDS;
        
        // set to the next round
        self.roundNumber = self.roundNumber + 1;
        
        self.enemyCount = 10 + 1*self.roundNumber;
        
        // gain experience
        int experienceToReceive = EXPERIENCE_MULTIPLIER*(self.roundNumber - 1);
        [delegate receiveExperience: experienceToReceive];
        
        // label to show how much XP was gained
        NSString *xpGainedString = [NSString stringWithFormat: @"XP: %d", experienceToReceive];
        [delegate showTextLabel: xpGainedString
               andLabelPosition: ccp(screenSize.width/2, screenSize.height/2)
                       andScale: 0.7f
                  andTimePeriod: 1.5f
                       andColor: ccMAGENTA];
    }
    
    // this is the delay between rounds
    if (self.delayBetweenRounds > 0.0f) {
        self.delayBetweenRounds = self.delayBetweenRounds - deltaTime;
        return;
    } else if (self.delayBetweenRounds > -1.0f && self.delayBetweenRounds <= 0.0f) {
        // if round 20 has been completed, level is complete
        if (self.roundNumber > 20) {
            return;
        }
        
        PLAYSOUNDEFFECT(play_button_sound);
        
        NSString *roundString = [NSString stringWithFormat: @"Round %d", self.roundNumber];
        [delegate showTextLabel: roundString
               andLabelPosition: ccp(screenSize.width/2, screenSize.height/2)
                       andScale: 0.7f
                  andTimePeriod: 1.5f
                       andColor: ccWHITE];
        
        // send roundNumber information to GameManager; this will be used to be tracked using Flurry Analytics
        GameManager *m = [GameManager sharedGameManager];
        m.roundNumber = self.roundNumber;
        
        NSString *roundNumberString = [NSString stringWithFormat: @"Round %d of 20", self.roundNumber];
        
        [delegate nextRoundLabel: delegate.controlsLayer.roundNumberLabel withString: roundNumberString];
        
        self.delayBetweenRounds = -1.0f;
    }
    
    if (self.enemySpawnTimer > 0) {
        enemySpawnTimer = enemySpawnTimer - deltaTime;
        return;
    } else {
                
        NSString *roundString = [NSString stringWithFormat: @"Round%d", self.roundNumber];
        NSString *spawnString = [NSString stringWithFormat: @"SpawnRate%d", self.roundNumber];
        
        // get array of enemy types to generate
        NSArray *roundEnemyArray = [self.enemyDictionary objectForKey: roundString];
        
        // get nsnumber to use as the enemy spawn timer
        NSNumber *spawnTimerObject = (NSNumber *) [self.enemyDictionary objectForKey: spawnString];
        self.enemySpawnTimer = [spawnTimerObject floatValue];
        
        // access the enemy array to get the enemy that we want to generate
        int randomEnemyIndex = arc4random() % [roundEnemyArray count];
        NSNumber *n = (NSNumber *) [roundEnemyArray objectAtIndex: randomEnemyIndex];
        int randomEnemy = [n intValue];
        
        if (randomEnemy == 1) {
            [delegate createEnemyType: kEnemyMud];
            self.enemyCount = self.enemyCount - 1;
            
        } else if (randomEnemy == 2) {
            [delegate createEnemyType: kEnemyDreadling];
            self.enemyCount = self.enemyCount - 1;
            
        } else if (randomEnemy == 3) {
            [delegate createEnemyType: kEnemyMinion];
            self.enemyCount = self.enemyCount - 1;
            
        } else if (randomEnemy == 4) {
            [delegate createEnemyType: kEnemyPhib];
            self.enemyCount = self.enemyCount - 1;
            
        } else if (randomEnemy == 5) {
            [delegate createEnemyType: kEnemyCritling];
            self.enemyCount = self.enemyCount - 1;

        } else if (randomEnemy == 6) {
            [delegate createEnemyType: kEnemyPinki];
            self.enemyCount = self.enemyCount - 1;
            
        } else if (randomEnemy == 7) {
            [delegate createEnemyType: kEnemyTarling];
            self.enemyCount = self.enemyCount - 1;
            
        } else {
            CCLOG(@"EG: unrecognized enemy to create");
        }
        
        float randomFloat = ((float) arc4random()/ (float) ARC4RANDOM_MAX); // random float from 0.0 to 1.0
        int randomInt = arc4random() % 2; // random int from 0 to 1
        
        // randomized spawn timer
        if (randomInt == 0) {
            self.enemySpawnTimer = (0.85f*self.enemySpawnTimer) + (0.15f*randomFloat*self.enemySpawnTimer);
        } else {
            self.enemySpawnTimer = (0.15f*self.enemySpawnTimer) + (0.85f*randomFloat*self.enemySpawnTimer);
        }
        
        // self.enemySpawnTimer = ((float) arc4random()/ (float) ARC4RANDOM_MAX)*self.enemySpawnTimer + self.minimumDelayBetweenEnemies;
    }
}

- (void) initRoundInformationAndSpawnTimer {
    
    // load the dictionary
    // "Round1"
    // "EnemySpawnTimer1", etc.
    
    if (self.enemyDictionary == nil) {
        self.enemyDictionary = [NSMutableDictionary dictionary];
    }
    
    GameManager *m = [GameManager sharedGameManager];
    
    NSDictionary *levelDictionary = [NSDictionary dictionaryWithDictionary: [m getInformationForLevel: m.selectedLevel]];
        
    // this array is an array of arrays; index 0 - 24
    NSArray *tmpEnemyRoundStrings = [levelDictionary valueForKey: @"Enemy Round Information"];
    
    NSMutableArray *tmpEnemyRoundArray = [NSMutableArray array];
    
    for (NSString *s in tmpEnemyRoundStrings) {
        
        NSArray *roundArray = [NSArray arrayWithArray: [m getEnemyRoundArray: s]];
                
        [tmpEnemyRoundArray addObject: roundArray];
    }
    
    // this array is an array of NSNumber's (floats); index 0 - 24
    NSArray *tmpEnemySpawnRateArray = [levelDictionary valueForKey: @"Enemy Spawn Rate Information"];

    // sets the enemyDictionary for the appropriate level
    for (int i = 0; i < 20; i++) {
        
        NSString *roundString = [NSString stringWithFormat: @"Round%d", i+1];
        NSString *enemySpawnRateString = [NSString stringWithFormat: @"SpawnRate%d", i+1];
        
        [self.enemyDictionary setObject: [tmpEnemyRoundArray objectAtIndex: i] forKey: roundString];
        [self.enemyDictionary setObject: [tmpEnemySpawnRateArray objectAtIndex: i] forKey: enemySpawnRateString];
    }
    
}

- (id) init {
    if (self = [super init]) {
        
        [self initRoundInformationAndSpawnTimer];
        
        self.enemySpawnTimer = -1.0f;
        self.roundNumber = 1;
        self.enemyCount = 10;
        self.delayBetweenRounds = -1.0f;
        self.minimumDelayBetweenEnemies = 0.0f; // may not be necessary; may delete later
        
        lastMessageShown = NO;
    }
    
    return self;
}

+ (id) createGenerator {
    return [[[self alloc] init] autorelease];
}

@end












