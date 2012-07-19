//
//  PreLoadLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@interface PreLoadLayer : GameLayer
{
    CCLabelBMFont *loadingLabel;    
}

@property (nonatomic, strong) CCLabelBMFont *loadingLabel;

@end
