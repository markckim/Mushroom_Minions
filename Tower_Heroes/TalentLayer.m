//
//  TalentLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TalentLayer.h"
#import "ControlsLayer.h"
#import "GamePlayLayer.h"
#import "Tower.h"

@implementation TalentLayer

@synthesize tierMenu1;
@synthesize tierMenu2;
@synthesize tierMenu3;

@synthesize aLabel;
@synthesize bLabel;
@synthesize cLabel;
@synthesize dLabel;
@synthesize eLabel;
@synthesize aTitleLabel;
@synthesize bTitleLabel;
@synthesize cTitleLabel;
@synthesize dTitleLabel;
@synthesize eTitleLabel;

@synthesize pointsLeftLabel;
@synthesize currentLevelLabel;
@synthesize currentXPLabel;
@synthesize totalXPLabel;

@synthesize t3_label;
@synthesize t2b_label;
@synthesize t2a_label;
@synthesize t1b_label;
@synthesize t1a_label;

@synthesize tier1a;
@synthesize tier1b;
@synthesize tier2a;
@synthesize tier2b;
@synthesize tier3;

@synthesize t2a_locked;
@synthesize t2b_locked;
@synthesize t3_locked;

@synthesize talentTextDictionary;

@synthesize talentDescriptionLabel;
@synthesize talentTitleLabel;
@synthesize talentPointsLabel;

@synthesize highlightedSprite;
@synthesize selectedMenuSprite;

@synthesize powersScreen;

- (void) dealloc {
    
    self.tierMenu1 = nil;
    self.tierMenu2 = nil;
    self.tierMenu3 = nil;
    
    self.aLabel = nil;
    self.bLabel = nil;
    self.cLabel = nil;
    self.dLabel = nil;
    self.eLabel = nil;
    self.aTitleLabel = nil;
    self.bTitleLabel = nil;
    self.cTitleLabel = nil;
    self.dTitleLabel = nil;
    self.eTitleLabel = nil;
    self.t3_label = nil;
    self.t2b_label = nil;
    self.t2a_label = nil;
    self.t1b_label = nil;
    self.t1a_label = nil;
    self.t2a_locked = nil;
    self.t2b_locked = nil;
    self.t3_locked = nil;
    
    self.tier1a = nil;
    self.tier1b = nil;
    self.tier2a = nil;
    self.tier2b = nil;
    self.tier3 = nil;
    
    self.pointsLeftLabel = nil;
    self.currentLevelLabel = nil;
    self.currentXPLabel = nil;
    self.totalXPLabel = nil;
    
    self.talentTextDictionary = nil;
    
    self.talentDescriptionLabel = nil;
    self.talentTitleLabel = nil;
    self.talentPointsLabel = nil;
    
    self.highlightedSprite = nil;
    self.selectedMenuSprite = nil;
    
    self.powersScreen = nil;
    
    [super dealloc];
}

- (void) resetSelectedMenuSprite {
    
    GameManager *m = [GameManager sharedGameManager];
    
    float padding = 48.0f;
    
    CGPoint pos;
    NSString *titleString; // use this to identify the right string to show as the talent description title
    NSString *talentKeyString; // use this to access the right description from TalentText.plist
    NSString *talentPointsString; // shows number of talent points invested in the talent

    pos = ccp(tierMenu1.position.x - padding, tierMenu1.position.y);
    titleString = [NSString stringWithFormat: @"%@", aTitleLabel.string];
    talentKeyString = [NSString stringWithFormat: @"%@", m.key1];
    talentPointsString = [NSString stringWithFormat: @"%@", aLabel.string];

    // change selected menu sprite
    self.selectedMenuSprite = tier1a;
    
    // highlight selected menu sprite
    self.highlightedSprite.position = pos;
    
    // need to change text that's being shown
    NSDictionary *descriptionDict = [talentTextDictionary valueForKey: @"Talent Description"];
    self.talentTitleLabel.string = titleString;
    self.talentDescriptionLabel.string = [descriptionDict valueForKey: talentKeyString];
    self.talentPointsLabel.string = talentPointsString;
    
}

- (void) changeSelectedMenuSpriteTo: (CCMenuItemSprite *) sender {
    
    GameManager *m = [GameManager sharedGameManager];
    
    float padding = 48.0f;
    
    CGPoint pos;
    NSString *titleString; // use this to identify the right string to show as the talent description title
    NSString *talentKeyString; // use this to access the right description from TalentText.plist
    NSString *talentPointsString; // shows number of talent points invested in the talent
    
    switch (sender.tag) {
            
        case 1:
            pos = ccp(tierMenu1.position.x - padding, tierMenu1.position.y);
            titleString = [NSString stringWithFormat: @"%@", aTitleLabel.string];
            talentKeyString = [NSString stringWithFormat: @"%@", m.key1];
            talentPointsString = [NSString stringWithFormat: @"%@", aLabel.string];
            break;
            
        case 2:
            pos = ccp(tierMenu1.position.x + padding, tierMenu1.position.y);
            titleString = [NSString stringWithFormat: @"%@", bTitleLabel.string];
            talentKeyString = [NSString stringWithFormat: @"%@", m.key2];
            talentPointsString = [NSString stringWithFormat: @"%@", bLabel.string];
            break;
            
        case 3:
            pos = ccp(tierMenu2.position.x - padding, tierMenu2.position.y);
            titleString = [NSString stringWithFormat: @"%@", cTitleLabel.string];
            talentKeyString = [NSString stringWithFormat: @"%@", m.key3];
            talentPointsString = [NSString stringWithFormat: @"%@", cLabel.string];
            break;
            
        case 4:
            pos = ccp(tierMenu2.position.x + padding, tierMenu2.position.y);
            titleString = [NSString stringWithFormat: @"%@", dTitleLabel.string];
            talentKeyString = [NSString stringWithFormat: @"%@", m.key4];
            talentPointsString = [NSString stringWithFormat: @"%@", dLabel.string];
            break;
            
        case 5:
            pos = ccp(tierMenu3.position.x, tierMenu3.position.y);
            titleString = [NSString stringWithFormat: @"%@", eTitleLabel.string];
            talentKeyString = [NSString stringWithFormat: @"%@", m.key5];
            talentPointsString = [NSString stringWithFormat: @"%@", eLabel.string];
            break;
            
        default:
            CCLOG(@"changeSelectedMenuSpriteTo: unrecognized sender.tag");
            break;
    }
    
    // change selected menu sprite
    self.selectedMenuSprite = sender;
    
    // highlight selected menu sprite
    self.highlightedSprite.position = pos;
    
    // need to change text that's being shown
    NSDictionary *descriptionDict = [talentTextDictionary valueForKey: @"Talent Description"];
    self.talentTitleLabel.string = titleString;
    self.talentDescriptionLabel.string = [descriptionDict valueForKey: talentKeyString];
    self.talentPointsLabel.string = talentPointsString;
    
}

- (void) insertTalentTree {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    GameManager *m = [GameManager sharedGameManager];
    
    int characterID = [GameManager sharedGameManager].selectedHero.characterID;
    NSMutableDictionary *tDictionary = [GameManager sharedGameManager].selectedHero.talentTree;
    NSDictionary *heroD;
    NSArray *arrayOfKeys;
    NSArray *arrayOfPoints;
    
    CCSprite *a;
    CCSprite *b;
    CCSprite *c;
    CCSprite *d;
    CCSprite *e;
    int aPoints;
    int bPoints;
    int cPoints;
    int dPoints;
    int ePoints;
    NSString *aTitle;
    NSString *bTitle;
    NSString *cTitle;
    NSString *dTitle;
    NSString *eTitle;
    
    // add selected sprites later
    if (characterID == 1) {
                
        a = [CCSprite spriteWithSpriteFrameName: @"c1_t1a_1.png"];
        b = [CCSprite spriteWithSpriteFrameName: @"c1_t1b_1.png"];
        c = [CCSprite spriteWithSpriteFrameName: @"c1_t2a_1.png"];
        d = [CCSprite spriteWithSpriteFrameName: @"c1_t2b_1.png"];
        e = [CCSprite spriteWithSpriteFrameName: @"c1_t3_1.png"];
        
        // for the labels
        
        m.key1 = [NSString stringWithFormat: @"Optimization"];
        m.key2 = [NSString stringWithFormat: @"TowerCooling"];
        m.key3 = [NSString stringWithFormat: @"ImprovedMines"];
        m.key4 = [NSString stringWithFormat: @"BulletPropulsion"];
        m.key5 = [NSString stringWithFormat: @"ArmorPiercing"];
        
        aTitle = [NSString stringWithFormat: @"Optimization"];
        bTitle = [NSString stringWithFormat: @"Tower Cooling"];
        cTitle = [NSString stringWithFormat: @"Mines+"];
        dTitle = [NSString stringWithFormat: @"Propulsion"];
        eTitle = [NSString stringWithFormat: @"Armor Piercing"];
        
        heroD = [talentTextDictionary objectForKey: @"Hero1"];
        arrayOfKeys = [NSArray arrayWithObjects: m.key1, m.key2, m.key3, m.key4, m.key5, nil];
        
    } else if (characterID == 2) {
        a = [CCSprite spriteWithSpriteFrameName: @"c2_t1a_1.png"];
        b = [CCSprite spriteWithSpriteFrameName: @"c2_t1b_1.png"];
        c = [CCSprite spriteWithSpriteFrameName: @"c2_t2a_1.png"];
        d = [CCSprite spriteWithSpriteFrameName: @"c2_t2b_1.png"];
        e = [CCSprite spriteWithSpriteFrameName: @"c2_t3_1.png"];
        
        // for the labels
        
        m.key1 = [NSString stringWithFormat: @"ImprovedPoison"];
        m.key2 = [NSString stringWithFormat: @"ImprovedBlizzard"];
        m.key3 = [NSString stringWithFormat: @"ImprovedSmite"];
        m.key4 = [NSString stringWithFormat: @"DeepFreeze"];
        m.key5 = [NSString stringWithFormat: @"FocusedFire"];
        
        aTitle = [NSString stringWithFormat: @"Poison+"];
        bTitle = [NSString stringWithFormat: @"Blizzard+"];
        cTitle = [NSString stringWithFormat: @"Smite+"];
        dTitle = [NSString stringWithFormat: @"Deep Freeze"];
        eTitle = [NSString stringWithFormat: @"Focused Fire"];
        
        heroD = [talentTextDictionary objectForKey: @"Hero2"];
        arrayOfKeys = [NSArray arrayWithObjects: m.key1, m.key2, m.key3, m.key4, m.key5, nil];


    } else if (characterID == 3) {
        a = [CCSprite spriteWithSpriteFrameName: @"c3_t1a_1.png"];
        b = [CCSprite spriteWithSpriteFrameName: @"c3_t1b_1.png"];
        c = [CCSprite spriteWithSpriteFrameName: @"c3_t2a_1.png"];
        d = [CCSprite spriteWithSpriteFrameName: @"c3_t2b_1.png"];
        e = [CCSprite spriteWithSpriteFrameName: @"c3_t3_1.png"];
        
        // for the labels
        
        m.key1 = [NSString stringWithFormat: @"Sharpshooter"];
        m.key2 = [NSString stringWithFormat: @"ImprovedRage"];
        m.key3 = [NSString stringWithFormat: @"ImprovedMeditation"];
        m.key4 = [NSString stringWithFormat: @"ImprovedSlow"];
        m.key5 = [NSString stringWithFormat: @"Nirvana"];
        
        aTitle = [NSString stringWithFormat: @"Sharpshooter"];
        bTitle = [NSString stringWithFormat: @"Rage+"];
        cTitle = [NSString stringWithFormat: @"Meditate+"];
        dTitle = [NSString stringWithFormat: @"Slow+"];
        eTitle = [NSString stringWithFormat: @"Nirvana"];
        
        heroD = [talentTextDictionary objectForKey: @"Hero3"];
        arrayOfKeys = [NSArray arrayWithObjects: m.key1, m.key2, m.key3, m.key4, m.key5, nil];
    }
    
    aPoints = [[tDictionary objectForKey: m.key1] intValue];
    bPoints = [[tDictionary objectForKey: m.key2] intValue];
    cPoints = [[tDictionary objectForKey: m.key3] intValue];
    dPoints = [[tDictionary objectForKey: m.key4] intValue];
    ePoints = [[tDictionary objectForKey: m.key5] intValue];
    
    arrayOfPoints = [NSArray arrayWithObjects: 
                     [NSNumber numberWithInt: aPoints],
                     [NSNumber numberWithInt: bPoints],
                     [NSNumber numberWithInt: cPoints],
                     [NSNumber numberWithInt: dPoints],
                     [NSNumber numberWithInt: ePoints],
                     nil];
    
    float paddingX = (screenSize.width/2 - 2*a.contentSize.width)/3;
    float paddingY = (screenSize.height - 3*a.contentSize.height)/4;
    
    // create 3 menus; 1 for each tier
    
    self.tier1a = [CCMenuItemSprite itemWithNormalSprite: a 
                                          selectedSprite: nil
                                                  target: self
                                                selector: @selector(changeSelectedMenuSpriteTo:)];
    tier1a.tag = 1;
    
    self.tier1b = [CCMenuItemSprite itemWithNormalSprite: b 
                                          selectedSprite: nil
                                                  target: self
                                                    selector: @selector(changeSelectedMenuSpriteTo:)];
    tier1b.tag = 2;
    
    self.tier2a = [CCMenuItemSprite itemWithNormalSprite: c 
                                          selectedSprite: nil
                                                  target: self
                                                    selector: @selector(changeSelectedMenuSpriteTo:)];
    tier2a.tag = 3;
    
    self.tier2b = [CCMenuItemSprite itemWithNormalSprite: d 
                                          selectedSprite: nil
                                                  target: self
                                                selector: @selector(changeSelectedMenuSpriteTo:)];
    tier2b.tag = 4;
    
    self.tier3 = [CCMenuItemSprite itemWithNormalSprite: e 
                                         selectedSprite: nil
                                                 target: self
                                               selector: @selector(changeSelectedMenuSpriteTo:)];
    tier3.tag = 5;
    
    float aOffset1 = 14.0f;
    float aOffset2 = 8.0f;
    
    self.tierMenu1 = [CCMenu menuWithItems: tier1a, tier1b, nil];
    [tierMenu1 alignItemsHorizontallyWithPadding: paddingX - 2.0f*aOffset2];
    tierMenu1.position = ccp(3.0f*screenSize.width/4, 2.5*paddingY + 0.5*tier3.contentSize.height + aOffset1);
    tierMenu1.zOrder = 1;
    [self addChild: tierMenu1];
    
    self.tierMenu2 = [CCMenu menuWithItems: tier2a, tier2b, nil];
    [tierMenu2 alignItemsHorizontallyWithPadding: paddingX - 2.0f*aOffset2];
    tierMenu2.position = ccp(3.0f*screenSize.width/4, 3.0*paddingY + 1.5*tier3.contentSize.height);
    tierMenu2.zOrder = 1;
    [self addChild: tierMenu2];

    self.tierMenu3 = [CCMenu menuWithItems: tier3, nil];
    [tierMenu3 alignItemsHorizontallyWithPadding: paddingX - 2.0f*aOffset2];
    tierMenu3.position = ccp(3.0f*screenSize.width/4, 3.5*paddingY + 2.5*tier3.contentSize.height - aOffset1);
    tierMenu3.zOrder = 1;
    [self addChild: tierMenu3];
    
    float tX = tier3.contentSize.width;
    float tY = tier3.contentSize.height;
        
    // check if any of the talents should be disabled due to level restriction
    
    self.t3_locked = [CCSprite spriteWithSpriteFrameName: @"talent_locked_1.png"];
    self.t2a_locked = [CCSprite spriteWithSpriteFrameName: @"talent_locked_1.png"];
    self.t2b_locked = [CCSprite spriteWithSpriteFrameName: @"talent_locked_1.png"];
    t3_locked.zOrder = 99999;
    t2a_locked.zOrder = 99999;
    t2b_locked.zOrder = 99999;
    
    t3_locked.visible = NO;
    t2a_locked.visible = NO;
    t2b_locked.visible = NO;
    
    [self addChild: t3_locked];
    [self addChild: t2a_locked];
    [self addChild: t2b_locked];
    
    t3_locked.position = ccp(3.0f*screenSize.width/4, 3.5f*paddingY + 2.0f*tY + tY/2.0f - aOffset1);
    t2a_locked.position = ccp(3.0f*screenSize.width/4 - paddingX/2 - tX/2.0f + aOffset2, 3.0f*paddingY + 1.0f*tY + tY/2.0f);
    t2b_locked.position = ccp(3.0f*screenSize.width/4 + paddingX/2 + tX/2.0f - aOffset2, 3.0f*paddingY + 1.0f*tY + tY/2.0f);
    
    // disable tier 3, if needed -- change the if statement
    if (m.selectedHero.characterLevel < 10 || (m.selectedHero.characterLevel - m.selectedHero.talentPointsLeft) < 10) {
        tier3.isEnabled = NO;
        t3_locked.visible =YES;        
    }
    
    // disable tier 2, if needed -- change the if statement
    if (m.selectedHero.characterLevel < 5 || (m.selectedHero.characterLevel - m.selectedHero.talentPointsLeft) < 5) {
        tier2a.isEnabled = NO;
        tier2b.isEnabled = NO;
        t2a_locked.visible = YES;
        t2b_locked.visible = YES;
    }
    
    // insert the labels
    NSString *aString = [NSString stringWithFormat: @"%d/5", aPoints];
    NSString *bString = [NSString stringWithFormat: @"%d/5", bPoints];
    NSString *cString = [NSString stringWithFormat: @"%d/5", cPoints];
    NSString *dString = [NSString stringWithFormat: @"%d/5", dPoints];
    NSString *eString = [NSString stringWithFormat: @"%d/5", ePoints];
    
    self.aLabel = [CCLabelBMFont labelWithString: aString fntFile: @"MushroomTextSmall.fnt"];
    self.aLabel.zOrder = 2;
    self.aLabel.color = ccYELLOW;
    self.aLabel.scale = 0.8f;
    
    self.bLabel = [CCLabelBMFont labelWithString: bString fntFile: @"MushroomTextSmall.fnt"];
    self.bLabel.zOrder = 2;
    self.bLabel.color = ccYELLOW;
    self.bLabel.scale = 0.8f;

    self.cLabel = [CCLabelBMFont labelWithString: cString fntFile: @"MushroomTextSmall.fnt"];
    self.cLabel.zOrder = 2;
    self.cLabel.color = ccYELLOW;
    self.cLabel.scale = 0.8f;

    self.dLabel = [CCLabelBMFont labelWithString: dString fntFile: @"MushroomTextSmall.fnt"];
    self.dLabel.zOrder = 2;
    self.dLabel.color = ccYELLOW;
    self.dLabel.scale = 0.8f;

    self.eLabel = [CCLabelBMFont labelWithString: eString fntFile: @"MushroomTextSmall.fnt"];
    self.eLabel.zOrder = 2;
    self.eLabel.color = ccYELLOW;
    self.eLabel.scale = 0.8f;
    
    // POSITIONING the labels
    self.aLabel.position = ccp(3.0f*screenSize.width/4.0f - paddingX/2.0f - 0.2f*tX - 4 + aOffset2, 2.5f*paddingY + 0.18f*tY + 4.0f + aOffset1);
    self.bLabel.position = ccp(3.0f*screenSize.width/4.0f + paddingX/2.0f + 0.8f*tX - 4 - aOffset2, 2.5f*paddingY + 0.18f*tY + 4.0f + aOffset1);
    self.cLabel.position = ccp(3.0f*screenSize.width/4.0f - paddingX/2.0f - 0.2f*tX - 4 + aOffset2, 3.0f*paddingY + 0.18f*tY + tY + 4.0f);
    self.dLabel.position = ccp(3.0f*screenSize.width/4.0f + paddingX/2.0f + 0.8f*tX - 4 - aOffset2, 3.0f*paddingY + 0.18f*tY + tY + 4.0f);
    self.eLabel.position = ccp(3.0f*screenSize.width/4.0f + 0.3f*tX - 4.0f, 3.5f*paddingY + 0.18f*tY + 2.0f*tY + 4.0f - aOffset1);
    
    [self addChild: aLabel];
    [self addChild: bLabel];
    [self addChild: cLabel];
    [self addChild: dLabel];
    [self addChild: eLabel];
    
    // insert the titles
    self.aTitleLabel = [CCLabelBMFont labelWithString: aTitle fntFile: @"MushroomTextSmall.fnt"];
    self.bTitleLabel = [CCLabelBMFont labelWithString: bTitle fntFile: @"MushroomTextSmall.fnt"];
    self.cTitleLabel = [CCLabelBMFont labelWithString: cTitle fntFile: @"MushroomTextSmall.fnt"];
    self.dTitleLabel = [CCLabelBMFont labelWithString: dTitle fntFile: @"MushroomTextSmall.fnt"];
    self.eTitleLabel = [CCLabelBMFont labelWithString: eTitle fntFile: @"MushroomTextSmall.fnt"];
    
    self.aTitleLabel.zOrder = 2;
    self.bTitleLabel.zOrder = 2;
    self.cTitleLabel.zOrder = 2;
    self.dTitleLabel.zOrder = 2;
    self.eTitleLabel.zOrder = 2;
    
    self.aTitleLabel.scale = 0.6f;
    self.bTitleLabel.scale = 0.6f;
    self.cTitleLabel.scale = 0.6f;
    self.dTitleLabel.scale = 0.6f;
    self.eTitleLabel.scale = 0.6f;
    
    self.aTitleLabel.color = ccYELLOW;
    self.bTitleLabel.color = ccYELLOW;
    self.cTitleLabel.color = ccYELLOW;
    self.dTitleLabel.color = ccYELLOW;
    self.eTitleLabel.color = ccYELLOW;

    
    // POSITIONING the titles
    self.aTitleLabel.position = ccp(3.0f*screenSize.width/4.0f - paddingX/2.0f - tX/2.0f + aOffset2, 2.5*paddingY + 0.81f*tY + aOffset1);
    self.bTitleLabel.position = ccp(3.0f*screenSize.width/4.0f + paddingX/2.0f + tX/2.0f - aOffset2, 2.5*paddingY + 0.81f*tY + aOffset1);
    self.cTitleLabel.position = ccp(3.0f*screenSize.width/4.0f - paddingX/2.0f - tX/2.0f + aOffset2, 3.0*paddingY + 0.81f*tY + tY);
    self.dTitleLabel.position = ccp(3.0f*screenSize.width/4.0f + paddingX/2.0f + tX/2.0f - aOffset2, 3.0*paddingY + 0.81f*tY + tY);
    self.eTitleLabel.position = ccp(3.0f*screenSize.width/4.0f, 3.5f*paddingY + 0.81f*tY + 2.0f*tY - aOffset1);
    
    [self addChild: aTitleLabel];
    [self addChild: bTitleLabel];
    [self addChild: cTitleLabel];
    [self addChild: dTitleLabel];
    [self addChild: eTitleLabel];
    
    // insert other labels
    NSString *pointsLeftString = [NSString stringWithFormat: @"%d", m.selectedHero.talentPointsLeft];
    NSString *currentLevelString = [NSString stringWithFormat: @"%d", m.selectedHero.characterLevel];
    NSString *currentXPString = [NSString stringWithFormat: @"%d/%d", 
                                 m.selectedHero.experiencePoints, m.selectedHero.currentExperienceLimit];
    NSString *totalXPString = [NSString stringWithFormat: @"%d", m.selectedHero.totalExperiencePoints];
    
    
    // points left
    CCLabelBMFont *pointsLeftHeader = [CCLabelBMFont labelWithString: @"Points: " fntFile: @"MushroomTextSmall.fnt"];
    pointsLeftHeader.zOrder = 2;
    pointsLeftHeader.anchorPoint = ccp(1.0, 0.5);
    
    self.pointsLeftLabel = [CCLabelBMFont labelWithString: pointsLeftString fntFile: @"MushroomTextSmall.fnt"];
    self.pointsLeftLabel.zOrder = 2;
    // self.pointsLeftLabel.anchorPoint = ccp(0.0, 0.5);
    self.pointsLeftLabel.color = ccYELLOW;
    
    // current level
    CCLabelBMFont *currentLevelHeader = [CCLabelBMFont labelWithString: @"Level: " fntFile: @"MushroomTextSmall.fnt"];
    currentLevelHeader.zOrder = 2;
    currentLevelHeader.anchorPoint = ccp(1.0, 0.5);
    
    self.currentLevelLabel = [CCLabelBMFont labelWithString: currentLevelString fntFile: @"MushroomTextSmall.fnt"];
    self.currentLevelLabel.zOrder = 2;
    self.currentLevelLabel.color = ccYELLOW;
    self.currentLevelLabel.anchorPoint = ccp(0.0, 0.5);
    
    // current XP
    CCLabelBMFont *currentXPHeader = [CCLabelBMFont labelWithString: @"XP: " fntFile: @"MushroomTextSmall.fnt"];
    currentXPHeader.anchorPoint = ccp(1.0, 0.5);
    currentXPHeader.zOrder = 2;

    self.currentXPLabel = [CCLabelBMFont labelWithString: currentXPString fntFile: @"MushroomTextSmall.fnt"];
    self.currentXPLabel.zOrder = 2;
    self.currentXPLabel.color = ccYELLOW;
    self.currentXPLabel.anchorPoint = ccp(0.0, 0.5);
    
    // total XP
    CCLabelBMFont *totalXPHeader = [CCLabelBMFont labelWithString: @"Tot. XP: " fntFile: @"MushroomTextSmall.fnt"];
    totalXPHeader.anchorPoint = ccp(1.0, 0.5);
    totalXPHeader.zOrder = 2;

    self.totalXPLabel = [CCLabelBMFont labelWithString: totalXPString fntFile: @"MushroomTextSmall.fnt"];
    self.totalXPLabel.zOrder = 2;
    self.totalXPLabel.color = ccYELLOW;
    self.totalXPLabel.anchorPoint = ccp(0.0, 0.5);
    
    
    // POSITIONING the headers
    
    // float otherOffset = 25.0f;
    // float otherOffset2 = 5.0f;
    
    self.currentLevelLabel.position = ccp(171.0f, screenSize.height - 47.0f);
    self.currentLevelLabel.scale = 1.0f;
    currentLevelHeader.position = self.currentLevelLabel.position;
    currentLevelHeader.scale = 1.0f;
    
    self.currentXPLabel.position = ccp(150.0f, screenSize.height - 70.0f);
    self.currentXPLabel.scale = 1.0f;
    currentXPHeader.position = self.currentXPLabel.position;
    currentXPHeader.scale = 1.0f;
    
    self.totalXPLabel.position = ccp(190.0f, screenSize.height - 93.0f);
    self.totalXPLabel.scale = 1.0f;
    totalXPHeader.position = self.totalXPLabel.position;
    totalXPHeader.scale = 1.0f;
    
    self.pointsLeftLabel.position = ccp(333.0f, 64.0f);
    self.pointsLeftLabel.scale = 0.8f;
    pointsLeftHeader.position = ccp(331.0f, 64.0f);
    pointsLeftHeader.scale = 0.8f;
    
    [self addChild: pointsLeftHeader];
    [self addChild: pointsLeftLabel];
    
    [self addChild: currentLevelHeader];
    [self addChild: currentLevelLabel];
    
    [self addChild: currentXPHeader];
    [self addChild: currentXPLabel];
    
    [self addChild: totalXPHeader];
    [self addChild: totalXPLabel];
        
    // establish the 5 positions to refer to later
    // add the talent text labels
    
    // to be changed later, if initialization is different
    //self.t1a_position = ccp(screenSize.width/4.0f - paddingX/2.0f - tX/2.0f, 2.5f*paddingY + tY/2.0f);
    //self.t1b_position = ccp(screenSize.width/4.0f + paddingX/2.0f + tX/2.0f, 2.5f*paddingY + tY/2.0f);
    //self.t2a_position = ccp(screenSize.width/4.0f - paddingX/2.0f - tX/2.0f, 3.0f*paddingY + tY/2.0f + tY);
    //self.t2b_position = ccp(screenSize.width/4.0f + paddingX/2.0f + tX/2.0f, 3.0f*paddingY + tY/2.0f + tY);
    //self.t3_position = ccp(screenSize.width/4.0f, 3.5f*paddingY + tY/2.0f + 2.0f*tY);
    
    self.t1a_label = [CCLabelBMFont labelWithString: @" " fntFile: @"MushroomTextSmall.fnt" width: 140 alignment: CCTextAlignmentCenter];
    self.t1b_label = [CCLabelBMFont labelWithString: @" " fntFile: @"MushroomTextSmall.fnt" width: 140 alignment: CCTextAlignmentCenter];
    self.t2a_label = [CCLabelBMFont labelWithString: @" " fntFile: @"MushroomTextSmall.fnt" width: 140 alignment: CCTextAlignmentCenter];
    self.t2b_label = [CCLabelBMFont labelWithString: @" " fntFile: @"MushroomTextSmall.fnt" width: 140 alignment: CCTextAlignmentCenter];
    self.t3_label = [CCLabelBMFont labelWithString: @" " fntFile: @"MushroomTextSmall.fnt" width: 140 alignment: CCTextAlignmentCenter];
    
    
    // POSITIONING the tier labels
    self.t1a_label.position = ccp(3.0f*screenSize.width/4.0f - paddingX/2.0f - tX/2.0f + aOffset2, 2.5f*paddingY + tY/2.0f + aOffset1);
    self.t1b_label.position = ccp(3.0f*screenSize.width/4.0f + paddingX/2.0f + tX/2.0f - aOffset2, 2.5f*paddingY + tY/2.0f + aOffset1);
    self.t2a_label.position = ccp(3.0f*screenSize.width/4.0f - paddingX/2.0f - tX/2.0f + aOffset2, 3.0f*paddingY + tY/2.0f + tY);
    self.t2b_label.position = ccp(3.0f*screenSize.width/4.0f + paddingX/2.0f + tX/2.0f - aOffset2, 3.0f*paddingY + tY/2.0f + tY);
    self.t3_label.position = ccp(3.0f*screenSize.width/4.0f, 3.5f*paddingY + tY/2.0f + 2.0f*tY - aOffset1);
    
    self.t1a_label.zOrder = 5;
    self.t1b_label.zOrder = 5;
    self.t2a_label.zOrder = 5;
    self.t2b_label.zOrder = 5;
    self.t3_label.zOrder = 5;
    
    self.t1a_label.scale = 0.55f;
    self.t1b_label.scale = 0.55f;
    self.t2a_label.scale = 0.55f;
    self.t2b_label.scale = 0.55f;
    self.t3_label.scale = 0.55f;
    
    NSArray *arrayOfTextLabels = [NSArray arrayWithObjects: t1a_label, t1b_label, t2a_label, t2b_label, t3_label, nil];
    
    // check if hero has any points allocated already
    for (int i = 0; i < 5; i++) {
        
        NSString *s = (NSString *) [arrayOfKeys objectAtIndex: i];
        int x = [[arrayOfPoints objectAtIndex: i] intValue];
        
        if (x > 0) {
            NSString *keyString = [NSString stringWithFormat: @"%@%d", s, x];
            NSString *stringToShow = [heroD objectForKey: keyString];
            
            CCLabelBMFont *c = (CCLabelBMFont *) [arrayOfTextLabels objectAtIndex: i];
            c.string = stringToShow;
        }        
    }
    
    [self addChild: t1a_label];
    [self addChild: t1b_label];
    [self addChild: t2a_label];
    [self addChild: t2b_label];
    [self addChild: t3_label];
    
}

- (void) initTalentTextDictionary {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource: @"TalentText" ofType: @"plist"];
    
    self.talentTextDictionary = [NSMutableDictionary dictionaryWithContentsOfFile: plistPath];
    
}

- (void) updateTalentDescriptionWithKeyString: (NSString *) talentKey 
                                 andSenderTag: (int) tag {
        
    GameManager *m = [GameManager sharedGameManager];
    NSMutableDictionary *tD = m.selectedHero.talentTree;
    
    // obtain upgrade text to apply to the description
    
    // CGPoint descriptionPos;
    CCLabelBMFont *label;
        
    switch (tag) {
            
        case 1:
            label = t1a_label;
            break;
            
        case 2:
            label = t1b_label;
            break;
            
        case 3:
            label = t2a_label;
            break;
            
        case 4: 
            label = t2b_label;
            break;
            
        case 5:
            label = t3_label;
            break;
            
        default:
            CCLOG(@"Talent Layer: unrecognized tag");
            break;
    }
    
    // obtain the proper dictionary to use
    int characterID = m.selectedHero.characterID;
    NSString *heroString = [NSString stringWithFormat: @"Hero%d", characterID];
    NSDictionary *d = [talentTextDictionary objectForKey: heroString];
    
    // obtain the proper string to use
    int upgradeNumber = [[tD objectForKey: talentKey] intValue];
    NSString *upgradeString = [NSString stringWithFormat: @"%@%d", talentKey, upgradeNumber];
    NSString *stringToShow = [d objectForKey: upgradeString];
    
    CCLOG(@"upgrade string: %@", upgradeString);
    CCLOG(@"string to show: %@", [d objectForKey: upgradeString]);
    
    label.string = stringToShow;
    
}

- (void) upgradeTalent: (CCMenuItemSprite *) sender {
    
    if (self.selectedMenuSprite == nil) {
        return;
    }
    
    GameManager *m = [GameManager sharedGameManager];
    
    NSString *keyString;
    CCLabelBMFont *label;
    CCMenuItemSprite *button;
    
    switch (self.selectedMenuSprite.tag) {
            
        case 1:
            CCLOG(@"key1: %@", m.key1);
            keyString = m.key1;
            label = self.aLabel;
            //title = self.aTitleLabel;
            button = self.tier1a;
            break;
            
        case 2:
            CCLOG(@"key2: %@", m.key2);
            keyString = m.key2;
            label = self.bLabel;
            //title = self.bTitleLabel;
            button = self.tier1b;
            break;
            
        case 3:
            CCLOG(@"key3: %@", m.key3);
            keyString = m.key3;
            label = self.cLabel;
            //title = self.cTitleLabel;
            button = self.tier2a;
            break;
            
        case 4:
            CCLOG(@"key4: %@", m.key4);
            keyString = m.key4;
            label = self.dLabel;
            //title = self.dTitleLabel;
            button = self.tier2b;
            break;
            
        case 5:
            CCLOG(@"key5: %@", m.key5);
            keyString = m.key5;
            label = self.eLabel;
            //title = self.eTitleLabel;
            button = self.tier3;
            break;
            
        default:
            CCLOG(@"Talent Layer: unrecognized keyString");
            break;
    }
    
    // updates the hero's talents, updates the label to show new points allocated
    NSMutableDictionary *tD = m.selectedHero.talentTree;
    
    int oldPoints = [[tD objectForKey: keyString] intValue];
    
    // check if 5 talent points already allocated (i.e., talent is maxed)
    if (oldPoints == 5) {
        return;
        
        // player can potentially upgrade the talent
    } else {
        
        // check if player has any talent points to spend
        if (m.selectedHero.talentPointsLeft == 0) {
            return;
        } else {
                        
            // subtract spent talent point
            m.selectedHero.talentPointsLeft -= 1;
            NSString *pointsLeftString = [NSString stringWithFormat: @"%d", m.selectedHero.talentPointsLeft];
            self.pointsLeftLabel.string = pointsLeftString;
            
            // animation the spent talent point
            id aScaleUpPoints = [CCScaleTo actionWithDuration: 0.1f scale: 1.15f];
            id aScaleDownPoints = [CCScaleTo actionWithDuration: 0.25 scale: 1.0f];
            id aSequence = [CCSequence actions: aScaleUpPoints, aScaleDownPoints, nil];
            [self.pointsLeftLabel runAction: aSequence];
            
            int newPoints = oldPoints + 1;
            NSNumber *n = [NSNumber numberWithInt: newPoints];
            
            // sound effects for the upgraded talent
            if (newPoints == 5) {
                PLAYSOUNDEFFECT(upgrade_max_sound);
            } else {
                PLAYSOUNDEFFECT(upgrade_sound);
            }
                        
            // update the hero's talent dictionary with the new points allocated
            [tD setObject: n forKey: keyString];
            
            NSString *s = [NSString stringWithFormat: @"%d/5", newPoints];
            label.string = s;
                        
            // update the upgrade "text" description using a method that takes the argument of m.key -- keyString
            [self updateTalentDescriptionWithKeyString: keyString 
                                          andSenderTag: selectedMenuSprite.tag];
                        
            // check if restricted tier 2 talents should become available now
            if (m.selectedHero.characterLevel >= 5 && (m.selectedHero.characterLevel - m.selectedHero.talentPointsLeft) >= 5) {
                                
                if (self.tier2a.isEnabled == NO) {
                    self.tier2a.isEnabled = YES;
                    self.t2a_locked.visible = NO;
                }
                
                if (self.tier2b.isEnabled == NO) {
                    self.tier2b.isEnabled = YES;
                    self.t2b_locked.visible = NO;
                }
            }
                        
            // check if restricted tier 3 talents should become available now
            if (m.selectedHero.characterLevel >= 10 && (m.selectedHero.characterLevel - m.selectedHero.talentPointsLeft) >= 10) {
                
                if (self.tier3.isEnabled == NO) {
                    self.tier3.isEnabled = YES;
                    self.t3_locked.visible = NO;
                }
            }
            
            // check if the upgrade affects any of the currently placed towers
            // e.g., Optimization, BulletPropulsion, Nirvana, Sharpshooter
            
            if ([keyString compare: @"Optimization"] == NSOrderedSame) {
                for (id <TowerControlDelegate> tDel in m.controlsLayer.gamePlayLayer.towerDelegateCollection) {
                    
                    if (tDel.buttonType == kTowerButton) {
                        Tower *t = (Tower *) tDel;
                        t.bulletAccuracyEffect += 0.02f;
                    }
                }
            }
            
            if ([keyString compare: @"BulletPropulsion"] == NSOrderedSame) {
                for (id <TowerControlDelegate> tDel in m.controlsLayer.gamePlayLayer.towerDelegateCollection) {
                    
                    if (tDel.buttonType == kTowerButton) {
                        Tower *t = (Tower *) tDel;
                        t.towerRange += 1.0f;
                    }
                }
            }
            
            if ([keyString compare: @"Nirvana"] == NSOrderedSame) {
                for (id <TowerControlDelegate> tDel in m.controlsLayer.gamePlayLayer.towerDelegateCollection) {
                    
                    if (tDel.buttonType == kTowerButton) {
                        Tower *t = (Tower *) tDel;
                        float rateUpgrade;
                        
                        if (t.towerType == kTowerStandard) {
                            rateUpgrade = kNirvanaEffect*kTowerStandardFiringRate;
                        } else if (t.towerType == kTowerIce) {
                            rateUpgrade = kNirvanaEffect*kTowerIceFiringRate;
                        } else if (t.towerType == kTowerBomb) {
                            rateUpgrade = kNirvanaEffect*kTowerBombFiringRate;
                        }
                        
                        t.firingRate += rateUpgrade;                        
                    }
                }
            }
            
            if ([keyString compare: @"Sharpshooter"] == NSOrderedSame) {
                                
                for (id <TowerControlDelegate> tDel in m.controlsLayer.gamePlayLayer.towerDelegateCollection) {
                    
                    if (tDel.buttonType == kTowerButton) {
                        Tower *t = (Tower *) tDel;
                        t.bulletAccuracyEffect += 0.01f;
                        t.critEffect += 0.02f;
                    }
                }
            }
                        
            [label stopAllActions];
            id actionScaleUp = [CCScaleTo actionWithDuration: 0.1f scale: 1.0f];
            id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 0.8f];
            id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
            [label runAction: actionSequence];
            
            [button stopAllActions];
            id actionScaleUp3 = [CCScaleTo actionWithDuration: 0.1f scale: 1.15f];
            id actionScaleDown3 = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
            id actionSequence3 = [CCSequence actions: actionScaleUp3, actionScaleDown3, nil];
            [button runAction: actionSequence3];
            
            [self.highlightedSprite stopAllActions];
            id actionScaleUpHighlight = [CCScaleTo actionWithDuration: 0.1f scale: 1.15f];
            id actionScaleDownHighlight = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
            id actionSequenceHighlight = [CCSequence actions: actionScaleUpHighlight, actionScaleDownHighlight, nil];
            [self.highlightedSprite runAction: actionSequenceHighlight];
            
            // update talentPointsLabel
            [self.talentPointsLabel stopAllActions];
            self.talentPointsLabel.string = label.string;
            id actionScaleUpLabel = [CCScaleTo actionWithDuration: 0.1f scale: 1.15f];
            id actionScaleDownLabel = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
            id actionSequenceLabel = [CCSequence actions: actionScaleUpLabel, actionScaleDownLabel, nil];
            [self.talentPointsLabel runAction: actionSequenceLabel];
            
        }
    }
}

- (void) insertTitleWithString: (NSString *) titleString {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelBMFont *titleLabel = [CCLabelBMFont labelWithString: titleString fntFile: @"MushroomText.fnt"];
    titleLabel.scale = 0.5f;
    
    float offSetY = 25.0f;
    titleLabel.position = ccp(screenSize.width*3/4, screenSize.height - offSetY);
    
    [self addChild: titleLabel
                 z: kTitleZOrder
               tag: 1];
}

- (void) insertResetButtonWithSelector: (SEL) resetSelector {
    
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
                                                                 selector: resetSelector];
    float padding = 7.0f;
    CCMenu *nextMenu = [CCMenu menuWithItems: nextButton, nil];
    nextMenu.position = ccp(screenSize.width - nextButton.contentSize.width/2 - padding, 
                            nextButton.contentSize.height/2 + padding);
    
    [self addChild: nextMenu
                 z: kButtonZOrder
               tag: 2];
    
}

// resetting points is for testing purposes only
// resetting ponts will not be part of the final game
- (void) resetPoints {
    
    PLAYSOUNDEFFECT(tower_remove_button_sound);
        
    GameManager *m = [GameManager sharedGameManager];
    NSMutableDictionary *tDictionary = m.selectedHero.talentTree;
    
    [tDictionary setObject: [NSNumber numberWithInt: 0] forKey: m.key1];
    [tDictionary setObject: [NSNumber numberWithInt: 0] forKey: m.key2];
    [tDictionary setObject: [NSNumber numberWithInt: 0] forKey: m.key3];
    [tDictionary setObject: [NSNumber numberWithInt: 0] forKey: m.key4];
    [tDictionary setObject: [NSNumber numberWithInt: 0] forKey: m.key5];

    int aPoints = [[tDictionary objectForKey: m.key1] intValue];
    int bPoints = [[tDictionary objectForKey: m.key2] intValue];
    int cPoints = [[tDictionary objectForKey: m.key3] intValue];
    int dPoints = [[tDictionary objectForKey: m.key4] intValue];
    int ePoints = [[tDictionary objectForKey: m.key5] intValue];
    
    // these should be at 0 points now
    NSString *aString = [NSString stringWithFormat: @"%d/5", aPoints];
    NSString *bString = [NSString stringWithFormat: @"%d/5", bPoints];
    NSString *cString = [NSString stringWithFormat: @"%d/5", cPoints];
    NSString *dString = [NSString stringWithFormat: @"%d/5", dPoints];
    NSString *eString = [NSString stringWithFormat: @"%d/5", ePoints];
    
    self.aLabel.string = aString;
    self.bLabel.string = bString;
    self.cLabel.string = cString;
    self.dLabel.string = dString;
    self.eLabel.string = eString;

    // set points available to character level
    m.selectedHero.talentPointsLeft = m.selectedHero.characterLevel;
    NSString *pointsLeftString = [NSString stringWithFormat: @"%d", m.selectedHero.talentPointsLeft];    
    self.pointsLeftLabel.string = pointsLeftString;
    
    // set talentPointsLabel to 0
    // check if selectedMenuSprite is nil
    if (self.selectedMenuSprite != nil) {
        self.talentPointsLabel.string = @"0/5";
    }
    
    // set description labels to nothing
    self.t1a_label.string = @" ";
    self.t1b_label.string = @" ";
    self.t2a_label.string = @" ";
    self.t2b_label.string = @" ";
    self.t3_label.string = @" ";
    
    // update stats for currently placed towers
    
    for (id <TowerControlDelegate> tDel in m.controlsLayer.gamePlayLayer.towerDelegateCollection) {
        
        if (tDel.buttonType == kTowerButton) {
            
            Tower *t = (Tower *) tDel;
            
            float firingRate;
            float towerRange;
            float bulletAccuracyEffect;
            float critEffect;
            
            if (t.towerType == kTowerStandard) {
                firingRate = kTowerStandardFiringRate;
                towerRange = kTowerStandardTowerRange;
                bulletAccuracyEffect = kTowerStandardBulletAccuracyEffect;
                critEffect = kTowerStandardCritEffect;
            } else if (t.towerType == kTowerIce) {
                firingRate = kTowerIceFiringRate;
                towerRange = kTowerIceTowerRange;
                bulletAccuracyEffect = kTowerIceBulletAccuracyEffect;
                critEffect = kTowerIceCritEffect;
            } else if (t.towerType == kTowerBomb) {
                firingRate = kTowerBombFiringRate;
                towerRange = kTowerBombTowerRange;
                bulletAccuracyEffect = kTowerBombBulletAccuracyEffect;
                critEffect = kTowerBombCritEffect;
            }
            
            t.firingRate = firingRate;
            t.towerRange = towerRange + m.range_static_power;
            t.bulletAccuracyEffect = bulletAccuracyEffect + m.accuracy_static_power + 0.05f*((float) t.bulletAccuracyEffectUpgradeLevel);
            t.critEffect = critEffect + 0.05f*((float) t.critEffectUpgradeLevel);
            
        }
        
    }
    
    // lock restricted talent buttons again    
    tier3.isEnabled = NO;
    t3_locked.visible = YES;
    
    tier2a.isEnabled = NO;
    tier2b.isEnabled = NO;
    t2a_locked.visible = YES;
    t2b_locked.visible = YES;
    
    // reset selected menu sprite
    [self resetSelectedMenuSprite];
    
}

- (void) insertHeroImage {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    GameManager *m = [GameManager sharedGameManager];
    
    CCSprite *heroImageSprite = [CCSprite node];
            
    if (m.selectedHero.characterID == 1) {
        heroImageSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                        spriteFrameByName: @"hero_1_large.png"];
    } else if (m.selectedHero.characterID == 2) {
        heroImageSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                        spriteFrameByName: @"hero_2_large.png"];
    } else if (m.selectedHero.characterID == 3) {
        heroImageSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                        spriteFrameByName: @"hero_3_large.png"];
    }
    
    heroImageSprite.zOrder = 9999;
    heroImageSprite.position = ccp(67.0f, screenSize.height - 64.0f);
    
    [self addChild: heroImageSprite];    
    
}

- (void) initPowerDescriptions {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    NSString *pathName1 = [[NSBundle mainBundle] pathForResource: @"DescriptionLabel" ofType: @"plist"];
    NSDictionary *powerDescriptionDictionary = [NSDictionary dictionaryWithContentsOfFile: pathName1];
    
    NSString *pathName2 = [[NSBundle mainBundle] pathForResource: @"CharacterDescription" ofType: @"plist"];
    NSDictionary *charDescriptionDictionary = [NSDictionary dictionaryWithContentsOfFile: pathName2];
    
    NSString *staticPowerString;
    
    NSString *power1;
    NSString *descriptionString1;
    
    NSString *power2;
    NSString *descriptionString2;
    
    NSString *power3;
    NSString *descriptionString3;
    
    // obtain the appropriate images
    if ([GameManager sharedGameManager].selectedHero.characterID == 1) {
        
        staticPowerString = [NSString stringWithFormat: @"%@", [charDescriptionDictionary valueForKey: @"Hero Static Power 1"]];
        
        power1 = [NSString stringWithFormat: @"c1_p1_icon_1.png"];
        descriptionString1 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Overclock"]];
        
        power2 = [NSString stringWithFormat: @"c1_p2_icon_1.png"];
        descriptionString2 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Longshot"]];

        power3 = [NSString stringWithFormat: @"c1_p3_icon_1.png"];
        descriptionString3 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Mine"]];
        
    } else if ([GameManager sharedGameManager].selectedHero.characterID == 2) {
        
        staticPowerString = [NSString stringWithFormat: @"%@", [charDescriptionDictionary valueForKey: @"Hero Static Power 2"]];

        power1 = [NSString stringWithFormat: @"c2_p1_icon_1.png"];
        descriptionString1 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Blizzard"]];

        power2 = [NSString stringWithFormat: @"c2_p2_icon_1.png"];
        descriptionString2 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Poison"]];

        power3 = [NSString stringWithFormat: @"c2_p3_icon_1.png"];
        descriptionString3 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Smite"]];
        
    } else if ([GameManager sharedGameManager].selectedHero.characterID == 3) {
        
        staticPowerString = [NSString stringWithFormat: @"%@", [charDescriptionDictionary valueForKey: @"Hero Static Power 3"]];

        power1 = [NSString stringWithFormat: @"c3_p1_icon_1.png"];
        descriptionString1 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Rage"]];

        power2 = [NSString stringWithFormat: @"c3_p2_icon_1.png"];
        descriptionString2 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Slow"]];

        power3 = [NSString stringWithFormat: @"c3_p3_icon_1.png"];
        descriptionString3 = [NSString stringWithFormat: @"%@", [powerDescriptionDictionary valueForKey: @"Meditate"]];

    }
    
    // create the sprites and labels
    CCSprite *powerSprite1 = [CCSprite spriteWithSpriteFrameName: power1];
    CCSprite *powerSprite2 = [CCSprite spriteWithSpriteFrameName: power2];
    CCSprite *powerSprite3 = [CCSprite spriteWithSpriteFrameName: power3];
    
    CCLabelBMFont *powerLabel1 = [CCLabelBMFont labelWithString: descriptionString1 fntFile: @"MushroomTextSmall.fnt" width: 365
                                                      alignment: CCTextAlignmentLeft];
    CCLabelBMFont *powerLabel2 = [CCLabelBMFont labelWithString: descriptionString2 fntFile: @"MushroomTextSmall.fnt" width: 365
                                                      alignment: CCTextAlignmentLeft];
    CCLabelBMFont *powerLabel3 = [CCLabelBMFont labelWithString: descriptionString3 fntFile: @"MushroomTextSmall.fnt" width: 365
                                                      alignment: CCTextAlignmentLeft];
    
    NSArray *spriteArray = [NSArray arrayWithObjects: powerSprite1, powerSprite2, powerSprite3, nil];
    NSArray *labelArray = [NSArray arrayWithObjects: powerLabel1, powerLabel2, powerLabel3, nil];
    
    float offset1 = 10.0f;
    float offset2 = 25.0f;
    float offset3 = 25.0f;
    float offset4 = 5.0f;
    
    for (int i = 0; i < [spriteArray count]; i++) {
        
        CCSprite *tmpSprite = [spriteArray objectAtIndex: i];
        CCLabelBMFont *tmpLabel = [labelArray objectAtIndex: i];
        
        tmpSprite.zOrder = 9999;
        tmpLabel.zOrder = 9999;
        
        tmpLabel.anchorPoint = ccp(0.0, 0.5);
        tmpLabel.scale = 0.55f;
        
        tmpSprite.position = ccp(screenSize.width/2 + offset1, screenSize.height - (5.1+2*i)*offset2);
        tmpLabel.position = ccp(screenSize.width/2 + offset1 + offset3, screenSize.height - (5.1+2*i)*offset2);
        
        [self addChild: tmpSprite];
        [self addChild: tmpLabel];
    }
    
    // place the static power string
    CCLabelBMFont *staticPowerLabel = [CCLabelBMFont labelWithString: staticPowerString fntFile: @"MushroomTextSmall.fnt" width: 325
                                                           alignment: CCTextAlignmentCenter];
    staticPowerLabel.scale = 0.7f;
    staticPowerLabel.zOrder = 9999;
    staticPowerLabel.color = ccYELLOW;
    staticPowerLabel.anchorPoint = ccp(0.0, 0.5);
    staticPowerLabel.position = ccp(screenSize.width/2 + offset4, screenSize.height - (11.2)*offset2);
    
    [self addChild: staticPowerLabel];
    
}

- (void) insertTalentBackgroundImage {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *backgroundImage = [CCSprite spriteWithFile: @"talent_background_1.png"];
    backgroundImage.position = ccp(screenSize.width/2, screenSize.height/2);
    
    [self addChild: backgroundImage
                 z: kBackgroundZOrder
               tag: 0];

}

- (void) togglePowersScreen: (CCMenuItemToggle *) sender {
    
    PLAYSOUNDEFFECT(power_select_button_sound);
    
    if (self.powersScreen.visible == NO) {
        
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
        
        [FlurryAnalytics logEvent: @"powers button pressed" withParameters: fDict];

        
        self.powersScreen.visible = YES;
    } else {
        self.powersScreen.visible = NO;
    }
    
}

- (void) insertPowersButton {
    
    float padding = 7.0f;
    
    // initialize the powers button
    
    CCSprite *powersButtonNormal = [CCSprite spriteWithSpriteFrameName: @"powers_button_1.png"];
    CCSprite *powersButtonSelected = [CCSprite spriteWithSpriteFrameName: @"powers_button_2.png"];
    CCMenuItemSprite *powersMenuItemButton1 = [CCMenuItemSprite itemWithNormalSprite: powersButtonNormal
                                                                       selectedSprite: nil];
    CCMenuItemSprite *powersMenuItemButton2 = [CCMenuItemSprite itemWithNormalSprite: powersButtonSelected
                                                                             selectedSprite: nil];
    
    CCMenuItemToggle *powersButton = [CCMenuItemToggle itemWithTarget: self selector: @selector(togglePowersScreen:) 
                                                                items: powersMenuItemButton1, powersMenuItemButton2, nil];
    powersButton.selectedIndex = 0;
    
    CCMenu *powersMenu = [CCMenu menuWithItems: powersButton, nil];
    powersMenu.position = ccp(2.0f*padding + 1.5f*powersButtonNormal.contentSize.width, padding + powersButtonNormal.contentSize.height/2.0f);
    powersMenu.zOrder = 9999;
    
    [self addChild: powersMenu];
    
    // initialize the power screen
    
    GameManager *m = [GameManager sharedGameManager];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // for standard hero
    if (m.selectedHero.characterID == 1) {
        
        self.powersScreen = [CCSprite spriteWithFile: @"power_screen_1.png"];
        
        // for mage hero
    } else if (m.selectedHero.characterID == 2) {
        
        self.powersScreen = [CCSprite spriteWithFile: @"power_screen_2.png"];

        // for assassin hero
    } else if (m.selectedHero.characterID == 3) {
        
        self.powersScreen = [CCSprite spriteWithFile: @"power_screen_3.png"];
        
    }
    
    powersScreen.position = ccp(screenSize.width/2, screenSize.height/2);
    powersScreen.visible = NO;
    powersScreen.zOrder = 999999;
    [self addChild: powersScreen];
    
    
}

- (void) insertMainTitles {
    
    GameManager *m = [GameManager sharedGameManager];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    NSString *heroNameString;
    
    if (m.selectedHero.characterID == 1) {
        heroNameString = [NSString stringWithFormat: HERO_NAME_1];
    } else if (m.selectedHero.characterID == 2) {
        heroNameString = [NSString stringWithFormat: HERO_NAME_2];
    } else {
        heroNameString = [NSString stringWithFormat: HERO_NAME_3];
    }
    
    CCLabelBMFont *heroNameLabel = [CCLabelBMFont labelWithString: heroNameString fntFile: @"MushroomTextMedium.fnt"];
    heroNameLabel.zOrder = 9999;
    heroNameLabel.color = ccYELLOW;
    heroNameLabel.position = ccp(66.0f, screenSize.height - 14.0f);
    
    [self addChild: heroNameLabel];
    
    CCLabelBMFont *talentsLabel = [CCLabelBMFont labelWithString: @"Talents" fntFile: @"MushroomTextMedium.fnt"];
    talentsLabel.zOrder = 9999;
    talentsLabel.color = ccYELLOW;
    talentsLabel.position = ccp(screenSize.width/2 + 65.0f, screenSize.height - 14.0f);
    
    [self addChild: talentsLabel];
    
}

- (void) insertResetAndApplyButtons {
    
    // reset button
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName: @"reset_button_1.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName: @"reset_button_2.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemWithNormalSprite: resetButtonNormal
                                                            selectedSprite: resetButtonSelected
                                                                    target: self
                                                                  selector: @selector(resetPoints)];
    
    CCSprite *applyButtonNormal = [CCSprite spriteWithSpriteFrameName: @"apply_button_1.png"];
    CCSprite *applyButtonSelected = [CCSprite spriteWithSpriteFrameName: @"apply_button_2.png"];
    
    CCMenuItemSprite *applyButton = [CCMenuItemSprite itemWithNormalSprite: applyButtonNormal
                                                            selectedSprite: applyButtonSelected
                                                                    target: self
                                                                  selector: @selector(upgradeTalent:)];
    
    CCMenu *talentMenu = [CCMenu menuWithItems: resetButton, applyButton, nil];
    [talentMenu alignItemsHorizontallyWithPadding: 5.0f];
    talentMenu.position = ccp(397.0f, 64.0f);
    talentMenu.zOrder = 9999;
    
    [self addChild: talentMenu];
    
}

- (id) init {
    if (self = [super init]) {
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [self insertTalentBackgroundImage];
        
        // initializes the text to use for talent descriptions
        [self initTalentTextDictionary];
        
        // insert back button
        [self insertBackButtonWithSelector: @selector(popSceneOut) withAds: NO];
        
        // this button needs to look different
        // remove reset button from the final game --- or maybe keep it in ???
        /*
        [self insertResetButtonWithSelector: @selector(resetPoints)];
        */
        
        // inserts the talent tree with all the accompanying graphics and text
        [self insertTalentTree];
        
        // inserts the hero image
        [self insertHeroImage];
        
        // insert powers button
        [self insertPowersButton];
        
        // insert main titles
        [self insertMainTitles];
        
        // insert reset and apply buttons
        [self insertResetAndApplyButtons];
        
        self.highlightedSprite = [CCSprite spriteWithSpriteFrameName: @"talent_button_highlight_1.png"];
        self.highlightedSprite.zOrder = 999;
        self.highlightedSprite.position = ccp(-screenSize.width, -screenSize.height);
        [self addChild: highlightedSprite];
        
        // talent description title
        self.talentTitleLabel = [CCLabelBMFont labelWithString: @" "
                                                       fntFile: @"MushroomTextMedium.fnt"];
        self.talentTitleLabel.anchorPoint = ccp(0.0, 0.5);
        self.talentTitleLabel.position = ccp(28.0f, 185.0f);
        self.talentTitleLabel.color = ccYELLOW;
        [self addChild: talentTitleLabel];
        
        // talent description text
        self.talentDescriptionLabel = [CCLabelBMFont labelWithString: @" " 
                                                             fntFile: @"MushroomTextSmall.fnt"
                                                               width: 250 
                                                           alignment: CCTextAlignmentLeft];
        self.talentDescriptionLabel.zOrder = 99999;
        self.talentDescriptionLabel.anchorPoint = ccp(0.0, 1.0);
        self.talentDescriptionLabel.position = ccp(28.0f, 168.0f);
        self.talentDescriptionLabel.scale = 0.8f;
        [self addChild: talentDescriptionLabel];
        
        self.talentPointsLabel = [CCLabelBMFont labelWithString: @" " 
                                                        fntFile: @"MushroomTextMedium.fnt"];
        self.talentPointsLabel.position = ccp(218.0f, 70.0f);
        self.talentPointsLabel.zOrder = 99999;
        self.talentPointsLabel.color = ccYELLOW;
        self.talentPointsLabel.scale = 1.0f;
        [self addChild: talentPointsLabel];
        
        // update: no more power descriptions
        /*
        // inserts the power descriptions specific to the hero
        [self initPowerDescriptions];
        */
        
    }
    return self;
}

@end






























