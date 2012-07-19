//
//  PathGenerator.h
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PathGenerator : NSObject
{
    // array of tile coordinates
    NSArray *pathPoints;
    
    // array of arrays; each array is filled with indices to be used for pathPoints
    NSArray *pathSolutions;
    
    //this becomes the chosen solution
    NSMutableArray *selectedPath;
    
    CGSize tileSize;
    CGSize mapSize;
}

@property (nonatomic, strong) NSArray *pathPoints;
@property (nonatomic, strong) NSArray *pathSolutions;
@property (nonatomic, strong) NSMutableArray *selectedPath;

- (CGPoint) nextPoint;
- (CGPoint) startingPoint;
- (CGPoint) positionForTileCoord: (CGPoint) tileCoord;

- (id) initWithPathPoints: (NSArray *) pathP andPathSolutions: (NSArray *) pathS;
+ (id) pathWithPathPoints: (NSArray *) pathP andPathSolutions: (NSArray *) pathS;

@end
