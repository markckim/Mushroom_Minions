//
//  EnemyGenerator.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface EnemyGenerator : NSObject {
    
    id <GamePlayLayerDelegate> delegate;
    
    int roundNumber;
    int enemyCount;
    float delayBetweenRounds;
    float enemySpawnTimer;
    float minimumDelayBetweenEnemies;
    
    NSMutableDictionary *enemyDictionary;
    
    BOOL lastMessageShown;
}

@property (nonatomic, assign) int roundNumber;
@property (nonatomic, assign) int enemyCount;
@property (nonatomic, assign) float delayBetweenRounds;
@property (nonatomic, assign) float enemySpawnTimer;
@property (nonatomic, assign) float minimumDelayBetweenEnemies;
@property (nonatomic, assign) id <GamePlayLayerDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *enemyDictionary;

- (void) updateGenerator: (ccTime) deltaTime;

- (void) initRoundInformationAndSpawnTimer;

+ (id) createGenerator;

@end






