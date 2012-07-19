//
//  TowerControlMenuButton.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControl.h"
#import "TowerPlacement.h"

@interface TowerControlMenuButton : TowerControl
{
    ModifierType modifierType;
    SceneType sceneType;
    
    TowerType towerType;
    
    // this sprite will take on the different costs; it will also show "MAX" when no more upgrades can be given
    CCSprite *costSprite;
    CCLabelBMFont *costLabel;
    
    // this is a simple labels that just say something to the effect of "Damage", "Accuracy", "Critical", "Remove"
    CCLabelBMFont *menuLabel;
    
    // these are labels that show the actual stats associated with the tower traits
    CCLabelBMFont *statsLabel;
    
    // this sprite will be shown when the player can't afford the next upgrade
    CCSprite *disabledSprite;
    
    // this is a reference to the tower placement
    TowerPlacement *towerPlacement;
    
}

@property (nonatomic, assign) ModifierType modifierType;
@property (nonatomic, assign) SceneType sceneType;
@property (nonatomic, assign) TowerType towerType;
@property (nonatomic, strong) CCSprite *costSprite;
@property (nonatomic, strong) CCLabelBMFont *costLabel;
@property (nonatomic, strong) CCSprite *disabledSprite;
@property (nonatomic, strong) CCLabelBMFont *menuLabel;
@property (nonatomic, strong) CCLabelBMFont *statsLabel;
@property (nonatomic, assign) TowerPlacement *towerPlacement;

- (id) initWithSpriteName: (NSString *) spriteName andModifierType: (ModifierType) mType;
- (id) initWithSpriteName: (NSString *) spriteName 
          andModifierType: (ModifierType) mType 
             andSceneType: (SceneType) sType;

+ (id) buttonWithSpriteName: (NSString *) spriteName andModifierType: (ModifierType) mType;
+ (id) buttonWithSpriteName: (NSString *) spriteName 
            andModifierType: (ModifierType) mType 
               andSceneType: (SceneType) sType;

@end
