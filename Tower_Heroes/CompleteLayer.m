//
//  CompleteLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompleteLayer.h"

@implementation CompleteLayer

- (id) initWithLose {
    
    if (self = [super init]) {
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // add background image
        CCSprite *completeSprite = [CCSprite spriteWithSpriteFrameName: @"level_complete_1.png"];
        completeSprite.zOrder = 1;
        completeSprite.position = ccp(screenSize.width/2, screenSize.height/2);
        
        [self addChild: completeSprite];
        
        // add text
        float offsetY = 20.0f;
        
        CCLabelBMFont *completeLabel = [CCLabelBMFont labelWithString: @"You have lost!" fntFile: @"MushroomTextSmall.fnt"];
        completeLabel.zOrder = 2;
        completeLabel.position = ccp(screenSize.width/2, screenSize.height/2 + offsetY);
        
        [self addChild: completeLabel];
        
        // add okay button that directso to the level selection scene
        CCSprite *okayButtonNormal = [CCSprite spriteWithSpriteFrameName: @"okay_button_1.png"];
        CCSprite *okayButtonSelected = [CCSprite spriteWithSpriteFrameName: @"okay_button_2.png"];
        
        CCMenuItemSprite *okayButton = [CCMenuItemSprite itemWithNormalSprite: okayButtonNormal
                                                               selectedSprite: okayButtonSelected
                                                                       target: self
                                                                     selector: @selector(levelSelectionScene)];
        CCMenu *buttonMenu = [CCMenu menuWithItems: okayButton, nil];
        buttonMenu.position = ccp(screenSize.width/2, screenSize.height/2 - completeSprite.contentSize.height/4);
        buttonMenu.zOrder = 2;
        
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
        
        [FlurryAnalytics logEvent: @"lose level" withParameters: fDict];

        
        [self addChild: buttonMenu];

    }
    
    return self;
}

- (id) initWithWin {
    
    if (self = [super init]) {
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // add background image
        CCSprite *completeSprite = [CCSprite spriteWithSpriteFrameName: @"level_complete_1.png"];
        completeSprite.zOrder = 1;
        completeSprite.position = ccp(screenSize.width/2, screenSize.height/2);
        
        [self addChild: completeSprite];
        
        // add text
        float offsetY = 30.0f;

        CCLabelBMFont *completeLabel = [CCLabelBMFont labelWithString: @"You have won!" fntFile: @"MushroomTextSmall.fnt"];
        completeLabel.zOrder = 2;
        completeLabel.position = ccp(screenSize.width/2, screenSize.height/2 + offsetY);
        
        [self addChild: completeLabel];
        
        // add okay button that directso to the level selection scene
        CCSprite *okayButtonNormal = [CCSprite spriteWithSpriteFrameName: @"okay_button_1.png"];
        CCSprite *okayButtonSelected = [CCSprite spriteWithSpriteFrameName: @"okay_button_2.png"];
        
        CCMenuItemSprite *okayButton = [CCMenuItemSprite itemWithNormalSprite: okayButtonNormal
                                                               selectedSprite: okayButtonSelected
                                                                       target: self
                                                                     selector: @selector(levelSelectionScene)];
        CCMenu *buttonMenu = [CCMenu menuWithItems: okayButton, nil];
        buttonMenu.position = ccp(screenSize.width/2, screenSize.height/2 - completeSprite.contentSize.height/4);
        buttonMenu.zOrder = 2;
        
        [self addChild: buttonMenu];
        
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
        
        [FlurryAnalytics logEvent: @"win level" withParameters: fDict];

        
        // updating hero's last level completed
        if (m.selectedLevel > m.selectedHero.lastLevelCompleted) {
            m.selectedHero.lastLevelCompleted = m.selectedLevel;
        }

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
