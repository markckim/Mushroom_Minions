//
//  CCRadioMenu.m
//  MathNinja
//
//  Created by Ray Wenderlich on 2/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CCRadioMenu.h"

@implementation CCRadioMenu

- (void)setSelectedItem_:(CCMenuItem *)item {
    [selectedItem_ unselected];
    selectedItem_ = item;    
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
 
    if ( state_ != kCCMenuStateWaiting ) return NO;
    
    CCMenuItem *curSelection = [self itemForTouch:touch];
    [curSelection selected];
    _curHighlighted = curSelection;
    
    if (_curHighlighted) {
        if (selectedItem_ != curSelection) {
            [selectedItem_ unselected];
        }
        state_ = kCCMenuStateTrackingTouch;
        return YES;
    }
    return NO;
    
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {

    NSAssert(state_ == kCCMenuStateTrackingTouch, @"[Menu ccTouchEnded] -- invalid state");
	
    CCMenuItem *curSelection = [self itemForTouch:touch];
    if (curSelection != _curHighlighted && curSelection != nil) {
        [selectedItem_ selected];
        [_curHighlighted unselected];
        _curHighlighted = nil;
        state_ = kCCMenuStateWaiting;
        return;
    } 
    
    selectedItem_ = _curHighlighted;
    [_curHighlighted activate];
    _curHighlighted = nil;
    
	state_ = kCCMenuStateWaiting;
    
}

- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
 
    NSAssert(state_ == kCCMenuStateTrackingTouch, @"[Menu ccTouchCancelled] -- invalid state");
	
	[selectedItem_ selected];
    [_curHighlighted unselected];
    _curHighlighted = nil;
	
	state_ = kCCMenuStateWaiting;
    
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state_ == kCCMenuStateTrackingTouch, @"[Menu ccTouchMoved] -- invalid state");
	
	CCMenuItem *curSelection = [self itemForTouch:touch];
    if (curSelection != _curHighlighted && curSelection != nil) {       
        [_curHighlighted unselected];
        [curSelection selected];
        _curHighlighted = curSelection;        
        return;
    }
    
}

@end
