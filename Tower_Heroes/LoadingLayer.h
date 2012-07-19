//
//  LoadingLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@interface LoadingLayer : GameLayer

{
    CCLabelBMFont *loadingLabel;
}

@property (nonatomic, strong) CCLabelBMFont *loadingLabel;

- (void) initAnimations;

@end
