//
//  CreditLayer.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreditLayer.h"

@implementation CreditLayer

- (void) insertTitle {
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelBMFont *titleLabel = [CCLabelBMFont labelWithString: @"Credits" fntFile: @"MushroomText.fnt"];
    titleLabel.scale = 0.7f;

    float offSetY = 35.0f;
    titleLabel.position = ccp(screenSize.width/2, screenSize.height - offSetY);
        
    [self addChild: titleLabel
                 z: kTitleZOrder 
               tag: 1];
}

- (void) insertCredits {
    
    float adOffsetY = 0.0f;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    NSString *descString1 = [NSString stringWithFormat: @"Programming & Artwork"];
    NSString *nameString1 = [NSString stringWithFormat: @"Mark Kim"];
    
    NSString *descString2 = [NSString stringWithFormat: @"Music & Sound Design"];
    NSString *nameString2 = [NSString stringWithFormat: @"Steven Lee"];
    
    CCLabelBMFont *descLabel1 = [CCLabelBMFont labelWithString: descString1 fntFile: @"MushroomTextMedium.fnt"];
    CCLabelBMFont *nameLabel1 = [CCLabelBMFont labelWithString: nameString1 fntFile: @"MushroomTextSmall.fnt"];
    CCLabelBMFont *descLabel2 = [CCLabelBMFont labelWithString: descString2 fntFile: @"MushroomTextMedium.fnt"];
    CCLabelBMFont *nameLabel2 = [CCLabelBMFont labelWithString: nameString2 fntFile: @"MushroomTextSmall.fnt"];
    
    descLabel1.scale = 1.0f;
    nameLabel1.scale = 1.0f;
    descLabel2.scale = 1.0f;
    nameLabel2.scale = 1.0f;
    
    float offsetY1 = 15.0f;
    float offsetY2 = 20.0f;
    float y1 = screenSize.height*2.0f/3.0f - offsetY2;
    float y2 = screenSize.height*1.0f/3.0f;
    
    descLabel1.position = ccp(screenSize.width/2, y1 + offsetY1 + adOffsetY);
    nameLabel1.position = ccp(screenSize.width/2, y1 - offsetY1 + adOffsetY);
    descLabel2.position = ccp(screenSize.width/2, y2 + offsetY1 + adOffsetY);
    nameLabel2.position = ccp(screenSize.width/2, y2- offsetY1 + adOffsetY);
    
    descLabel1.zOrder = 9999;
    nameLabel1.zOrder = 9999;
    descLabel2.zOrder = 9999;
    nameLabel2.zOrder = 9999;
    
    [self addChild: descLabel1];
    [self addChild: nameLabel1];
    [self addChild: descLabel2];
    [self addChild: nameLabel2];
    
}

- (id) init {
    if (self = [super init]) {
        
        [self insertBackgroundImage];
        [self insertTitle];
        [self insertBackButtonWithSelector: @selector(playScene) withAds: NO];
        
        [self insertCredits];
    }
    return self;
}

@end











