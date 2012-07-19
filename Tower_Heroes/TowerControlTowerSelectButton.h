//
//  TowerControlTowerSelectButton.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControl.h"

@class TowerControlCastButton;

@interface TowerControlTowerSelectButton : TowerControl
{
    NSMutableArray *listOfCastButtons;
    
    BOOL buttonState;
    BOOL isInitialized;
}

@property (nonatomic, strong) NSMutableArray *listOfCastButtons;

@property (nonatomic, assign) BOOL buttonState;
@property (nonatomic, assign) BOOL isInitialized;

- (id) initWithSpriteName: (NSString *) spriteName;
- (id) initWithSpriteName: (NSString *) spriteName 
     andListOfCastButtons: (NSMutableArray *) cButtons;

+ (id) buttonWithSpriteName: (NSString *) spriteName;
+ (id) buttonWithSpriteName: (NSString *) spriteName 
       andListOfCastButtons: (NSMutableArray *) cButtons;

@end
