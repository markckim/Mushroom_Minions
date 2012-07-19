//
//  PlayLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayLayer.h"
// #import "Playtomic.h"

@implementation PlayLayer

- (void) insertTitle {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
    CCLabelBMFont *playTitle = [CCLabelBMFont labelWithString: @"Tower Heroes" 
                                                      fntFile: @"MushroomText.fnt"];
    
    float offSetY = 35.0f;
    
    playTitle.position = ccp(screenSize.width/2, screenSize.height - offSetY);

    
    id actionScaleUp = [CCScaleTo actionWithDuration: 0.75 scale: 1.02f];
    id actionScaleDown = [CCScaleTo actionWithDuration: 1.0 scale: 1.0f];
    id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
    id actionForever = [CCRepeatForever actionWithAction: actionSequence];
    
    [playTitle runAction: actionForever];
    
    [self addChild: playTitle
                 z: kTitleZOrder
               tag: 1];
}

- (void) insertLinkButton {
    
    // insert link button here
    CCSprite *linkSpriteNormal = [CCSprite spriteWithSpriteFrameName: @"facebook_logo_1.png"];
    CCSprite *linkSpriteSelected = [CCSprite spriteWithSpriteFrameName: @"facebook_logo_2.png"];
    
    CCMenuItemSprite *linkButton = [CCMenuItemSprite itemWithNormalSprite: linkSpriteNormal
                                                           selectedSprite: linkSpriteSelected
                                                                   target: self
                                                                 selector: @selector (linkButtonPressed:)];
    CCMenu *linkMenu = [CCMenu menuWithItems: linkButton, nil];
    
    float padding = 7.0f;
    
    linkMenu.position = ccp(padding + linkButton.contentSize.width/2, linkButton.contentSize.height/2 + padding);
    
    [self addChild: linkMenu
                 z: kButtonZOrder
               tag: 2];
    
    // like us on facebook!
    CCLabelBMFont *likeLabel = [CCLabelBMFont labelWithString: @"Like us on Facebook!" fntFile: @"MushroomTextSmall.fnt"];
    likeLabel.anchorPoint = ccp(0, 0.5);
    likeLabel.position = ccp(2.5f*padding +linkSpriteNormal.contentSize.width, 6.0f + linkSpriteNormal.contentSize.height/2);
        
    [self addChild: likeLabel
                 z: kButtonZOrder
               tag: 2];
    
}

- (void) linkButtonPressed: (id) sender {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    [FlurryAnalytics logEvent:@"facebook button pressed"];
    
    NSURL *urlString = [NSURL URLWithString: @"http://www.facebook.com/TowerHeroes"];
    
    [[UIApplication sharedApplication] openURL: urlString];
}

- (void) fileScene {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    [FlurryAnalytics logEvent: @"play button pressed"];
    
    [[GameManager sharedGameManager] runSceneWithID: kFileScene];
}

- (void) insertPlayAndOptionButtons {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *playSprite = [CCSprite node];
    playSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                               spriteFrameByName: @"main_button_1.png"];
    
    CCSprite *playSpriteSelected = [CCSprite node];
    playSpriteSelected.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                       spriteFrameByName: @"main_button_2.png"];
    
    // change this to Character Scene later
    CCMenuItemSprite *playMenuItem = [CCMenuItemSprite itemWithNormalSprite: playSprite
                                                             selectedSprite: playSpriteSelected
                                                                     target: self
                                                                   selector: @selector(fileScene)];
        
    id actionScaleUp = [CCScaleTo actionWithDuration: 0.75 scale: 1.05f];
    id actionScaleDown = [CCScaleTo actionWithDuration: 1.0 scale: 1.0f];
    id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
    id actionForever = [CCRepeatForever actionWithAction: actionSequence];
    
    [playMenuItem runAction: actionForever];
        
    CCMenu *menu = [CCMenu menuWithItems: playMenuItem, nil];
    [menu alignItemsVerticallyWithPadding: 15.0f];
    
    menu.position = ccp(screenSize.width/2, 70.0f);
    //menu.position = ccp(screenSize.width/2, screenSize.height/2);
    
    [self addChild: menu
                 z: 9999
               tag: 3];    
}

- (void) initImagesAndAnimations {
        
    // initializing the images
    
    // sprite frames for mostly the game scene
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"gs1atlas.plist"];
    
    // some of the sprite frames that are for the menu scenes
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"nonbatchatlas.plist"];

}

- (void) insertCover {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *coverSprite = [CCSprite spriteWithFile: @"cover_1.png"];
    coverSprite.zOrder = 999;
    coverSprite.scale = 1.00f;
            
    coverSprite.position = ccp(screenSize.width/2, screenSize.height/2);
        
    [self addChild: coverSprite];
    
}

- (void) insertSoundButton {
    
    GameManager *m = [GameManager sharedGameManager];
    
    CCSprite *soundButtonNormal = [CCSprite spriteWithSpriteFrameName: @"sound_button_1.png"];
    CCSprite *soundButtonSelected = [CCSprite spriteWithSpriteFrameName: @"sound_button_2.png"];
    
    CCMenuItemSprite *soundButton1 = [CCMenuItemSprite itemWithNormalSprite: soundButtonNormal
                                                             selectedSprite: nil];
    CCMenuItemSprite *soundButton2 = [CCMenuItemSprite itemWithNormalSprite: soundButtonSelected
                                                             selectedSprite: nil];
    
    CCMenuItemToggle *toggleButton = [CCMenuItemToggle itemWithTarget: m selector: @selector(muteSoundToggle:) items: soundButton1, soundButton2, nil];
    
    // check which setting the button should be on
    if (m.isMusicON == YES) {
        toggleButton.selectedIndex = 0;
    } else {
        toggleButton.selectedIndex = 1;
    }
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // insert credit button here
    CCSprite *creditSpriteNormal = [CCSprite spriteWithSpriteFrameName: @"credit_button_1.png"];
    CCSprite *creditSpriteSelected = [CCSprite spriteWithSpriteFrameName: @"credit_button_2.png"];
        
    CCMenuItemSprite *creditButton = [CCMenuItemSprite itemWithNormalSprite: creditSpriteNormal
                                                             selectedSprite: creditSpriteSelected
                                                                     target: self
                                                                   selector: @selector(creditScene)];
    
    CCMenu *soundMenu = [CCMenu menuWithItems: creditButton, toggleButton, nil];
    soundMenu.position = ccp(35.0f, screenSize.height -  120.0f);
    soundMenu.zOrder = 9999;
    [soundMenu alignItemsVerticallyWithPadding: 15.0f];
    
    [self addChild: soundMenu];
    
}

- (id) init {
    if (self = [super init]) {
        
        GameManager *m = [GameManager sharedGameManager];
        m.backgroundMusicConstant = 1;
               
        if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]) {
            [[GameManager sharedGameManager] playBackgroundTrack: BACKGROUND_TRACK_MAIN_MENU];
        }
        
        [self initImagesAndAnimations];

        [self insertBackgroundImage];
        [self insertTitle];
        [self insertPlayAndOptionButtons];
        
        [self insertCover];
        [self insertSoundButton];
                
        [self insertLinkButton];
        
        /*
        // FOR TESTING PURPOSES ONLY, remove these lines later
        // use fileID = 1, characterID = 3;
        [GameManager sharedGameManager].hero1.characterID = 3;
        [GameManager sharedGameManager].selectedHero = [GameManager sharedGameManager].hero1;
        [self insertNextButtonWithSelector: @selector(levelSelectionScene)];
        */
              
        /*
        // initialize playtomic analytics
        [[Playtomic alloc] initWithGameId: 428067 andGUID: @"507ab23c708e4c52" andAPIKey: @"933f835102a040b6b4dabb8094f61f"];
        [[Playtomic Log] view];
        */
    }
    return self;
}

@end
















