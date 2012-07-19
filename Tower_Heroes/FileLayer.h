//
//  FileLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@interface FileLayer : GameLayer {
    
    CCMenuItemSprite *sButton1;
    CCMenuItemSprite *sButton2;
    CCMenuItemSprite *sButton3;
 
    CCSprite *saveSprite1_normal;
    CCSprite *saveSprite1_selected;
    CCSprite *saveSprite2_normal;
    CCSprite *saveSprite2_selected;
    CCSprite *saveSprite3_normal;
    CCSprite *saveSprite3_selected;
    
    CCLabelBMFont *saveLabel1;
    CCLabelBMFont *saveLabel2;
    CCLabelBMFont *saveLabel3;
    
    CCLabelBMFont *deleteText1;
    CCLabelBMFont *deleteText2;
    CCLabelBMFont *deleteText3;
    
    NSDictionary *spriteDictionary;
    
}

@property (nonatomic, strong) CCSprite *popUpSprite;
@property (nonatomic, strong) CCMenu *yesNoMenu;
@property (nonatomic, strong) CCLabelBMFont *message;
@property (nonatomic, strong) CCMenuItemLabel *yesItem;

@property (nonatomic, strong) CCMenuItemSprite *sButton1;
@property (nonatomic, strong) CCMenuItemSprite *sButton2;
@property (nonatomic, strong) CCMenuItemSprite *sButton3;

@property (nonatomic, strong) CCSprite *saveSprite1_normal;
@property (nonatomic, strong) CCSprite *saveSprite1_selected;
@property (nonatomic, strong) CCSprite *saveSprite2_normal;
@property (nonatomic, strong) CCSprite *saveSprite2_selected;
@property (nonatomic, strong) CCSprite *saveSprite3_normal;
@property (nonatomic, strong) CCSprite *saveSprite3_selected;

@property (nonatomic, strong) CCLabelBMFont *saveLabel1;
@property (nonatomic, strong) CCLabelBMFont *saveLabel2;
@property (nonatomic, strong) CCLabelBMFont *saveLabel3;

@property (nonatomic, strong) CCLabelBMFont *deleteText1;
@property (nonatomic, strong) CCLabelBMFont *deleteText2;
@property (nonatomic, strong) CCLabelBMFont *deleteText3;

@property (nonatomic, strong) CCMenu *dMenu1;
@property (nonatomic, strong) CCMenu *dMenu2;
@property (nonatomic, strong) CCMenu *dMenu3;

@property (nonatomic, strong) NSDictionary *spriteDictionary;

- (void) newCharacter: (CCMenuItemSprite *) sender;
- (void) savedCharacter: (CCMenuItemSprite *) sender;

- (void) deleteHero: (CCMenuItemLabel *) sender;
- (void) areYouSureScreen: (CCMenuItemSprite *) sender;
- (void) insertFileButtons;

@end
