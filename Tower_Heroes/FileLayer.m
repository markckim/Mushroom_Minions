//
//  FileLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileLayer.h"

@implementation FileLayer

@synthesize sButton1;
@synthesize sButton2;
@synthesize sButton3;

@synthesize saveSprite1_normal;
@synthesize saveSprite1_selected;
@synthesize saveSprite2_normal;
@synthesize saveSprite2_selected;
@synthesize saveSprite3_normal;
@synthesize saveSprite3_selected;

@synthesize saveLabel1;
@synthesize saveLabel2;
@synthesize saveLabel3;

@synthesize deleteText1;
@synthesize deleteText2;
@synthesize deleteText3;

@synthesize dMenu1;
@synthesize dMenu2;
@synthesize dMenu3;

@synthesize spriteDictionary;

@synthesize popUpSprite;
@synthesize yesNoMenu;
@synthesize message;
@synthesize yesItem;

- (void) dealloc {
    
    self.sButton1 = nil;
    self.sButton2 = nil;
    self.sButton3 = nil;
    
    self.saveSprite1_normal = nil;
    self.saveSprite1_selected = nil;
    self.saveSprite2_normal = nil;
    self.saveSprite2_selected = nil;
    self.saveSprite3_normal = nil;
    self.saveSprite3_selected = nil;
    
    self.saveLabel1 = nil;
    self.saveLabel2 = nil;
    self.saveLabel3 = nil;
    
    self.deleteText1 = nil;
    self.deleteText2 = nil;
    self.deleteText3 = nil;
    
    self.dMenu1 = nil;
    self.dMenu2 = nil;
    self.dMenu3 = nil;
    
    self.spriteDictionary = nil;
    
    self.popUpSprite = nil;
    self.yesNoMenu = nil;
    self.message = nil;
    self.yesItem = nil;
    
    [super dealloc];
}

- (void) newCharacter: (CCMenuItemSprite *) sender {
    
    GameManager *m = [GameManager sharedGameManager];
    
    NSString *heroString = [NSString stringWithFormat: @"hero%d", sender.tag];
    
    m.newlyCreatedHero = YES;
    m.tempCharacterID = 0;
    m.selectedHero = [spriteDictionary objectForKey: heroString];
    
    [self characterSelectionScene];
}

- (void) savedCharacter: (CCMenuItemSprite *) sender {
    
    GameManager *m = [GameManager sharedGameManager];
    
    NSString *heroString = [NSString stringWithFormat: @"hero%d", sender.tag];
    
    m.selectedHero = [spriteDictionary objectForKey: heroString];
    
    // quick note on variables:
    
    // m.newlyCreatedHero will be used by the LevelSelectionScene to determine 
    // whether the back button should go to FileScene (it was a saved character) or CharacterSelectionScene (it was a newly created character)
    
    // m.tempCharacterID will be used by the CharacterSelectionScene to determine
    // if any of the characters on the screen should be highlighted when the CharacterSelectionLayer is initialized
    
    // this if statement checks to see if this file was recently deleted
    // (the selector is still unfortunately pointing to this method (instead of newCharacter:)
    // so this is a quick check to see if we should direct elsewhere (i.e., CharacterSelectionScene)
    if (m.selectedHero.isNewFile == YES) {
        m.newlyCreatedHero = YES;
        m.tempCharacterID = 0;
        
        [self characterSelectionScene];
    } else if (m.selectedHero.isNewFile == NO) {
        m.newlyCreatedHero = NO;
        [self levelSelectionScene];
    }
    
}

- (void) deleteHero: (CCMenuItemLabel *) sender {
    
    self.popUpSprite.visible = NO;
    self.message.visible = NO;
    self.yesNoMenu.visible = NO;  
    
    // this happens if the user pressed "No"
    if (sender.tag == 0) {
        
        PLAYSOUNDEFFECT(power_select_button_sound);
        
        return;
    }
            
    CCSprite *normalSprite = [CCSprite spriteWithSpriteFrameName: @"new_file_1.png"];
    CCSprite *selectedSprite = [CCSprite spriteWithSpriteFrameName: @"new_file_2.png"];
    
    NSString *heroString = [NSString stringWithFormat: @"hero%d", sender.tag];
    NSString *labelString = [NSString stringWithFormat: @"saveLabel%d", sender.tag];
    NSString *buttonString = [NSString stringWithFormat: @"sButton%d", sender.tag];
    
    Hero *h = [spriteDictionary objectForKey: heroString];
    CCLabelBMFont *saveLabel = [spriteDictionary objectForKey: labelString];
    CCMenuItemSprite *sButton = [spriteDictionary objectForKey: buttonString];
    
    PLAYSOUNDEFFECT(tower_remove_button_sound);
    [h reset];
    
    CCLOG(@"new hero's isNewFile BOOL variable: %d", h.isNewFile);
    CCLOG(@"hero description %@", h.description);
    CCLOG(@"hero tag: %d", sender.tag);
    
    saveLabel.string = @"New";
    saveLabel.scale = 0.95f;
    sButton.normalImage = normalSprite;
    sButton.selectedImage = selectedSprite;
    
    // delete the "delete" label
    NSString *deleteString = [NSString stringWithFormat: @"deleteText%d", sender.tag];
    CCLabelBMFont *dText = [spriteDictionary objectForKey: deleteString];
    [self removeChild: dText 
              cleanup: YES];
    
    // remove sender "delete" button menu
    NSString *dMenuString = [NSString stringWithFormat: @"dMenu%d", sender.tag];
    CCMenu *dMenu = [spriteDictionary objectForKey: dMenuString];
    
    [self removeChild: dMenu 
              cleanup: YES];
    
}

- (void) areYouSureScreen: (CCMenuItemSprite *) sender {
    
    PLAYSOUNDEFFECT(power_select_button_sound);
    
    // initialize the screen
    if (self.popUpSprite == nil) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.popUpSprite = [CCSprite spriteWithSpriteFrameName: @"level_complete_1.png"];
        popUpSprite.zOrder = 99999;
        popUpSprite.position = ccp(screenSize.width/2, screenSize.height/2);
        
        NSString *deleteString = [NSString stringWithFormat: @"Delete File?"];
        self.message = [CCLabelBMFont labelWithString: deleteString fntFile: @"MushroomTextSmall.fnt"
                                                width: 150.0f alignment: CCTextAlignmentCenter];
        message.zOrder = popUpSprite.zOrder + 1;
        message.position = ccp(screenSize.width/2, screenSize.height/2 + 20.0f);
        message.color = ccYELLOW;
        
        CCLabelBMFont *yesLabel = [CCLabelBMFont labelWithString: @"Yes" fntFile: @"MushroomTextSmall.fnt"];
        yesLabel.zOrder = message.zOrder;
        yesLabel.scale = 0.9f;
        self.yesItem = [CCMenuItemLabel itemWithLabel: yesLabel target: self selector: @selector(deleteHero:)];
        
        CCLabelBMFont *noLabel = [CCLabelBMFont labelWithString: @"No" fntFile: @"MushroomTextSmall.fnt"];
        noLabel.zOrder = message.zOrder;
        noLabel.scale = 0.9f;
        CCMenuItemLabel *noItem = [CCMenuItemLabel itemWithLabel: noLabel target: self selector: @selector(deleteHero:)];
        noItem.tag = 0;
        
        float padding = 30.0f;
        self.yesNoMenu = [CCMenu menuWithItems: noItem, yesItem, nil];
        [yesNoMenu alignItemsHorizontallyWithPadding: 1.5f*padding];
        yesNoMenu.position = ccp(screenSize.width/2, screenSize.height/2 - padding);
        yesNoMenu.zOrder = message.zOrder;
        
        [self addChild: popUpSprite];
        [self addChild: message];
        [self addChild: yesNoMenu];
        
        // initialize as invisible
        self.popUpSprite.visible = NO;
        self.message.visible = NO;
        self.yesNoMenu.visible = NO;
        
    }
    
    // this is so the appropriate hero can be deleted if "Yes" is selected
    
    // this is to prevent the user from accidentally deleting hero Y when the message is 
    // still asking the user whether they should delete hero X
    if (popUpSprite.visible == YES) {
        return;
    }
    
    
    self.yesItem.tag = sender.tag;
    
    self.popUpSprite.visible = YES;
    self.message.visible = YES;
    self.yesNoMenu.visible = YES;
        
}

- (void) insertFileButtons {
    
    float adPaddingY = 25.0f;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.saveLabel1 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"
                                                         width: 200 alignment: UITextAlignmentCenter];
    self.saveLabel2 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"
                                                         width: 200 alignment: UITextAlignmentCenter];
    self.saveLabel3 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"
                                                         width: 200 alignment: UITextAlignmentCenter];
        
    self.saveSprite1_normal = [CCSprite node];
    self.saveSprite1_selected = [CCSprite node];
    
    self.saveSprite2_normal = [CCSprite node];
    self.saveSprite2_selected = [CCSprite node];
    
    self.saveSprite3_normal = [CCSprite node];
    self.saveSprite3_selected = [CCSprite node];
    
    self.sButton1 = [CCMenuItemSprite node];
    self.sButton2 = [CCMenuItemSprite node];
    self.sButton3 = [CCMenuItemSprite node];
    
    self.deleteText1 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
    self.deleteText2 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
    self.deleteText3 = [CCLabelBMFont labelWithString: @"-" fntFile: @"MushroomTextSmall.fnt"];
    
    self.dMenu1 = [CCMenu menuWithItems: nil];
    self.dMenu2 = [CCMenu menuWithItems: nil];
    self.dMenu3 = [CCMenu menuWithItems: nil];

    GameManager *m = [GameManager sharedGameManager];
    
    self.spriteDictionary = [NSDictionary dictionaryWithObjectsAndKeys: 
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
                             sButton3, @"sButton3", 
                             deleteText1, @"deleteText1",
                             deleteText2, @"deleteText2",
                             deleteText3, @"deleteText3",
                             m.hero1, @"hero1", 
                             m.hero2, @"hero2", 
                             m.hero3, @"hero3", 
                             dMenu1, @"dMenu1", 
                             dMenu2, @"dMenu2",
                             dMenu3, @"dMenu3", 
                             nil];
        
    CCArray *arrayOfHeroes = [CCArray array];
    [arrayOfHeroes addObject: m.hero1];
    [arrayOfHeroes addObject: m.hero2];
    [arrayOfHeroes addObject: m.hero3];
    
    int i = 1;
    
    for (Hero *h in arrayOfHeroes) {
        
        NSString *spriteStringNormal = [NSString stringWithFormat: @"saveSprite%d_normal", i];
        NSString *spriteStringSelected = [NSString stringWithFormat: @"saveSprite%d_selected", i];
        NSString *saveLabelString = [NSString stringWithFormat: @"saveLabel%d", i];
        NSString *menuItemString = [NSString stringWithFormat: @"sButton%d", i];
        NSString *selectorString;
        
        CCSprite *sNormal = (CCSprite *) [spriteDictionary objectForKey: spriteStringNormal];
        CCSprite *sSelected = (CCSprite *) [spriteDictionary objectForKey: spriteStringSelected];
        CCLabelBMFont *saveLabel = (CCLabelBMFont *) [spriteDictionary objectForKey: saveLabelString];
        CCMenuItemSprite *menuItemSprite = (CCMenuItemSprite *) [spriteDictionary objectForKey: menuItemString];
        
        saveLabel.zOrder = 5;
        
        if (h.isNewFile == YES) {
                        
            sNormal.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: @"new_file_1.png"];
            sSelected.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: @"new_file_2.png"];
            saveLabel.string = @"New";
            selectorString = [NSString stringWithFormat: @"newCharacter:"];
            
            saveLabel.scale = 0.9f;
            //saveLabel.color = ccGRAY;
            
            float buttonWidth = sNormal.contentSize.width;
            float j = (float) i;
            float padding = (screenSize.width - 3.0f*buttonWidth)/4.0f;
            
            CGPoint labelPos = ccp(j*padding + (j - 1.0f)*buttonWidth + (0.5f)*buttonWidth, screenSize.height/2.0f + adPaddingY);
            
            saveLabel.position = labelPos;
            
        } else if (h.isNewFile == NO) {
            
            NSString *heroString1 = [NSString stringWithFormat: @"hero%d_file_1.png", h.characterID];
            NSString *heroString2 = [NSString stringWithFormat: @"hero%d_file_2.png", h.characterID];
            selectorString = [NSString stringWithFormat: @"savedCharacter:"];
                        
            NSString *heroNameString;
            if (h.characterID == 1) {
                heroNameString = HERO_NAME_1;
            } else if (h.characterID == 2) {
                heroNameString = HERO_NAME_2;
            } else if (h.characterID == 3) {
                heroNameString = HERO_NAME_3;
            }
            
            // string identifying level
            NSString *levelString = [NSString stringWithFormat: @"Level %d", h.characterLevel];
            
            CCLOG(@"character file #: %d", h.fileID);
            CCLOG(@"character id: %d", h.characterID);
            CCLOG(@"%@", heroNameString);
            CCLOG(@"%@", levelString);
            
            NSString *fullNameString = [NSString stringWithFormat: @"%@\n%@", heroNameString, levelString];
            
            sNormal.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                    spriteFrameByName: heroString1];
            sSelected.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                      spriteFrameByName: heroString2];
            saveLabel.string = fullNameString;
            
            saveLabel.scale = 0.75f;
            
            float buttonWidth = sNormal.contentSize.width;
            float j = (float) i;
            float padding1 = (screenSize.width - 3.0f*buttonWidth)/4.0f;
            
            CGPoint labelPos = ccp(j*padding1 + (j - 1.0f)*buttonWidth + (0.5f)*buttonWidth, screenSize.height/2.0f + adPaddingY);
            
            saveLabel.position = labelPos;
            
            // add a button for deleting the hero
            CCSprite *deleteNormal = [CCSprite spriteWithSpriteFrameName: @"delete_button_1.png"];
            CCSprite *deleteSelected = [CCSprite spriteWithSpriteFrameName: @"delete_button_2.png"];
            
            CCMenuItemSprite *dButton = [CCMenuItemSprite itemWithNormalSprite: deleteNormal
                                                                selectedSprite: deleteSelected
                                                                        target: self
                                                                      selector: @selector(areYouSureScreen:)];
            dButton.tag = i;
                        
            float bWidth = sNormal.contentSize.width;
            float bHeight = sNormal.contentSize.height;
            float padding = (screenSize.width - 3.0f*bWidth)/4.0f;
            float padding2 = 25.0f;
            
            CGPoint deletePos = ccp(j*padding + (j-1.0f)*bWidth + (0.5f)*bWidth, screenSize.height/2.0f - (0.5f)*bHeight - padding2 + adPaddingY + 8.0f);
            
            NSString *dMenuString = [NSString stringWithFormat: @"dMenu%d", i];
            
            CCMenu *dMenu = [spriteDictionary objectForKey: dMenuString];
            [dMenu addChild: dButton];            
            dMenu.position = deletePos;
            dMenu.zOrder = 5;
            
            NSString *deleteString = [NSString stringWithFormat: @"deleteText%d", i];
            CCLabelBMFont *dText = [spriteDictionary objectForKey: deleteString];
            
            dText.string = @"Delete";
            dText.scale = 0.85f;
            dText.zOrder = dMenu.zOrder + 1;
            dText.position = deletePos;
            
            [self addChild: dMenu];
            [self addChild: dText];
            
        }
        
        // change this
        SEL menuSelector = NSSelectorFromString(selectorString);
        
        [menuItemSprite initWithNormalSprite: sNormal
                              selectedSprite: sSelected
                              disabledSprite: nil
                                      target: self
                                    selector: menuSelector];
        menuItemSprite.tag = i;
        
        float buttonWidth = sNormal.contentSize.width;
        float buttonHeight = sNormal.contentSize.height;
        float padding = (screenSize.width - 3.0f*buttonWidth)/4.0f;
        float padding2 = 15.0f;
        float j = (float) i;
        
        CGPoint labelPos = ccp(j*padding + (j - 1.0f)*buttonWidth + (0.5f)*buttonWidth, screenSize.height/2.0f + adPaddingY);
        CGPoint labelPos2 = ccp(labelPos.x, labelPos.y + buttonHeight/2 + padding2);
        
        // saveLabel.position = labelPos;
        
        [self addChild: saveLabel];
        
        // insert title above the file
        NSString *fileString = [NSString stringWithFormat: @"File %d", i];
        CCLabelBMFont *fileName = [CCLabelBMFont labelWithString: fileString fntFile: @"MushroomTextSmall.fnt"];
        fileName.scale = 1.0f;
        // fileName.color = ccBLUE;
        fileName.position = labelPos2;
        fileName.zOrder = saveLabel.zOrder;
        
        [self addChild: fileName];
                
        i++;
    }
    
    float buttonWidth = sButton1.contentSize.width;
    float padding = (screenSize.width - 3.0f*buttonWidth)/4.0f;
    
    CCMenu *fileMenu = [CCMenu menuWithItems: sButton1, sButton2, sButton3, nil];
    [fileMenu alignItemsHorizontallyWithPadding: padding];
    fileMenu.position = ccp(screenSize.width/2, screenSize.height/2 + adPaddingY);
    
    [self addChild: fileMenu
                 z: 1
               tag: 3];
    
}

- (void) insertTitle {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelBMFont *titleLabel = [CCLabelBMFont labelWithString: @"Select File" fntFile: @"MushroomText.fnt"];
    titleLabel.scale = 0.7f;

    float offSetY = 35.0f;
    titleLabel.position = ccp(screenSize.width/2, screenSize.height - offSetY);
    
    [self addChild: titleLabel
                 z: 1
               tag: 1];
}

- (id) init {
    if (self = [super init]) {
        [self insertBackgroundImage];
        [self insertBackButtonWithSelector: @selector(playScene) withAds: YES];
        [self insertTitle];
        
        [self insertFileButtons];
        
        self.gameState = kGameStatePlaying;
        
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



















