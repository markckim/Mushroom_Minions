//
//  CharacterLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterSelectionLayer.h"
#import "CCRadioMenu.h"

@implementation CharacterSelectionLayer

@synthesize nextButton;
@synthesize arrayOfCharacters;

@synthesize heroDescriptionLabel;
@synthesize heroStaticPowerDescriptionLabel;
@synthesize heroDescriptionString1;
@synthesize heroDescriptionString2;
@synthesize heroDescriptionString3;
@synthesize heroStaticPowerString1;
@synthesize heroStaticPowerString2;
@synthesize heroStaticPowerString3;

- (void) dealloc {
    self.nextButton = nil;
    self.arrayOfCharacters = nil;
    
    self.heroDescriptionLabel = nil;
    self.heroStaticPowerDescriptionLabel = nil;
    self.heroDescriptionString1 = nil;
    self.heroDescriptionString2 = nil;
    self.heroDescriptionString3 = nil;
    self.heroStaticPowerString1 = nil;
    self.heroStaticPowerString2 = nil;
    self.heroStaticPowerString3 = nil;
    
    [super dealloc];
}

- (void) selectedCharacter: (CCMenuItemSprite *) sender {
    
    PLAYSOUNDEFFECT(power_select_button_sound);
    
    GameManager *m = [GameManager sharedGameManager];
    
    m.selectedHero.characterID = sender.tag;
    m.tempCharacterID = sender.tag;
    
    if (sender.tag == 1) {
        self.heroDescriptionLabel.string = self.heroDescriptionString1;
        self.heroStaticPowerDescriptionLabel.string = self.heroStaticPowerString1;
    } else if (sender.tag == 2) {
        self.heroDescriptionLabel.string = self.heroDescriptionString2;
        self.heroStaticPowerDescriptionLabel.string = self.heroStaticPowerString2;
    } else if (sender.tag == 3) {
        self.heroDescriptionLabel.string = self.heroDescriptionString3;
        self.heroStaticPowerDescriptionLabel.string = self.heroStaticPowerString3;
    }
    
    if (self.nextButton.isEnabled == NO) {
        [self nextButtonActivate];
    }
    
    if (self.heroDescriptionLabel.visible == NO) {
        self.heroDescriptionLabel.visible = YES;
    }
    
    if (self.heroStaticPowerDescriptionLabel.visible == NO) {
        self.heroStaticPowerDescriptionLabel.visible = YES;
    }
    
}

- (void) nextButtonActivate {
    
    self.nextButton.isEnabled =  YES;
    
    id actionScaleUp = [CCScaleTo actionWithDuration: 0.15f scale: 1.05f];
    id actionScaleDown = [CCScaleTo actionWithDuration: 0.3f scale: 1.0f];
    id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
    id actionForever = [CCRepeatForever actionWithAction: actionSequence];
    
    [self.nextButton runAction: actionForever];

}

- (void) insertEnterButton {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *enterLabel = [CCLabelTTF labelWithString: @"Enter" 
                                              dimensions: CGSizeMake(50,25)
                                               alignment: UITextAlignmentCenter
                                                fontName: @"Helvetica"
                                                fontSize: 14];
    CCMenuItemLabel *enterButton = [CCMenuItemLabel itemWithLabel: enterLabel target: self 
                                                         selector: @selector(introScene)];
    
    CCMenu *enterMenu = [CCMenu menuWithItems: enterButton, nil];
    enterMenu.position = ccp(screenSize.width*19/20, screenSize.height*1/20);
    
    [self addChild: enterMenu
                 z: 1
               tag: 2];
}


- (CCArray *) insertCharacterSelectionMenu {
    
    float adPaddingY = 10.0f;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
    CCLabelBMFont *saveLabel1 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"
                                                         width: 120 alignment: UITextAlignmentCenter];
    CCLabelBMFont *saveLabel2 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"
                                                         width: 120 alignment: UITextAlignmentCenter];
    CCLabelBMFont *saveLabel3 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"
                                                         width: 120 alignment: UITextAlignmentCenter];
    
    CCSprite *saveSprite1_normal = [CCSprite node];
    CCSprite *saveSprite1_selected = [CCSprite node];
    
    CCSprite *saveSprite2_normal = [CCSprite node];
    CCSprite *saveSprite2_selected = [CCSprite node];
    
    CCSprite *saveSprite3_normal = [CCSprite node];
    CCSprite *saveSprite3_selected = [CCSprite node];
    
    CCMenuItemSprite *sButton1 = [CCMenuItemSprite node];
    CCMenuItemSprite *sButton2 = [CCMenuItemSprite node];
    CCMenuItemSprite *sButton3 = [CCMenuItemSprite node];
    
    NSDictionary *spriteDictionary = [NSDictionary dictionaryWithObjectsAndKeys: 
                                      saveSprite1_normal, @"saveSprite1_normal",
                                      saveSprite1_selected, @"saveSprite1_selected",
                                      saveSprite2_normal, @"saveSprite2_normal",
                                      saveSprite2_selected, @"saveSprite2_selected",
                                      saveSprite3_normal, @"saveSprite3_normal",
                                      saveSprite3_selected, @"saveSprite3_selected",
                                      saveLabel1, @"saveLabel1",
                                      saveLabel2, @"saveLabel2",
                                      saveLabel3, @"saveLabel3", 
                                      sButton1, @"sButton1",
                                      sButton2, @"sButton2",
                                      sButton3, @"sButton3", nil];
    
    GameManager *m = [GameManager sharedGameManager];
    
    CCArray *arrayOfHeroes = [CCArray array];
    [arrayOfHeroes addObject: m.hero1];
    [arrayOfHeroes addObject: m.hero2];
    [arrayOfHeroes addObject: m.hero3];
        
    for (int i = 1; i <= 3; i++) {
        
        NSString *spriteStringNormal = [NSString stringWithFormat: @"saveSprite%d_normal", i];
        NSString *spriteStringSelected = [NSString stringWithFormat: @"saveSprite%d_selected", i];
        NSString *saveLabelString = [NSString stringWithFormat: @"saveLabel%d", i];
        NSString *menuItemString = [NSString stringWithFormat: @"sButton%d", i];
        
        CCSprite *sNormal = (CCSprite *) [spriteDictionary objectForKey: spriteStringNormal];
        CCSprite *sSelected = (CCSprite *) [spriteDictionary objectForKey: spriteStringSelected];
        CCLabelBMFont *saveLabel = (CCLabelBMFont *) [spriteDictionary objectForKey: saveLabelString];
        CCMenuItemSprite *menuItemSprite = (CCMenuItemSprite *) [spriteDictionary objectForKey: menuItemString];
        
        saveLabel.scale = 0.9f;
        saveLabel.zOrder = 5;
        
        NSString *heroString1 = [NSString stringWithFormat: @"hero%d_file_1.png", i];
        NSString *heroString2 = [NSString stringWithFormat: @"hero%d_file_2.png", i];
        
        NSString *heroNameLabel;
        if (i == 1) {
            heroNameLabel = HERO_NAME_1;
        } else if (i == 2) {
            heroNameLabel = HERO_NAME_2;
        } else if (i == 3) {
            heroNameLabel = HERO_NAME_3;
        }
        
        sNormal.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                spriteFrameByName: heroString1];
        sSelected.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                  spriteFrameByName: heroString2];
        saveLabel.string = heroNameLabel;
        
        [menuItemSprite initWithNormalSprite: sNormal
                              selectedSprite: sSelected
                              disabledSprite: nil
                                      target: self
                                    selector: @selector(selectedCharacter:)];
        menuItemSprite.tag = i;
        
        float buttonWidth = sNormal.contentSize.width;
        float buttonHeight = sNormal.contentSize.height;
        float padding = (screenSize.width - 3.0f*buttonWidth)/4.0f;
        float j = (float) i;
        float padding2 = 15.0f;
        
        CGPoint labelPos = ccp(j*padding + (j - 1.0f)*buttonWidth + (0.5f)*buttonWidth, screenSize.height/2.0f + adPaddingY);
        CGPoint labelPos2 = ccp(labelPos.x, labelPos.y + buttonHeight/2 + padding2);
        
        //CGPoint labelPos = ccp(j*padding + (j - 1.0f)*buttonWidth + (0.5f)*buttonWidth, screenSize.height/2 - 0.65f*buttonWidth);
        
        saveLabel.position = labelPos2;
        
        [self addChild: saveLabel];        
    }

    float buttonWidth = sButton1.contentSize.width;
    float padding = (screenSize.width - 3.0f*buttonWidth)/4.0f;
    
    CCRadioMenu *radioMenu = [CCRadioMenu menuWithItems: sButton1, sButton2, sButton3, nil];
    [radioMenu alignItemsHorizontallyWithPadding: padding];
    radioMenu.position = ccp(screenSize.width/2, screenSize.height/2 + adPaddingY);
        
    [self addChild: radioMenu
                 z: 1
               tag: 3];
        
    NSArray *tmpArray = [NSArray arrayWithObjects: radioMenu, sButton1, sButton2, sButton3, nil];
    return [CCArray arrayWithNSArray: tmpArray];
}

- (void) insertTitle {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelBMFont *titleLabel = [CCLabelBMFont labelWithString: @"Select Hero" fntFile: @"MushroomText.fnt"];
    titleLabel.scale = 0.7f;
    
    float offSetY = 35.0f;
    titleLabel.position = ccp(screenSize.width/2, screenSize.height - offSetY);
    
    [self addChild: titleLabel
                 z: 1
               tag: 1];
}

- (void) levelSelectionScene {
    
    GameManager *m = [GameManager sharedGameManager];
    m.selectedHero.isNewFile = NO;
    
    NSDictionary *heroDict;
    
    if (m.selectedHero.characterID == 1) {
        
        heroDict = [NSDictionary dictionaryWithObjectsAndKeys: @"cassiel", @"character selected", nil];
        [FlurryAnalytics logEvent: @"character selection menu" withParameters: heroDict];
        
    } else if (m.selectedHero.characterID == 2) {
        
        heroDict = [NSDictionary dictionaryWithObjectsAndKeys: @"severus", @"character selected", nil];
        [FlurryAnalytics logEvent: @"character selection menu" withParameters: heroDict];
        
    } else if (m.selectedHero.characterID == 3) {
        
        heroDict = [NSDictionary dictionaryWithObjectsAndKeys: @"despina", @"character selected", nil];
        [FlurryAnalytics logEvent: @"character selection menu" withParameters: heroDict];
        
    }
    
    [super levelSelectionScene];
}

- (void) initHeroDescription {
    
    float adPaddingY = 20.0f;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.heroDescriptionLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt" width: 360 
                                                     alignment: CCTextAlignmentCenter];
    self.heroDescriptionLabel.scale = 0.8f;
    self.heroDescriptionLabel.visible = NO;
    self.heroDescriptionLabel.zOrder = 9999;
    
    self.heroStaticPowerDescriptionLabel = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt" width: 500
                                                                alignment: CCTextAlignmentCenter];
    self.heroStaticPowerDescriptionLabel.scale = 0.65f;
    self.heroStaticPowerDescriptionLabel.visible = NO;
    self.heroStaticPowerDescriptionLabel.zOrder = 9999;
    self.heroStaticPowerDescriptionLabel.color = ccYELLOW;
    
    NSString *pathString = [[NSBundle mainBundle] pathForResource: @"CharacterDescription" ofType: @"plist"];
    NSDictionary *descDictionary = [NSDictionary dictionaryWithContentsOfFile: pathString];
    
    self.heroDescriptionString1 = [NSString stringWithFormat: @"%@ %@", HERO_NAME_1, [descDictionary valueForKey: @"Hero Description 1"]];
    self.heroDescriptionString2 = [NSString stringWithFormat: @"%@ %@", HERO_NAME_2, [descDictionary valueForKey: @"Hero Description 2"]];
    self.heroDescriptionString3 = [NSString stringWithFormat: @"%@ %@", HERO_NAME_3, [descDictionary valueForKey: @"Hero Description 3"]];
    
    //self.heroStaticPowerString1 = [NSString stringWithFormat: @"%@", [descDictionary valueForKey: @"Hero Static Power 1"]];
    //self.heroStaticPowerString2 = [NSString stringWithFormat: @"%@", [descDictionary valueForKey: @"Hero Static Power 2"]];
    //self.heroStaticPowerString3 = [NSString stringWithFormat: @"%@", [descDictionary valueForKey: @"Hero Static Power 3"]];
    
    float paddingY = 20.0f;
    
    self.heroDescriptionLabel.position = ccp(screenSize.width/2, 2.95f*paddingY + adPaddingY);
    //self.heroStaticPowerDescriptionLabel.position = ccp(screenSize.width/2, 1.2f*paddingY + adPaddingY);
    
    [self addChild: heroDescriptionLabel];
    //[self addChild: heroStaticPowerDescriptionLabel];
    
}

- (id) init {
    if (self = [super init]) {
        
        [self insertBackgroundImage];
        [self insertBackButtonWithSelector: @selector(fileScene) withAds: YES];
        [self insertTitle];
        
        [self initHeroDescription];
        
        self.nextButton = [self insertNextButtonWithSelector: @selector(levelSelectionScene) withAds: YES];
        self.arrayOfCharacters = [self insertCharacterSelectionMenu];
        
        CCRadioMenu *tmpRadioMenu = (CCRadioMenu *)[self.arrayOfCharacters objectAtIndex: 0];
        CCMenuItemSprite *tmpCharacter1 = (CCMenuItemSprite *)[self.arrayOfCharacters objectAtIndex: 1];
        CCMenuItemSprite *tmpCharacter2 = (CCMenuItemSprite *)[self.arrayOfCharacters objectAtIndex: 2];
        CCMenuItemSprite *tmpCharacter3 = (CCMenuItemSprite *)[self.arrayOfCharacters objectAtIndex: 3];
                
        GameManager *m = [GameManager sharedGameManager];
        
        if (m.tempCharacterID == 0) {
            self.nextButton.isEnabled = NO;
        } else {
            
            self.nextButton.isEnabled = YES;
            
            switch (m.tempCharacterID) {
                    
                case 1:
                    tmpRadioMenu.selectedItem_ = tmpCharacter1;
                    [tmpCharacter1 selected];
                    break;
                    
                case 2:
                    tmpRadioMenu.selectedItem_ = tmpCharacter2;
                    [tmpCharacter2 selected];
                    break;
                    
                case 3:
                    tmpRadioMenu.selectedItem_ = tmpCharacter3;
                    [tmpCharacter3 selected];
                    break;
                    
                default:
                    CCLOG(@"CharacterSelectionLayer: unidentified tempCharacterID");
                    break;
            }
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























