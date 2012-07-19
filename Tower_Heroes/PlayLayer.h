//
//  PlayLayer.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"

@interface PlayLayer : GameLayer {
    
}

- (void) insertPlayAndOptionButtons;
- (void) insertLinkButton;
- (void) initImagesAndAnimations;
- (void) insertCover;

- (void) insertSoundButton;

- (void) linkButtonPressed: (id) sender;

@end
