//
//  GameLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer

@synthesize gameState;
@synthesize adWhirlView;

- (void) dealloc {
    
    self.adWhirlView.delegate = nil;
    self.adWhirlView = nil;
    
    [super dealloc];
    
}

- (void) popSceneOut {
        
    [[GameManager sharedGameManager] popScene];
}

- (void) insertTitleWithString: (NSString *) titleString {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelBMFont *titleLabel = [CCLabelBMFont labelWithString: titleString fntFile: @"MushroomText.fnt"];
    titleLabel.scale = 0.7f;
    
    float offSetY = 35.0f;
    titleLabel.position = ccp(screenSize.width/2, screenSize.height - offSetY);
    
    [self addChild: titleLabel
                 z: kTitleZOrder
               tag: 1];
}

- (void) popSceneOutResume {
    
    PLAYSOUNDEFFECT(pause_button_sound);
    
    [FlurryAnalytics logEvent: @"resume button pressed"];
    
    SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
    GameManager *m = [GameManager sharedGameManager];
    
    // [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    
    if (m.isMusicON) {
        
        s.backgroundMusicVolume = 1.0f;
    }
    
    [m popScene];
}

- (void) playSceneQuit {
    
    PLAYSOUNDEFFECT(back_button_sound);
        
    SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
    GameManager *m = [GameManager sharedGameManager];
    
    
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
    
    [FlurryAnalytics logEvent: @"quit button pressed" withParameters: fDict];

    
    if (s.isBackgroundMusicPlaying) {
        [s stopBackgroundMusic];
        [m playBackgroundTrack: BACKGROUND_TRACK_MAIN_MENU];
    }
    
    [m runSceneWithID: kPlayScene];
    
}

- (void) levelSelectionSceneQuit {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
    GameManager *m = [GameManager sharedGameManager];
    
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
    
    [FlurryAnalytics logEvent: @"levels button pressed" withParameters: fDict];
    
    if (s.isBackgroundMusicPlaying) {
        [s stopBackgroundMusic];
        [m playBackgroundTrack: BACKGROUND_TRACK_MAIN_MENU];
    }
    
    [m runSceneWithID: kLevelSelectionScene];
    
}

- (void) insertBackgroundImage {
        
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *backgroundImage = [CCSprite spriteWithFile: @"background_1.png"];
    backgroundImage.position = ccp(screenSize.width/2, screenSize.height/2);
    
    [self addChild: backgroundImage
                 z: kBackgroundZOrder
               tag: 0];
}

- (void) insertTitle {
    
    CCLOG(@"this method should be over-ridden depending on the title to show");
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *title = [CCLabelTTF labelWithString: @"Demo" 
                                         dimensions: CGSizeMake(400,30)
                                          alignment: UITextAlignmentCenter
                                           fontName: @"Helvetica"
                                           fontSize: 20];
    title.position = ccp(screenSize.width/2, screenSize.height - 25.0f);
    
    [self addChild: title
                 z: kTitleZOrder
               tag: 1];
}

- (void) insertBackButton {
    
    CCLOG(@"this method should be over-ridden with the back button pointing to the appropriate scene");
            
    CCSprite *backButtonNormal = [CCSprite node];
    CCSprite *backButtonSelected = [CCSprite node];
    backButtonNormal.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                     spriteFrameByName: @"back_button_1.png"];
    backButtonSelected.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                       spriteFrameByName: @"back_button_2.png"];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemWithNormalSprite: backButtonNormal
                                                           selectedSprite: backButtonSelected
                                                                   target: self
                                                                 selector: @selector(playScene)];
    
    float padding = 7.0f;
    CCMenu *backMenu = [CCMenu menuWithItems: backButton, nil];
    backMenu.position = ccp(backButton.contentSize.width/2 + padding, 
                            backButton.contentSize.height/2 + padding);
    
    [self addChild: backMenu
                 z: kButtonZOrder
               tag: 2];
}

- (void) insertBackButtonWithSelector: (SEL) sceneSelector withAds: (BOOL) adsOnLayer {
    CCSprite *backButtonNormal = [CCSprite node];
    CCSprite *backButtonSelected = [CCSprite node];
    backButtonNormal.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                     spriteFrameByName: @"back_button_1.png"];
    backButtonSelected.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                       spriteFrameByName: @"back_button_2.png"];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemWithNormalSprite: backButtonNormal
                                                           selectedSprite: backButtonSelected
                                                                   target: self
                                                                 selector: sceneSelector];
    
    float padding = 7.0f;
    float adPaddingY;
    
    if (adsOnLayer == YES) {
        adPaddingY = backButton.contentSize.height + 12.0f;
    } else {
        adPaddingY = 0.0f;
    }
    
    CCMenu *backMenu = [CCMenu menuWithItems: backButton, nil];
    backMenu.position = ccp(backButton.contentSize.width/2 + padding, 
                            backButton.contentSize.height/2 + padding + adPaddingY);
    
    [self addChild: backMenu
                 z: kButtonZOrder
               tag: 2];
}

- (CCMenuItemSprite *) insertNextButtonWithSelector: (SEL) sceneSelector withAds: (BOOL) adsOnLayer {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *nextButtonDisabled = [CCSprite node];
    CCSprite *nextButtonNormal = [CCSprite node];
    CCSprite *nextButtonSelected = [CCSprite node];
    
    nextButtonDisabled.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                       spriteFrameByName: @"next_button_0.png"];
    nextButtonNormal.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                     spriteFrameByName: @"next_button_1.png"];
    nextButtonSelected.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                       spriteFrameByName: @"next_button_2.png"];
    
    CCMenuItemSprite *nextButton = [CCMenuItemSprite itemWithNormalSprite: nextButtonNormal
                                                           selectedSprite: nextButtonSelected
                                                           disabledSprite: nextButtonDisabled
                                                                   target: self
                                                                 selector: sceneSelector];
    float padding = 7.0f;
    float adPaddingY;

    if (adsOnLayer == YES) {
        adPaddingY = nextButton.contentSize.height + 12.0f;
    } else {
        adPaddingY = 0.0f;
    }
    
    CCMenu *nextMenu = [CCMenu menuWithItems: nextButton, nil];
    nextMenu.position = ccp(screenSize.width - nextButton.contentSize.width/2 - padding, 
                            nextButton.contentSize.height/2 + padding + adPaddingY);
    
    [self addChild: nextMenu
                 z: kButtonZOrder
               tag: 2];
    
    return nextButton;
}

- (void) playSceneWithoutSound {
    [[GameManager sharedGameManager] runSceneWithID: kPlayScene];
}

- (void) playScene {
    
    PLAYSOUNDEFFECT(back_button_sound);
        
    [[GameManager sharedGameManager] runSceneWithID: kPlayScene];
}

- (void) creditScene {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    [FlurryAnalytics logEvent:@"credit button pressed"];

    [[GameManager sharedGameManager] runSceneWithID: kCreditScene];
}
- (void) optionScene {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    [[GameManager sharedGameManager] runSceneWithID: kOptionScene];
}

- (void) fileScene {
    
    PLAYSOUNDEFFECT(back_button_sound);

    [[GameManager sharedGameManager] runSceneWithID: kFileScene];
}

- (void) characterSelectionScene {
    
    PLAYSOUNDEFFECT(back_button_sound);

    [[GameManager sharedGameManager] runSceneWithID: kCharacterSelectionScene];
}

// this scene to be deleted
- (void) nameScene {
    [[GameManager sharedGameManager] runSceneWithID: kNameScene];
}

- (void) introScene {
    
    PLAYSOUNDEFFECT(hero_button_sound);

    [[GameManager sharedGameManager] runSceneWithID: kIntroScene];
}

- (void) levelSelectionScene {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    [[GameManager sharedGameManager] runSceneWithID: kLevelSelectionScene];
}


- (void) loadingSceneWithoutSound {
    
    [[GameManager sharedGameManager] runSceneWithID: kLoadingScene];
}
- (void) loadingScene {
    
    PLAYSOUNDEFFECT(play_button_sound);
    
    [[GameManager sharedGameManager] runSceneWithID: kLoadingScene];
}

- (void) gameSceneWithoutSound {
    
    [[GameManager sharedGameManager] runSceneWithID: kGameScene1];

}

- (void) gameScene {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    [[GameManager sharedGameManager] runSceneWithID: kGameScene1];
}

- (void) pauseScene {
    
    PLAYSOUNDEFFECT(pause_button_sound);
    
    [FlurryAnalytics logEvent: @"pause button pressed"];
    
    // [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    
    SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
    GameManager *m = [GameManager sharedGameManager];
    
    s.backgroundMusicVolume = 0.3f;
    
    [m pushSceneWithID: kPauseScene];
}

// this scene to be deleted
- (void) itemScene {
    [[GameManager sharedGameManager] runSceneWithID: kItemScene];
}

// this scene to be deleted
- (void) infoScene {
    [[GameManager sharedGameManager] runSceneWithID: kInfoScene];
}

- (void) talentScene {
    
    [[GameManager sharedGameManager] runSceneWithID: kTalentScene];
}

- (void) pushTalentScene {
    
    PLAYSOUNDEFFECT(talent_button_sound);
    
    GameManager *m = [GameManager sharedGameManager];

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
    
    [FlurryAnalytics logEvent: @"talent button pressed" withParameters: fDict];

    
    
    [m pushSceneWithID: kTalentScene];
}


// this scene to be deleted
- (void) itemScene2 {
    
    [[GameManager sharedGameManager] runSceneWithID: kItemScene2];
}

// this scene to be deleted
- (void) infoScene2 {
    
    PLAYSOUNDEFFECT(back_button_sound);

    [[GameManager sharedGameManager] runSceneWithID: kInfoScene2];
}

// this scene to be deleted
- (void) talentScene2 {
    
    PLAYSOUNDEFFECT(talent_button_sound);

    [[GameManager sharedGameManager] runSceneWithID: kTalentScene2];
}

- (void) characterSelectionScene2 {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    [[GameManager sharedGameManager] runSceneWithID: kCharacterSelectionScene2];
}

- (id) init {
    if (self = [super init]) {
        // initialization code here
        
        self.gameState = kGameStatePlaying;

    }
    return self;
}

# pragma mark - 
# pragma mark AdWhirlDelegate methods

- (void) adWhirlWillPresentFullScreenModal {
    
    if (self.gameState == kGameStatePlaying) {
        
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        [[CCDirector sharedDirector] pause];
    }
    
}

- (void) adWhirlDidDismissFullScreenModal {
    
    if (self.gameState == kGameStatePaused) {
        return;
    } else {
        self.gameState = kGameStatePlaying;
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        [[CCDirector sharedDirector] resume];
    }
}

- (NSString *) adWhirlApplicationKey {
    
    return @"756f8c35d970405eb17a4439917dc662";
}

- (UIViewController *) viewControllerForPresentingModalView {
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    UINavigationController *viewController = [app navController];  
    
    return viewController;
}

- (void) adjustAdSize {
    
    [UIView beginAnimations: @"AdResize" context: nil];
    [UIView setAnimationDuration: 0.2f];
    
    CGSize adSize = [adWhirlView actualAdSize];
    
    CGRect newFrame = adWhirlView.frame;
    
    newFrame.size.height = adSize.height;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    newFrame.size.width = screenSize.width;
    newFrame.origin.x = (self.adWhirlView.bounds.size.width - adSize.width)/2;
    
    newFrame.origin.y = (screenSize.height - adSize.height);
    
    adWhirlView.frame = newFrame;
    
    [UIView commitAnimations];
}

- (void) adWhirlDidReceiveAd: (AdWhirlView *) adWhirl_view {
    
    [adWhirl_view rotateToOrientation: UIInterfaceOrientationLandscapeRight];
    
    [self adjustAdSize];
}



@end































