//
//  GameManager.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "PlayScene.h"
#import "CreditScene.h"
#import "FileScene.h"
#import "CharacterSelectionScene.h"
#import "IntroScene.h"
#import "LevelSelectionScene.h"
#import "LoadingScene.h"
#import "GameScene1.h"
#import "PauseScene.h"
#import "TalentScene.h"
#import "PreLoadScene.h"
#import "ControlsLayer.h"
#import "CompleteLayer.h"
#import "SimpleAudioEngine.h"

@implementation GameManager

static GameManager *_sharedGameManager = nil;

@synthesize gs1_reference;

@synthesize roundNumber;

@synthesize managerSoundState;
@synthesize listOfSoundEffectFiles;
@synthesize soundEffectsState;

@synthesize backgroundMusicConstant;

@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize numberOfEnemiesKilled;
@synthesize numberOfEnemiesPassed;
@synthesize accuracy_static_power;
@synthesize range_static_power;
@synthesize proc_static_power;
@synthesize currentScene;
@synthesize numberOfLives;
@synthesize controlsLayer;

@synthesize selectedLevel;

@synthesize key1;
@synthesize key2;
@synthesize key3;
@synthesize key4;
@synthesize key5;

@synthesize newlyCreatedHero;
@synthesize tempCharacterID;

@synthesize hero1;
@synthesize hero2;
@synthesize hero3;
@synthesize selectedHero;

- (void) dealloc {
    self.hero1 = nil;
    self.hero2 = nil;
    self.hero3 = nil;
    self.selectedHero = nil;
        
    self.gs1_reference = nil;
    
    self.key1 = nil;
    self.key2 = nil;
    self.key3 = nil;
    self.key4 = nil;
    self.key5 = nil;
    
    self.controlsLayer = nil;
    
    [super dealloc];
}

+ (GameManager *) sharedGameManager
{
    @synchronized ([GameManager class])
    {
        if (!_sharedGameManager)
            [[self alloc] init];
        return _sharedGameManager;
    }
    return nil;
    
} // sharedGameManager

+ (id) alloc
{
    @synchronized ([GameManager class])
    {
        NSAssert(_sharedGameManager == nil, 
                 @"Attempted to allocate a second instance of the GameManager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    
    return nil;
    
} // alloc

- (void) standardTypeCharacterSelected {
    self.accuracy_static_power = ACCURACY_STATIC_POWER;
}

- (void) magicTypeCharacterSelected {
    self.range_static_power = RANGE_STATIC_POWER;
}

- (void) precisionTypeCharacterSelected {
    self.proc_static_power = YES;
}

- (void) resetCharacterSelectedStaticPowers {
    self.accuracy_static_power = 0.0f;
    self.range_static_power = 0.0f;
    self.proc_static_power = NO;
}

- (void) enemyKilled {
    numberOfEnemiesKilled = numberOfEnemiesKilled + 1;
}

- (void) enemyPassed {
    numberOfEnemiesPassed = numberOfEnemiesPassed + 1;
}

- (void) lifeLost {
    
    PLAYSOUNDEFFECT(lose_life_sound);
    
    id actionScaleUp = [CCScaleTo actionWithDuration: 0.1f scale: 1.2f];
    id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
    id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
    
    [self.controlsLayer.lifeIcon runAction: actionSequence];
    
    id actionScaleUp2 = [CCScaleTo actionWithDuration: 0.1f scale: 1.0f];
    id actionScaleDown2 = [CCScaleTo actionWithDuration: 0.25f scale: 0.9f];
    id actionSequence2 = [CCSequence actions: actionScaleUp2, actionScaleDown2, nil];
    
    [self.controlsLayer.lifeCounterLabel runAction: actionSequence2];
    
    self.numberOfLives = self.numberOfLives - 1;
    
    if (self.numberOfLives >= 0) {
        NSString *overlayLifeString = [NSString stringWithFormat: @"overlay_life_%d.png", self.numberOfLives];
        NSString *lifeCountString = [NSString stringWithFormat: @"%d", self.numberOfLives];
        
        controlsLayer.lifeCounter.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                  spriteFrameByName: overlayLifeString];
        
        controlsLayer.lifeCounterLabel.string = lifeCountString;
        
        if (self.numberOfLives == 0) {
            
            [self.controlsLayer loseSequence];
            
        }
    }    
}

- (void) lose {
    // pause game play layer
    [[gs1_reference gpLayer] onExit];
    
    // pause controls layer
    [[gs1_reference coLayer] onExit];
    
    // play lose music
    PLAYSOUNDEFFECT(lose_sound);
    
    // show complete layer
    CompleteLayer *completeLayer = [[[CompleteLayer alloc] initWithLose] autorelease];
    completeLayer.zOrder = 3;
    
    [gs1_reference addChild: completeLayer];
}

- (void) win {
    // pause game play layer
    [[gs1_reference gpLayer] onExit];
    
    // pause controls layer
    [[gs1_reference coLayer] onExit];
    
    // play win music
    PLAYSOUNDEFFECT(win_sound);
    
    // show complete layer
    CompleteLayer *completeLayer = [[[CompleteLayer alloc] initWithWin] autorelease];
    completeLayer.zOrder = 3;
    
    [gs1_reference addChild: completeLayer];
}

- (void) popScene {
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        CCLOG(@"error: no running scene to pop out");
        return;
    } else {
        
        PLAYSOUNDEFFECT(talent_button_sound);

        [[CCDirector sharedDirector] popScene];
    }
}

- (void) pushSceneWithID: (SceneType) sceneID {

    id sceneToRun = nil;
    
    switch (sceneID) {
                        
        case kTalentScene:
            sceneToRun = [TalentScene node];
            break;
                        
        case kPauseScene:
            sceneToRun = [PauseScene node];
            break;
            
        default:
            CCLOG(@"unrecognized scene to push");
            break;
    }
        
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene: sceneToRun];
    } else {
        [[CCDirector sharedDirector] pushScene: sceneToRun];
    }

}

- (void) runSceneWithID: (SceneType) sceneID {
    SceneType oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    
    switch (sceneID) {
            
        case kPlayScene:
            sceneToRun = [PlayScene node];
            break;

        case kCreditScene:
            sceneToRun = [CreditScene node];
            break;
                    
        case kFileScene:
            sceneToRun = [FileScene node];
            break;
            
        case kCharacterSelectionScene:
            sceneToRun = [CharacterSelectionScene node];
            break;
                                    
        case kIntroScene:
            sceneToRun = [IntroScene node];
            break;
            
        case kLevelSelectionScene:
            sceneToRun = [LevelSelectionScene node];
            break;
            
        case kLoadingScene:
            sceneToRun = [LoadingScene node];
            break;
            
        case kGameScene1:
            sceneToRun = [GameScene1 node];
            break;
            
        case kPauseScene:
            sceneToRun = [PauseScene node];
            break;
            
        case kTalentScene:
            sceneToRun = [TalentScene node];
            break;
            
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if (sceneToRun == nil) {
        currentScene = oldScene;
        return;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene: sceneToRun];
    } else {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFlipAngular transitionWithDuration: 0.5f scene: sceneToRun]];
    }
        
    currentScene = sceneID;
}

- (CCAnimation *) loadPlistForAnimationWithName: (NSString *) animationName 
                                   andClassName: (NSString *) className {
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName = [NSString stringWithFormat: @"%@.plist", className];
    NSString *plistPath;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) 
                          objectAtIndex: 0];
    plistPath = [rootPath stringByAppendingPathComponent: fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource: className ofType: @"plist"];
    }
    
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile: plistPath];
    
    if (plistDictionary == nil)
    {
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil;
    }
    
    NSDictionary *animationSettings = [plistDictionary objectForKey: animationName];
    if (animationSettings == nil)
    {
        CCLOG(@"Could not locate AnimationWithName: %@", animationName);
        return nil;
    }
    
    float animationDelay = [[animationSettings objectForKey: @"unitDelay"] floatValue];
    animationToReturn = [CCAnimation animation];
    
    [animationToReturn setDelayPerUnit: animationDelay];
    
    NSString *animationFramePrefix = [animationSettings objectForKey: @"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey: @"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString: @","];
    
    for (NSString *frameNumber in animationFrameNumbers)
    {
        NSString *frameName = [NSString stringWithFormat: @"%@%@.png", animationFramePrefix, frameNumber];
        [animationToReturn addSpriteFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: frameName]];
    }
    
    return animationToReturn;
}

- (void) setupAudioEngine {
    if (hasAudioBeenInitialized == YES) {
        return;
    } else {
        hasAudioBeenInitialized = YES;
        
        NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
        
        NSInvocationOperation *asyncSetupOperation = [[NSInvocationOperation alloc] initWithTarget: self
                                                                                          selector: @selector(initAudioAsync)
                                                                                            object: nil];
        [queue addOperation: asyncSetupOperation];
        [asyncSetupOperation autorelease];
    }
}

- (NSString *) formatSceneTypeToString: (SceneType) sceneID {
    NSString *result = nil;
    
    switch (sceneID) {
            
        case kGameScene1:
            result = @"kGameScene1";
            break;
            
        default:
            break;
    }
    
    return result;
}

- (NSDictionary *) getSoundEffectsListForSceneWithID: (SceneType) sceneID {
    
    NSString *fullFileName = @"SoundEffects.plist";
    NSString *plistPath;
    
    // get the path to the plist file
    NSString *rootPath = 
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    plistPath = [rootPath stringByAppendingPathComponent: fullFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath]) {
        plistPath = [[NSBundle mainBundle]
                     pathForResource: @"SoundEffects" ofType: @"plist"];
        
    }
    
    // read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile: plistPath];
    
    // if the plist dictionary was null, the file was not found
    if (plistDictionary == nil) {
        CCLOG(@"Error reading SoundEffects.plist");
        return nil;
    }
    
    // if the list of sound effect files is empty, load it
    if ((listOfSoundEffectFiles == nil) || ([listOfSoundEffectFiles count] < 1)) {
        CCLOG(@"Before");
        [self setListOfSoundEffectFiles: [[NSMutableDictionary alloc] init]];
        
        CCLOG(@"After");
        for (NSString *sceneSoundDictionary in plistDictionary) {
            [listOfSoundEffectFiles addEntriesFromDictionary: [plistDictionary objectForKey: sceneSoundDictionary]];
        }
        
        CCLOG(@"Number of SFX filenames: %d", [listOfSoundEffectFiles count]);

    }
    
    // load the list of sound effects state, mark them as unloaded
    if ((soundEffectsState == nil) || ([soundEffectsState count] < 1)) {
        
        [self setSoundEffectsState: [[NSMutableDictionary alloc] init]];
        
        for (NSString *SoundEffectKey in listOfSoundEffectFiles) {
            [soundEffectsState setObject: [NSNumber numberWithBool: SFX_NOTLOADED] forKey: SoundEffectKey];
        }
        
    }
    
    // return the SFX list for this scene
    NSString *sceneIDName = [self formatSceneTypeToString: sceneID];
    NSDictionary *soundEffectsList = [plistDictionary objectForKey: sceneIDName];
    
    return soundEffectsList;
    
}

- (void) loadAudioForSceneWithID: (NSNumber *) sceneIDNumber {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    SceneType sceneID = (SceneType) [sceneIDNumber intValue];
    
    if (managerSoundState == kAudioManagerInitializing) {
        int waitCycles = 0;
        while (waitCycles < AUDIO_MAX_WAITTIME) {
            [NSThread sleepForTimeInterval: 0.1f];
            
            if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed)) {
                break;
            }
            waitCycles = waitCycles + 1;
        }
    }
    
    if (managerSoundState == kAudioManagerFailed) {
        return; // nothing to load, CocosDenshion is not ready
    }
    
    NSDictionary *soundEffectsToLoad = [self getSoundEffectsListForSceneWithID: sceneID];
    if (soundEffectsToLoad == nil) {
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    
    // get all of the entries and preload
    for (NSString *keyString in soundEffectsToLoad) {
        CCLOG(@"\nLoading Audio Key: %@ File: %@", keyString, [soundEffectsToLoad objectForKey: keyString]);
        
        [soundEngine preloadEffect: [soundEffectsToLoad objectForKey: keyString]];
        
        [soundEffectsState setObject: [NSNumber numberWithBool: SFX_LOADED] forKey: keyString];
    }
    
    [pool release];
    
}

- (void) unloadAudioForSceneWithID: (NSNumber *) sceneIDNumber {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    SceneType sceneID = (SceneType) [sceneIDNumber intValue];
    
    NSDictionary *soundEffectsToUnload =
    [self getSoundEffectsListForSceneWithID: sceneID];
    
    if (soundEffectsToUnload == nil) {
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    
    if (managerSoundState == kAudioManagerReady) {
        
        // get all of the entries and unload
        
        for (NSString *keyString in soundEffectsToUnload) {
            [soundEffectsState setObject: [NSNumber numberWithBool: SFX_NOTLOADED] forKey: keyString];
            [soundEngine unloadEffect: keyString];
                        
            CCLOG(@"\nUnloading Audio Key: %@ File: %@", keyString, [soundEffectsToUnload objectForKey: keyString]);

        }
    }
    
    [pool release];

}

- (void) muteSoundToggle: (CCMenuItemToggle *) sender {
    
    SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
    
    // button has just been toggled to ON
    if (sender.selectedIndex == 0) {
        
        self.isMusicON = YES;
        
        // play background music
        switch (self.backgroundMusicConstant) {
               
            case 1:
                [self playBackgroundTrack: BACKGROUND_TRACK_MAIN_MENU];
                break;
                
            case 2:
                [self playBackgroundTrack: BACKGROUND_TRACK_SAND_THEME_1];
                break;
                
            case 3:
                [self playBackgroundTrack: BACKGROUND_TRACK_WATER_THEME_1];
                break;
                
            case 4:
                [self playBackgroundTrack: BACKGROUND_TRACK_SNOW_THEME_1];
                break;
                
            default:
                CCLOG(@"GM: unrecognized background music constant");
                break;
        }
        
    // button has just been toggled to OFF
    } else {
        
        self.isMusicON = NO;
        
        // stop music        
        if (s.isBackgroundMusicPlaying) {
            
            [s stopBackgroundMusic];
        }
    }
    
}

- (void) playBackgroundTrack: (NSString *) trackFileName {
            
    if (self.isMusicON == YES) {
        
        // wait to make sure soundEngine it initialized
        if ((managerSoundState != kAudioManagerReady) && (managerSoundState != kAudioManagerFailed)) {
            
            int waitCycles = 0;
            while (waitCycles < AUDIO_MAX_WAITTIME) {
                
                [NSThread sleepForTimeInterval: 0.1f];
                if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed)) {
                    break;
                }
                waitCycles = waitCycles + 1;
            }
        }
        
        if (managerSoundState == kAudioManagerReady) {
            
            
            if ([soundEngine isBackgroundMusicPlaying]) {
                [soundEngine stopBackgroundMusic];
            }
            
            [soundEngine preloadBackgroundMusic: trackFileName];
            [soundEngine playBackgroundMusic: trackFileName loop: YES];
        }
        
    }
}

- (void) stopSoundEffect: (ALuint) soundEffectID {
    if (managerSoundState == kAudioManagerReady) {
        [soundEngine stopEffect: soundEffectID];
    }
}

- (ALuint) playSoundEffect: (NSString *) soundEffectKey 
                  withGain: (int) gainFactor {
    ALuint soundID = 0;
    if (managerSoundState == kAudioManagerReady) {
        NSNumber *isSFXLoaded = [soundEffectsState objectForKey: soundEffectKey];
        
        if ([isSFXLoaded boolValue] == SFX_LOADED) {
            soundID = [soundEngine playEffect: [listOfSoundEffectFiles objectForKey: soundEffectKey]
                                        pitch: 1.0f
                                          pan: 0.0f
                                         gain: gainFactor];
        } else {
            CCLOG(@"GameManager: SoundEffect %@ is not loaded.", soundEffectKey);
        }
        
    } else {
        CCLOG(@"GameManager: Sound Manager is not ready, cannot play %@", soundEffectKey);
    }
    return soundID;
    
}

- (ALuint) playSoundEffect: (NSString *) soundEffectKey {

    ALuint soundID = 0;

    if (self.isMusicON == YES) {
        if (managerSoundState == kAudioManagerReady) {
            NSNumber *isSFXLoaded = [soundEffectsState objectForKey: soundEffectKey];
            
            if ([isSFXLoaded boolValue] == SFX_LOADED) {
                soundID = [soundEngine playEffect: [listOfSoundEffectFiles objectForKey: soundEffectKey]];
            } else {
                CCLOG(@"GameManager: SoundEffect %@ is not loaded.", soundEffectKey);
            }
            
        } else {
            CCLOG(@"GameManager: Sound Manager is not ready, cannot play %@", soundEffectKey);
        }
    }
    
    return soundID;
}

- (void) initAudioAsync {
    
    // initializes the audio engine asynchronously
    managerSoundState = kAudioManagerInitializing;
    
    // indicate that we are trying to start up the Audio
    [CDSoundEngine setMixerSampleRate: CD_SAMPLE_RATE_DEFAULT];
    
    // init audio manager asynchronously as it can take a few seconds
    // the FXPlusMusicIfNoOtherAudio mode will check if the user is playing music and disable
    // background music playback if that is the case
    [CDAudioManager initAsynchronously: kAMM_FxPlusMusicIfNoOtherAudio];
    
    // wait for the audio manager to initialize
    while ([CDAudioManager sharedManagerState] != kAMStateInitialised) {
        [NSThread sleepForTimeInterval: 0.1];
    }
    
    // at this point the CocosDenshion should be initialized
    // grab the CDAudioManager and check the state
    CDAudioManager *audioManager = [CDAudioManager sharedManager];
    
    if (audioManager.soundEngine == nil || audioManager.soundEngine.functioning == NO) {
        CCLOG(@"CocosDenshion failed to init, no audio will play.");
        managerSoundState = kAudioManagerFailed;
    } else {
        [audioManager setResignBehavior: kAMRBStopPlay autoHandle: YES];
        soundEngine = [SimpleAudioEngine sharedEngine];
        managerSoundState = kAudioManagerReady;
        CCLOG(@"CocosDenshion is Ready");
    }
    
}

- (void) encodeWithCoder: (NSCoder *) coder {
    
    [coder encodeBool: self.isMusicON forKey: @"isMusicON"];
    [coder encodeBool: self.isSoundEffectsON forKey: @"isSoundEffectsON"];
    [coder encodeInt: self.selectedLevel forKey: @"selectedLevel"];
    
    [coder encodeObject: self.hero1 forKey: @"hero1"];
    [coder encodeObject: self.hero2 forKey: @"hero2"];
    [coder encodeObject: self.hero3 forKey: @"hero3"];

    
}

- (id) initWithCoder: (NSCoder *) coder {
    
    if (self = [super init]) {
        
        self.isMusicON = [coder decodeBoolForKey: @"isMusicON"];
        self.isSoundEffectsON = [coder decodeBoolForKey: @"isSoundEffectsON"];
        self.selectedLevel = [coder decodeIntForKey: @"selectedLevel"];
        
        self.hero1 = [coder decodeObjectForKey: @"hero1"];
        self.hero2 = [coder decodeObjectForKey: @"hero2"];
        self.hero3 = [coder decodeObjectForKey: @"hero3"];
    }
    
    return self;
}

- (NSDictionary *) getInformationForLevel: (int) levelNumber {
    
    NSString *levelString = [NSString stringWithFormat: @"Level %d", levelNumber];
    NSString *pathString = [[NSBundle mainBundle] pathForResource: @"levelInformation" ofType: @"plist"];
    
    NSDictionary *mainDictionary = [NSDictionary dictionaryWithContentsOfFile: pathString];
    NSDictionary *levelArray = [mainDictionary valueForKey: levelString];
    
    return levelArray;
    
}

- (id) init
{
    if (self = [super init])
    {
        CCLOG(@"GameManager singleton, init");
        self.numberOfEnemiesKilled = 0;
        self.numberOfEnemiesPassed = 0;
        self.currentScene = kIntroScene;
        
        // for the audio
        hasAudioBeenInitialized = NO;
        soundEngine = nil;
        managerSoundState = kAudioManagerUninitialized;
                
        // [self initPathPointsAndSolutions];
        // [self initEnemyRoundInformation];
        
        self.accuracy_static_power = 0.0f;
        self.range_static_power = 0.0f;
        self.proc_static_power = NO;
        
        // PERSISTENT VARIABLES
        
        self.isMusicON = YES;
        self.isSoundEffectsON = YES;
        
        self.hero1 = [Hero createHero];
        self.hero1.fileID = 1;
        
        self.hero2 = [Hero createHero];
        self.hero2.fileID = 2;
        
        self.hero3 = [Hero createHero];
        self.hero3.fileID = 3;
        
    }
    
    return self;
}

- (int) intFromUnichar: (unichar) c {
    
    int intToReturn;
    
    if (c == '0') {
        intToReturn = 0;
    } else if (c == '1') {
        intToReturn = 1;
    } else if (c == '2') {
        intToReturn = 2;
    } else if (c == '3') {
        intToReturn = 3;
    } else if (c == '4') {
        intToReturn = 4;
    } else if (c == '5') {
        intToReturn = 5;
    } else if (c == '6') {
        intToReturn = 6;
    } else if (c == '7') {
        intToReturn = 7;
    } else if (c == '8') {
        intToReturn = 8;
    } else if (c == '9') {
        intToReturn = 9;
    } else {
        intToReturn = 9999;
    }
    
    return intToReturn;
    
}

// this returns an array of NSNumber's from an NSString
- (NSArray *) getEnemyRoundArray: (NSString *) enemyStringInformation {
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < [enemyStringInformation length]; i++) {
        
        unichar c = [enemyStringInformation characterAtIndex: i];
        int enemyNumber = [self intFromUnichar: c];
        NSNumber *n = [NSNumber numberWithInt: enemyNumber];
        
        [tmpArray addObject: n];
    }
    
    return tmpArray;
}

- (NSArray *) getPointArrayFromStringArray: (NSArray *) stringArray {
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSString *s in stringArray) {
        
        NSString *pointString = [NSString stringWithFormat: @"{%@}", s];
        CGPoint myPoint = CGPointFromString(pointString);
        NSValue *v = [NSValue valueWithCGPoint: myPoint];
        
        [tmpArray addObject: v];
    }
    
    return tmpArray;
}

@end













