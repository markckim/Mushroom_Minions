//
//  PathGenerator.m
//  Tower_Defense_Take3
//
//  Created by Mark Kim on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PathGenerator.h"

@implementation PathGenerator

@synthesize pathPoints;
@synthesize pathSolutions;
@synthesize selectedPath;

- (void) dealloc {
    self.pathPoints = nil;
    self.pathSolutions = nil;
    self.selectedPath = nil;
    
    [super dealloc];
}

- (CGPoint) positionForTileCoord: (CGPoint) tileCoord {
    
    float positionX = (tileSize.width/2)*tileCoord.x + ((tileSize.width/2)/2);
    float positionY = (mapSize.height*(tileSize.height/2)) 
    - (tileSize.height/2)*tileCoord.y - ((tileSize.height/2)/2);
    
    // note: position is returned in "points" (i.e., compatible with both iPhone 3 and 4
    
    return ccp(positionX,positionY);
}

- (CGPoint) nextPoint {
    [self.selectedPath removeObjectAtIndex: 0];
    
    NSNumber *tmpIndexNumber = (NSNumber *)[self.selectedPath objectAtIndex: 0];
    int tmpIndex = [tmpIndexNumber intValue];
    
    NSValue *tmpValue = (NSValue *)[self.pathPoints objectAtIndex: tmpIndex];
    
    CGPoint nextTileCoord = [tmpValue CGPointValue];
    
    return [self positionForTileCoord: nextTileCoord];
}

- (CGPoint) startingPoint {
    int numberOfSolutions = [self.pathSolutions count];
    int indexToChoose = arc4random() % numberOfSolutions;
    
    NSArray *tmpArray = (NSArray *)[self.pathSolutions objectAtIndex: indexToChoose];
    
    // adding noise to the path -- TO DO, if needed
    
    self.selectedPath = [NSMutableArray arrayWithArray: tmpArray];
    
    NSNumber *tmpIndexNumber = (NSNumber *)[self.selectedPath objectAtIndex: 0];
    int tmpIndex = [tmpIndexNumber intValue];
    
    NSValue *tmpValue = (NSValue *)[self.pathPoints objectAtIndex: tmpIndex];
    
    CGPoint startingTileCoord = [tmpValue CGPointValue];
    
    return [self positionForTileCoord: startingTileCoord];
}

- (id) initWithPathPoints: (NSArray *) pathP andPathSolutions: (NSArray *) pathS {
    if (self = [super init]) {
        self.pathPoints = pathP;
        self.pathSolutions = pathS;
        
        // NOTE: assumes a tile size of 8x8 pixels
        
        tileSize.width = 8;
        tileSize.height = 8;
        mapSize.width = 960/tileSize.width; // in this case, 120 tiles
        mapSize.height = 640/tileSize.height; // in this case, 80 tiles
    }
    
    return self;
}

+ (id) pathWithPathPoints: (NSArray *) pathP andPathSolutions: (NSArray *) pathS {
    return [[[self alloc] initWithPathPoints: pathP andPathSolutions: pathS] autorelease];
}


@end
