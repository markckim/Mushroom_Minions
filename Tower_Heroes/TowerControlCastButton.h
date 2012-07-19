//
//  TowerControlCastButton.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControl.h"

@interface TowerControlCastButton : TowerControl
{
    ObjectType objectType;
    TowerType towerType;
    BulletType bulletType;
    CastType castType;
    
    NSString *disabledSpriteName;
    CCSprite *disabledSprite;
    
    id <GamePlayLayerDelegate> delegate;
}

@property (nonatomic, strong) CCLabelBMFont *descriptionLabel;

@property (nonatomic, assign) ObjectType objectType;
@property (nonatomic, assign) TowerType towerType;
@property (nonatomic, assign) BulletType bulletType;
@property (nonatomic, assign) CastType castType;
@property (nonatomic, copy) NSString *disabledSpriteName;
@property (nonatomic, strong) CCSprite *disabledSprite;
@property (nonatomic, assign) id <GamePlayLayerDelegate> delegate;

// these are init and factory methods for the two different types of cast buttons available

- (id) initWithSpriteName: (NSString *) spriteName 
        andDragSpriteName: (NSString *) dSpriteName
            andObjectType: (ObjectType) oType 
             andTowerType: (TowerType) tType;

- (id) initWithSpriteName: (NSString *) spriteName 
        andDragSpriteName: (NSString *) dSpriteName
            andObjectType: (ObjectType) oType 
            andBulletType: (BulletType) bType 
              andCastType: (CastType) cType;

+ (id) buttonWithSpriteName: (NSString *) spriteName 
          andDragSpriteName: (NSString *) dSpriteName
              andObjectType: (ObjectType) oType 
               andTowerType: (TowerType) tType;

+ (id) buttonWithSpriteName: (NSString *) spriteName 
          andDragSpriteName: (NSString *) dSpriteName
              andObjectType: (ObjectType) oType 
              andBulletType: (BulletType) bType 
                andCastType: (CastType) cType;

@end




