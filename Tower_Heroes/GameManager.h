//
//  GameManager.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "Hero.h"
#import "SimpleAudioEngine.h"
#import "GameScene1.h"
@class CompleteLayer;

@class ControlsLayer;

@interface GameManager : NSObject <NSCoding>
{
    int numberOfEnemiesKilled;
    int numberOfEnemiesPassed;
    float accuracy_static_power;
    float range_static_power;
    BOOL proc_static_power;
    SceneType currentScene;
    
    GameScene1 *gs1_reference;
    
    ControlsLayer *controlsLayer;
    
    int numberOfLives;
    
    // for audio
    BOOL hasAudioBeenInitialized;
    GameManagerSoundState managerSoundState;
    SimpleAudioEngine *soundEngine;
    NSMutableDictionary *listOfSoundEffectFiles;
    NSMutableDictionary *soundEffectsState;
    
    Hero *selectedHero;
    
    NSString *key1;
    NSString *key2;
    NSString *key3;
    NSString *key4;
    NSString *key5;
    
    BOOL newlyCreatedHero;
    int tempCharacterID;
    
    // lets you know which background music to start up if you unmute the sound
    // 1 = main menu theme
    // 2 = sand theme
    // 3 = water theme
    // 4 = snow theme
    int backgroundMusicConstant;
    
    // other variables to save
    int selectedLevel;
    
    // PERSISTENT VARIABLES
    
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    
    Hero *hero1;
    Hero *hero2;
    Hero *hero3;
}

@property (nonatomic, assign) GameScene1 *gs1_reference;

@property (nonatomic, assign) int roundNumber;

@property (nonatomic, assign) GameManagerSoundState managerSoundState;
@property (nonatomic, strong) NSMutableDictionary *listOfSoundEffectFiles;
@property (nonatomic, strong) NSMutableDictionary *soundEffectsState;

@property (nonatomic, assign) int backgroundMusicConstant;

@property (nonatomic, assign) BOOL isMusicON;
@property (nonatomic, assign) BOOL isSoundEffectsON;
@property (nonatomic, assign) int numberOfEnemiesKilled;
@property (nonatomic, assign) int numberOfEnemiesPassed;
@property (nonatomic, assign) float accuracy_static_power;
@property (nonatomic, assign) float range_static_power;
@property (nonatomic, assign) BOOL proc_static_power;
@property (nonatomic, assign) SceneType currentScene;
@property (nonatomic, assign) int numberOfLives;

@property (nonatomic, assign) ControlsLayer *controlsLayer;

@property (nonatomic, assign) int selectedLevel;

@property (nonatomic, copy) NSString *key1;
@property (nonatomic, copy) NSString *key2;
@property (nonatomic, copy) NSString *key3;
@property (nonatomic, copy) NSString *key4;
@property (nonatomic, copy) NSString *key5;

@property (nonatomic, assign) BOOL newlyCreatedHero;
@property (nonatomic, assign) int tempCharacterID;

@property (nonatomic, strong) Hero *hero1;
@property (nonatomic, strong) Hero *hero2;
@property (nonatomic, strong) Hero *hero3;
@property (nonatomic, assign) Hero *selectedHero;

+ (GameManager *) sharedGameManager;
- (CCAnimation *) loadPlistForAnimationWithName: (NSString *) animationName 
                                   andClassName: (NSString *) className;

- (NSDictionary *) getInformationForLevel: (int) levelNumber;

- (NSArray *) getEnemyRoundArray: (NSString *) enemyStringInformation;
- (NSArray *) getPointArrayFromStringArray: (NSArray *) stringArray;

- (void) setupAudioEngine;
- (ALuint) playSoundEffect: (NSString *) soundEffectKey;
- (ALuint) playSoundEffect: (NSString *) soundEffectKey 
                  withGain: (int) gainFactor;

- (void) stopSoundEffect: (ALuint) soundEffectID;
- (void) playBackgroundTrack: (NSString *) trackFileName;

- (void) runSceneWithID: (SceneType) sceneID;
- (void) pushSceneWithID: (SceneType) sceneID;
- (void) popScene;
- (void) enemyKilled;
- (void) enemyPassed;
- (void) lifeLost;

- (void) standardTypeCharacterSelected;
- (void) magicTypeCharacterSelected;
- (void) precisionTypeCharacterSelected;
- (void) resetCharacterSelectedStaticPowers;

- (void) lose;
- (void) win;

- (void) muteSoundToggle: (CCMenuItemToggle *) sender;

// for the NSCoding protocol
- (void) encodeWithCoder: (NSCoder *) coder;
- (id) initWithCoder: (NSCoder *) coder;

@end







