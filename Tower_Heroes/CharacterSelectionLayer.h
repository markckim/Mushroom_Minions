//
//  CharacterLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@interface CharacterSelectionLayer : GameLayer {
    CCMenuItemSprite *nextButton;
    CCArray *arrayOfCharacters;
    
}

@property (nonatomic, strong) CCMenuItemSprite *nextButton;
@property (nonatomic, strong) CCArray *arrayOfCharacters;

@property (nonatomic, strong) CCLabelBMFont *heroDescriptionLabel;
@property (nonatomic, strong) CCLabelBMFont *heroStaticPowerDescriptionLabel;
@property (nonatomic, copy) NSString *heroDescriptionString1;
@property (nonatomic, copy) NSString *heroStaticPowerString1;
@property (nonatomic, copy) NSString *heroDescriptionString2;
@property (nonatomic, copy) NSString *heroStaticPowerString2;
@property (nonatomic, copy) NSString *heroDescriptionString3;
@property (nonatomic, copy) NSString *heroStaticPowerString3;

- (CCArray *) insertCharacterSelectionMenu;
- (void) nextButtonActivate;
- (void) selectedCharacter: (CCMenuItemSprite *) sender;
- (void) initHeroDescription;

@end
