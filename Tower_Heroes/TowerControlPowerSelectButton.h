//
//  TowerControlPowerSelectButton.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerControl.h"

@interface TowerControlPowerSelectButton : TowerControl
{
    CCArray *listOfPowerButtons;
    CCArray *listOfOptionButtons;
    
    BOOL buttonState;
    BOOL isInitialized;    
}

@property (nonatomic, strong) CCArray *listOfPowerButtons;
@property (nonatomic, strong) CCArray *listOfOptionButtons;

@property (nonatomic, assign) BOOL buttonState;
@property (nonatomic, assign) BOOL isInitialized;

- (id) initWithSpriteName: (NSString *) spriteName;
- (id) initWithSpriteName: (NSString *) spriteName 
    andListOfPowerButtons: (CCArray *) pButtons 
   andListOfOptionButtons: (CCArray *) oButtons;

+ (id) buttonWithSpriteName: (NSString *) spriteName;
+ (id) buttonWithSpriteName: (NSString *) spriteName 
      andListOfPowerButtons: (CCArray *) pButtons 
     andListOfOptionButtons: (CCArray *) oButtons;

@end
