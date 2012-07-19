//
//  HelpLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpLayer.h"
#import "GameScene1.h"

@implementation HelpLayer

@synthesize leftButton;
@synthesize rightButton;
@synthesize gs1_reference;

@synthesize pageSprite1;
@synthesize pageSprite2;
@synthesize pageSprite3;
@synthesize pageSprite4;
@synthesize pageSprite5;
@synthesize arrayOfSprites;

- (void) dealloc {
    
    self.leftButton = nil;
    self.rightButton = nil;
    self.gs1_reference = nil;
    
    self.pageSprite1 = nil;
    self.pageSprite2 = nil;
    self.pageSprite3 = nil;
    self.pageSprite4 = nil;
    self.pageSprite5 = nil;
    self.arrayOfSprites = nil;
    
    [super dealloc];
}

- (void) goToPage: (CCMenuItemSprite *) sender {
    
    PLAYSOUNDEFFECT(back_button_sound);
    
    CCLOG(@"entering goToPage");
    CCLOG(@"sender tag: %d", sender.tag);
    
    switch (sender.tag) {
            
            // skip button pressed
        case 0:
            [FlurryAnalytics logEvent: @"skip button pressed"];
            [gs1_reference endIntro];
            break;
            
            // go to page 1
        case 1:
            [self chooseVisibleSpriteFromArray: sender.tag - 1];
            self.leftButton.tag = 0;
            self.rightButton.tag = 2;
            self.leftButton.normalImage = [CCSprite spriteWithSpriteFrameName: @"skip_button_1.png"];
            self.leftButton.selectedImage = [CCSprite spriteWithSpriteFrameName: @"skip_button_2.png"];
            break;
            
            // go to page 2
        case 2:
            [self chooseVisibleSpriteFromArray: sender.tag - 1];
            self.leftButton.tag = 1;
            self.rightButton.tag = 3;
            self.leftButton.normalImage = [CCSprite spriteWithSpriteFrameName: @"back_button_1.png"];
            self.leftButton.selectedImage = [CCSprite spriteWithSpriteFrameName: @"back_button_2.png"];
            break;
            
            // go to page 3
        case 3:
            [self chooseVisibleSpriteFromArray: sender.tag - 1];
            self.leftButton.tag = 2;
            self.rightButton.tag = 4;
            break;
            
            // go to page 4
        case 4:
            [self chooseVisibleSpriteFromArray: sender.tag - 1];
            self.leftButton.tag = 3;
            self.rightButton.tag = 5;
            self.rightButton.normalImage = [CCSprite spriteWithSpriteFrameName: @"next_button_1.png"];
            self.rightButton.selectedImage = [CCSprite spriteWithSpriteFrameName: @"next_button_2.png"];
            break;
            
            // go to page 5
        case 5:
            [self chooseVisibleSpriteFromArray: sender.tag - 1];
            self.leftButton.tag = 4;
            self.rightButton.tag = 6;
            self.rightButton.normalImage = [CCSprite spriteWithSpriteFrameName: @"done_button_1.png"];
            self.rightButton.selectedImage = [CCSprite spriteWithSpriteFrameName: @"done_button_2.png"];
            break;
            
            // done button pressed
        case 6:
            [FlurryAnalytics logEvent: @"done button pressed"];
            [gs1_reference endIntro];
            break;
                        
        default:
            CCLOG(@"HelpLayer: unrecognized sender tag");
            break;
    }
    
}

- (void) chooseVisibleSpriteFromArray: (int) index {
    
    for (int i = 0; i < 5; i++) {
        
        CCSprite *s = [arrayOfSprites objectAtIndex: i];
        
        if (i == index) {
            s.visible = YES;
        } else {
            s.visible = NO;
        }
    }
}


- (id) init {
    
    if (self = [super init]) {
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        float offsetX = 80.0f;
        
        // add first page background
        self.pageSprite1 = [CCSprite spriteWithFile: @"intro_screen_1.png"];
        self.pageSprite2 = [CCSprite spriteWithFile: @"intro_screen_2.png"];
        self.pageSprite3 = [CCSprite spriteWithFile: @"intro_screen_3.png"];
        self.pageSprite4 = [CCSprite spriteWithFile: @"intro_screen_4.png"];
        self.pageSprite5 = [CCSprite spriteWithFile: @"intro_screen_5.png"];
        
        self.arrayOfSprites = [NSArray arrayWithObjects: pageSprite1, pageSprite2, pageSprite3, pageSprite4, pageSprite5, nil];
        
        for (int i = 0; i < 5; i++) {
            
            CCSprite *s = [arrayOfSprites objectAtIndex: i];
            
            s.zOrder = 1;
            s.tag = i;
            s.position = ccp(screenSize.width/2, screenSize.height/2);
            s.visible = NO;
            
            [self addChild: s];
        }
        
        // make first page visible
        pageSprite1.visible = YES;
        
        // initialize and add buttons
        CCSprite *leftButtonNormal = [CCSprite spriteWithSpriteFrameName: @"skip_button_1.png"];
        CCSprite *leftButtonSelected = [CCSprite spriteWithSpriteFrameName: @"skip_button_2.png"];
        
        CCSprite *rightButtonNormal = [CCSprite spriteWithSpriteFrameName: @"next_button_1.png"];
        CCSprite *rightButtonSelected = [CCSprite spriteWithSpriteFrameName: @"next_button_2.png"];
        
        self.leftButton = [CCMenuItemSprite itemWithNormalSprite: leftButtonNormal selectedSprite: leftButtonSelected
                                                          target: self
                                                        selector: @selector(goToPage:)];
        //self.leftButton.zOrder = 5;
        //self.leftButton.position = ccp(screenSize.width/2 - offsetX, screenSize.height/4);
        self.leftButton.tag = 0;
        
        self.rightButton = [CCMenuItemSprite itemWithNormalSprite: rightButtonNormal selectedSprite: rightButtonSelected
                                                           target: self
                                                         selector: @selector(goToPage:)];
        //self.rightButton.zOrder = 5;
        //self.rightButton.position = ccp(screenSize.width/2 + offsetX, screenSize.height/2);
        self.rightButton.tag = 2;
        
        CCMenu *buttonMenu = [CCMenu menuWithItems: leftButton, rightButton, nil];
        [buttonMenu alignItemsHorizontallyWithPadding: offsetX];
        buttonMenu.position = ccp(screenSize.width/2, 55.0f);
        buttonMenu.zOrder = 9999;
        
        [self addChild: buttonMenu];
    }
    
    
    return self;
}

@end















