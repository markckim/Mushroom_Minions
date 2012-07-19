//
//  TalentLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@interface TalentLayer : GameLayer
{
    
    // these labels are for how many points are in the talent
    CCLabelBMFont *aLabel;
    CCLabelBMFont *bLabel;
    CCLabelBMFont *cLabel;
    CCLabelBMFont *dLabel;
    CCLabelBMFont *eLabel;
    
    // these labels are the talent names
    CCLabelBMFont *aTitleLabel;
    CCLabelBMFont *bTitleLabel;
    CCLabelBMFont *cTitleLabel;
    CCLabelBMFont *dTitleLabel;
    CCLabelBMFont *eTitleLabel;
    
    // these labels are other hero details
    CCLabelBMFont *pointsLeftLabel;
    CCLabelBMFont *currentLevelLabel;
    CCLabelBMFont *currentXPLabel;
    CCLabelBMFont *totalXPLabel;
        
    // these labels describe the talent
    CCLabelBMFont *t3_label;
    CCLabelBMFont *t2b_label;
    CCLabelBMFont *t2a_label;
    CCLabelBMFont *t1b_label;
    CCLabelBMFont *t1a_label;
    
    // locked sprites to use on talents that aren't available yet
    CCSprite *t2a_locked;
    CCSprite *t2b_locked;
    CCSprite *t3_locked;
    
    // references to the menu item sprites created
    CCMenuItemSprite *tier1a;
    CCMenuItemSprite *tier1b;
    CCMenuItemSprite *tier2a;
    CCMenuItemSprite *tier2b;
    CCMenuItemSprite *tier3;
    
    // this dictionary holds the list of talent text descriptions to use
    // for a given hero
    NSMutableDictionary *talentTextDictionary;
    
    // highlighted sprite
    CCSprite *highlightedSprite;
    
    // reference to the selected menuitemsprite
    CCMenuItemSprite *selectedMenuSprite;
}

@property (nonatomic, strong) CCLabelBMFont *aLabel;
@property (nonatomic, strong) CCLabelBMFont *bLabel;
@property (nonatomic, strong) CCLabelBMFont *cLabel;
@property (nonatomic, strong) CCLabelBMFont *dLabel;
@property (nonatomic, strong) CCLabelBMFont *eLabel;
@property (nonatomic, strong) CCLabelBMFont *aTitleLabel;
@property (nonatomic, strong) CCLabelBMFont *bTitleLabel;
@property (nonatomic, strong) CCLabelBMFont *cTitleLabel;
@property (nonatomic, strong) CCLabelBMFont *dTitleLabel;
@property (nonatomic, strong) CCLabelBMFont *eTitleLabel;
@property (nonatomic, strong) CCLabelBMFont *pointsLeftLabel;
@property (nonatomic, strong) CCLabelBMFont *currentLevelLabel;
@property (nonatomic, strong) CCLabelBMFont *currentXPLabel;
@property (nonatomic, strong) CCLabelBMFont *totalXPLabel;

@property (nonatomic, strong) CCLabelBMFont *t3_label;
@property (nonatomic, strong) CCLabelBMFont *t2b_label;
@property (nonatomic, strong) CCLabelBMFont *t2a_label;
@property (nonatomic, strong) CCLabelBMFont *t1b_label;
@property (nonatomic, strong) CCLabelBMFont *t1a_label;

@property (nonatomic, strong) CCSprite *t2a_locked;
@property (nonatomic, strong) CCSprite *t2b_locked;
@property (nonatomic, strong) CCSprite *t3_locked;

@property (nonatomic, strong) CCMenuItemSprite *tier1a;
@property (nonatomic, strong) CCMenuItemSprite *tier1b;
@property (nonatomic, strong) CCMenuItemSprite *tier2a;
@property (nonatomic, strong) CCMenuItemSprite *tier2b;
@property (nonatomic, strong) CCMenuItemSprite *tier3;

@property (nonatomic, strong) CCSprite *highlightedSprite;
@property (nonatomic, assign) CCMenuItemSprite *selectedMenuSprite;

@property (nonatomic, strong) CCLabelBMFont *talentDescriptionLabel;
@property (nonatomic, strong) CCLabelBMFont *talentTitleLabel;
@property (nonatomic, strong) CCLabelBMFont *talentPointsLabel;

@property (nonatomic, strong) NSMutableDictionary *talentTextDictionary;

@property (nonatomic, strong) CCMenu *tierMenu1;
@property (nonatomic, strong) CCMenu *tierMenu2;
@property (nonatomic, strong) CCMenu *tierMenu3;

@property (nonatomic, strong) CCSprite *powersScreen;

- (void) upgradeTalent: (CCMenuItemSprite *) sender;
- (void) insertTalentTree;
- (void) insertResetButtonWithSelector: (SEL) resetSelector;
- (void) resetPoints;
- (void) updateTalentDescriptionWithKeyString: (NSString *) talentKey
                                 andSenderTag: (int) tag;

- (void) changeSelectedMenuSpriteTo: (CCMenuItemSprite *) sender;

- (void) initTalentTextDictionary;
- (void) insertHeroImage;
- (void) initPowerDescriptions;
- (void) insertTalentBackgroundImage;
- (void) insertPowersButton;
- (void) togglePowersScreen: (CCMenuItemToggle *) sender;

- (void) resetSelectedMenuSprite;

- (void) insertMainTitles; // inserting name of hero, and "Talents" title
- (void) insertResetAndApplyButtons;

@end




