//
//  LevelSelectionLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectionLayer.h"

@implementation LevelSelectionLayer

- (void) insertLevelSelectionMenu {
    
    float adPaddingY = 15.0f;
    float adPaddingY2 = 25.0f;
    
    GameManager *m = [GameManager sharedGameManager];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenu *topMenu = [CCMenu node];
    CCMenu *bottomMenu = [CCMenu node];
    
    CCSprite *spriteExample = [CCSprite spriteWithSpriteFrameName: @"level_select_button_1.png"];
    spriteExample.scale = 0.8f;
    float buttonX = spriteExample.boundingBox.size.width;
    float buttonY = spriteExample.boundingBox.size.height;
    float paddingX = (screenSize.width - 5.0f*buttonX)/(6.0f + 2.0f);
    float paddingX2 = (screenSize.width - 4.0f*paddingX - 5.0f*buttonX)/2.0f;
    float paddingY = (screenSize.height - 2.0f*buttonX)/(3.0f);
    
    float pos_Y1 = 0.9f*(2.0f*paddingY + 1.5f*buttonY);
    float pos_Y2 = 1.15f*(1.0f*paddingY + 0.5f*buttonY);
    
    for (int i = 1; i <= 5; i++) {
        NSString *levelString = [NSString stringWithFormat: @"%d", i];
        CCSprite *levelSpriteNormal = [CCSprite spriteWithSpriteFrameName: @"level_select_button_1.png"];
        CCSprite *levelSpriteSelected = [CCSprite spriteWithSpriteFrameName: @"level_select_button_2.png"];
        CCSprite *levelSpriteDisabled = [CCSprite spriteWithSpriteFrameName: @"level_select_button_3.png"];
        
        CCLabelBMFont *levelLabel = [CCLabelBMFont labelWithString: levelString fntFile: @"MushroomTextSmall.fnt"];
        CCMenuItemSprite *levelButton = [CCMenuItemSprite itemWithNormalSprite: levelSpriteNormal
                                                                selectedSprite: levelSpriteSelected
                                                                disabledSprite: levelSpriteDisabled
                                                                        target: self
                                                                      selector: @selector(loadingSceneWithLevel:)];
        
        levelLabel.scale = 1.0f;
        levelLabel.zOrder = 2;
        levelLabel.position = ccp(paddingX2 + 0.5f*buttonX + (float)(i-1)*(paddingX + buttonX), pos_Y1 + adPaddingY);
        levelButton.tag = i;
        levelButton.scale = 0.8f;
        
        // check if level should be disabled based on the levels the hero has beaten
        if (m.selectedHero.lastLevelCompleted + 1 < i) {
            levelButton.isEnabled = NO;
        }
        
        [topMenu addChild: levelButton];
        [self addChild: levelLabel];
    }
    
    for (int i = 6; i <= 10; i++) {
        NSString *levelString = [NSString stringWithFormat: @"%d", i];
        CCSprite *levelSpriteNormal = [CCSprite spriteWithSpriteFrameName: @"level_select_button_1.png"];
        CCSprite *levelSpriteSelected = [CCSprite spriteWithSpriteFrameName: @"level_select_button_2.png"];
        CCSprite *levelSpriteDisabled = [CCSprite spriteWithSpriteFrameName: @"level_select_button_3.png"];
        
        CCLabelBMFont *levelLabel = [CCLabelBMFont labelWithString: levelString fntFile: @"MushroomTextSmall.fnt"];
        CCMenuItemSprite *levelButton = [CCMenuItemSprite itemWithNormalSprite: levelSpriteNormal
                                                                selectedSprite: levelSpriteSelected
                                                                disabledSprite: levelSpriteDisabled
                                                                        target: self
                                                                      selector: @selector(loadingSceneWithLevel:)];
        
        levelLabel.scale = 1.0f;
        levelLabel.zOrder = 2;
        levelLabel.position = ccp(paddingX2 + 0.5f*buttonX + (float)(i-6)*(paddingX + buttonX), pos_Y2 + adPaddingY2);
        levelButton.tag = i;
        levelButton.scale = 0.8f;
        
        // check if level should be disabled based on the levels the hero has beaten
        if (m.selectedHero.lastLevelCompleted + 1 < i) {
            levelButton.isEnabled = NO;
        }

        [bottomMenu addChild: levelButton];
        [self addChild: levelLabel];
    }
        
    [topMenu alignItemsHorizontallyWithPadding: paddingX];
    topMenu.position = ccp(screenSize.width/2.0f, pos_Y1 + adPaddingY);
    
    [bottomMenu alignItemsHorizontallyWithPadding: paddingX];
    bottomMenu.position = ccp(screenSize.width/2.0f, pos_Y2 + adPaddingY2);
    
    [self addChild: topMenu
                 z: 1
               tag: 3];
    
    [self addChild: bottomMenu
                 z: 1
               tag: 3];
    
}

- (void) loadingSceneWithLevel: (CCMenuItemLabel *) sender {
    
    [GameManager sharedGameManager].selectedLevel = sender.tag;
    [GameManager sharedGameManager].newlyCreatedHero = NO;
        
    [self loadingScene];
}


- (void) insertTitle {

    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelBMFont *titleLabel = [CCLabelBMFont labelWithString: @"Select Level" fntFile: @"MushroomText.fnt"];
    titleLabel.scale = 0.7f;
    
    float offSetY = 35.0f;
    titleLabel.position = ccp(screenSize.width/2, screenSize.height - offSetY);

    [self addChild: titleLabel
                 z: 1
               tag: 1];
}

- (void) backScene {
    
    GameManager *m = [GameManager sharedGameManager];
    
    if (m.newlyCreatedHero == NO) {
        [self fileScene];
    } else if (m.newlyCreatedHero == YES) {
        [self characterSelectionScene];
    }
}

- (id) init {
    if (self = [super init]) {
        
        GameManager *m = [GameManager sharedGameManager];
        m.backgroundMusicConstant = 1;
        
        SimpleAudioEngine *s = [SimpleAudioEngine sharedEngine];
        
        if (!s.isBackgroundMusicPlaying) {
            [m playBackgroundTrack: BACKGROUND_TRACK_MAIN_MENU];
        }
        
        [self insertBackgroundImage];
        [self insertTitle];
        [self insertBackButtonWithSelector: @selector(backScene) withAds: YES];
        
        [self insertLevelSelectionMenu];
    }
    return self;
}

- (void) onEnter {
    
    //1
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    UINavigationController *viewController = [app navController];  
    
    //2
    self.adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    //3
    self.adWhirlView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    
    //4
    [adWhirlView updateAdWhirlConfig];
    //5
	CGSize adSize = [adWhirlView actualAdSize];
    //6
    CGSize winSize = [CCDirector sharedDirector].winSize;
    //7
	self.adWhirlView.frame = CGRectMake((winSize.width/2)-(adSize.width/2),winSize.height-adSize.height,winSize.width,adSize.height);
    //8
	self.adWhirlView.clipsToBounds = YES;
    //9
    [viewController.view addSubview:adWhirlView];
    //10
    [viewController.view bringSubviewToFront:adWhirlView];
    //11
    [super onEnter];
}

- (void) onExit {
    
    if (adWhirlView) {
        [adWhirlView removeFromSuperview];
        [adWhirlView replaceBannerViewWith:nil];
        [adWhirlView ignoreNewAdRequests];
        [adWhirlView setDelegate:nil];
        self.adWhirlView = nil;
    }
    
    [super onExit];
}

@end






















