//
//  GamePlayLayer.m
//  
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePlayLayer.h"
#import "Tower.h"
#import "TowerStandard.h"
#import "TowerIce.h"
#import "TowerBomb.h"
#import "Bullet.h"
#import "BulletStandard.h"
#import "BulletIce.h"
#import "BulletBomb.h"
#import "BulletCast.h"
#import "Enemy.h"
#import "EnemyMud.h"
#import "EnemyDreadling.h"
#import "EnemyMinion.h"
#import "EnemyPhib.h"
#import "BackgroundLayer.h"
#import "ControlsLayer.h"
#import "TowerControl.h"
#import "TowerControlPowerSelectButton.h"
#import "Tower.h"
#import "EnemyGenerator.h"
#import "TowerPlacement.h"
#import "GameScene1.h"

@implementation GamePlayLayer

@synthesize gs1_reference;
@synthesize introDelay;
@synthesize gs1SpriteBatchNode;
@synthesize enemyMud;
@synthesize effectsQueue;
@synthesize objectQueue;
@synthesize effectsToDelete;
@synthesize enemiesToDelete;
@synthesize bulletsToDelete;
@synthesize towersToDelete;
@synthesize towerDelegateCollection;
@synthesize enemyCollection;
@synthesize backgroundLayer;
@synthesize controlsLayer;
@synthesize enemyGenerator;
@synthesize towerPlacementSprites;

@synthesize screenSize;
@synthesize enemySpawnTimer;
@synthesize countdownTimer;

@synthesize powerButtonTimer;
@synthesize isMeditateActive;
@synthesize meditationRef;

- (void) dealloc {
        
    self.gs1_reference = nil;
    self.gs1SpriteBatchNode = nil;
    self.controlsLayer = nil;
    self.backgroundLayer = nil;
    self.enemyMud = nil;
    self.effectsQueue = nil;
    self.objectQueue = nil;
    self.effectsToDelete = nil;
    self.enemiesToDelete = nil;
    self.bulletsToDelete = nil;
    self.towersToDelete = nil;
    self.towerDelegateCollection = nil;
    self.enemyCollection = nil;
    self.enemyGenerator = nil;
    self.towerPlacementSprites = nil;
    self.meditationRef = nil;
    
    [super dealloc];
}

- (void) updateTimer: (float *) timerPointer 
       withDeltaTime: (ccTime) deltaTime {
    
    if (*timerPointer < 0.0f) {
        return;
    }
    
    *timerPointer = *timerPointer - deltaTime;
    
    NSString *s = [NSString stringWithFormat: @"%.f", *timerPointer];
    
    [self.controlsLayer.powerOneCooldownLabel setString: s];
    [self.controlsLayer.powerTwoCooldownLabel setString: s];
    [self.controlsLayer.powerThreeCooldownLabel setString: s];
    
    if (*timerPointer < 0.0f) {
        *timerPointer = -1.0f;
        
        [self.controlsLayer checkToDisablePowers];
    }
}


- (void) receiveCoins: (int) amountOfCoins {
        
    self.controlsLayer.coins = self.controlsLayer.coins + amountOfCoins;
    NSString *tmpString = [NSString stringWithFormat: @"%d",  self.controlsLayer.coins];
    
    self.controlsLayer.coinCount.string = tmpString;
    
    id actionScaleUp = [CCScaleTo actionWithDuration: 0.1f scale: 1.12f];
    id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
    id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
    
    [self.controlsLayer.coinCount runAction: actionSequence];
    
    // this checks to update disabled towers if the player can now afford to purchase them
    if (self.controlsLayer.powerSelectButton.buttonState == YES) {
        // do nothing
        
    } else if (self.controlsLayer.powerSelectButton.buttonState == NO) {
        [self.controlsLayer checkToDisableTowerPurchasing];
    }
    
    // this checks to update upgrades if the player can now afford to purchase them
    // this checks only if the tower personal menu is currently active
    if (self.controlsLayer.selectedTowerControl.buttonType == kTowerButton) {
        Tower *t = (Tower *) self.controlsLayer.selectedTowerControl;
        [t showAppropriatePersonalMenu];
    }
}

- (void) receiveExperience: (int) amountOfExperience {
    
    GameManager *m = [GameManager sharedGameManager];
    
    // calculate the correct xp
    if (m.selectedHero.characterLevel < MAX_LEVEL) {
        // if the gained experience increases the player's level
        if (m.selectedHero.experiencePoints + amountOfExperience >= m.selectedHero.currentExperienceLimit) {
            
            // calculate how many experience points to add to the next level
            int experienceLeftInLevel = m.selectedHero.currentExperienceLimit - m.selectedHero.experiencePoints;
            int difference = amountOfExperience - experienceLeftInLevel;
            
            m.selectedHero.totalExperiencePoints += experienceLeftInLevel;
                        
            [m.selectedHero nextLevel];
            
            amountOfExperience = difference;
            
            // update heroLevelLabel in controls layer
            int newHeroLevel = m.selectedHero.characterLevel;
            NSString *newHeroLevelString = [NSString stringWithFormat: @"Level %d", newHeroLevel];
            
            self.controlsLayer.heroLevelLabel.string = newHeroLevelString;
            
            id actionScaleUp = [CCScaleTo actionWithDuration: 0.1f scale: 1.0f];
            id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 0.8f];
            id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
            [self.controlsLayer.heroLevelLabel runAction: actionSequence];
        }
        
        m.selectedHero.experiencePoints += amountOfExperience;
        m.selectedHero.totalExperiencePoints += amountOfExperience;
    } else {
        m.selectedHero.totalExperiencePoints += amountOfExperience;
    }
        
    // show the correct xp label; if player has surpassed the max level, only show TOTAL XP
    if (m.selectedHero.characterLevel < MAX_LEVEL) {
        int newExperience = m.selectedHero.experiencePoints;
        int experienceLimit = m.selectedHero.currentExperienceLimit;
        
        NSString *xpString = [NSString stringWithFormat: @"%d", newExperience];
        NSString *xpLimit = [NSString stringWithFormat: @"%d", experienceLimit];
        NSString *combinedExperienceString = [NSString stringWithFormat: @"%@/%@", xpString, xpLimit];
        
        self.controlsLayer.experienceCountLabel.string = combinedExperienceString;

    } else {
        NSString *xpString = [NSString stringWithFormat: @"%d", m.selectedHero.totalExperiencePoints];
        self.controlsLayer.experienceCountLabel.string = xpString;
        
    }
        
    id actionScaleUp = [CCScaleTo actionWithDuration: 0.1f scale: 1.12f];
    id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 1.0f];
    id actionSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
    
    [self.controlsLayer.experienceCountLabel runAction: actionSequence];
}

- (void) createEffect: (CCNode *) effect {
    [self.effectsQueue addObject: effect];
}

- (void) queueEffectToDelete: (CCNode *) effect {
    [self.effectsToDelete addObject: effect];
}

- (void) createTowerType: (TowerType) towerType 
     withInitialPosition: (CGPoint) initialPosition 
   andPlacementReference: (TowerPlacement *) placementReference {
    
    Tower *tower;
    
    if (towerType == kTowerStandard) {
        tower = (TowerStandard *)[[TowerStandard alloc] init];
        [self receiveCoins: -kTowerStandardCost];
        
    } else if (towerType == kTowerIce) {
        tower = (TowerIce *)[[TowerIce alloc] init];
        [self receiveCoins: -kTowerIceCost];
        
    } else if (towerType == kTowerBomb) {
        tower = (TowerBomb *)[[TowerBomb alloc] init];
        [self receiveCoins: -kTowerBombCost];

    }
    
    tower.position = initialPosition;
    tower.delegate = self;
    tower.controlsLayer = self.controlsLayer;
    tower.towerPlacementReference = placementReference;
    
    // inactivate the placement after tower has been placed there;
    tower.towerPlacementReference.isActive = NO;
    
    CGPoint uiPosition = [[CCDirector sharedDirector] convertToUI: initialPosition];
    
    NSDictionary *tmpTowerDictionary = [NSDictionary dictionaryWithObjectsAndKeys: 
                                        tower, @"object", [NSNumber numberWithInt: uiPosition.y], @"z", 
                                        [NSNumber numberWithInt: kTowerTagValue], @"tag", nil];
    [self.objectQueue addObject: tmpTowerDictionary];
    [self.towerDelegateCollection addObject: tower.tDelegate];
    
    [tower release];
}

- (void) createEnemyType: (EnemyType) enemyType 
{
    Enemy *enemy;
    
    if (enemyType == kEnemyMud) {
        enemy = (EnemyMud *)[[EnemyMud alloc] initWithEnemyType: kEnemyMud];
        [enemyCollection addObject: enemy];
    } else if (enemyType == kEnemyDreadling) {
        enemy = (EnemyDreadling *)[[EnemyDreadling alloc] init];
        [enemyCollection addObject: enemy];
    } else if (enemyType == kEnemyMinion) {
        enemy = (EnemyMinion *)[[EnemyMinion alloc] init];
        [enemyCollection addObject: enemy];
    } else if (enemyType == kEnemyPhib) {
        enemy = (EnemyPhib *)[[EnemyPhib alloc] init];
        [enemyCollection addObject: enemy];
    } else if (enemyType == kEnemyCritling) {
        enemy = (EnemyMud *)[[EnemyMud alloc] initWithEnemyType: kEnemyCritling];
        [enemyCollection addObject: enemy];
    } else if (enemyType == kEnemyPinki) {
        enemy = (EnemyMud *)[[EnemyMud alloc] initWithEnemyType: kEnemyPinki];
        [enemyCollection addObject: enemy];
    } else if (enemyType == kEnemyTarling) {
        enemy = (EnemyMud *)[[EnemyMud alloc] initWithEnemyType: kEnemyTarling];
        [enemyCollection addObject: enemy];
    } else {
        CCLOG(@"GPL: unrecognized enemy to create");
    }
    
    enemy.delegate = self;
    enemy.backgroundLayer = backgroundLayer;
    
    // implement any after effects here (e.g., mudmonster has eyes)
    if (enemyType == kEnemyMud) {
        
        EnemyMud *e = (EnemyMud *) enemy;
        
        e.eyes.position = enemy.position;
    }
    
    
    enemy.position = [enemy.path startingPoint];
    enemy.currentDestination = [enemy.path nextPoint];
        
    NSDictionary *tmpEnemyDictionary = [NSDictionary dictionaryWithObjectsAndKeys: 
                                        enemy, @"object", [NSNumber numberWithInt: kEnemyZOrder], @"z", 
                                        [NSNumber numberWithInt: kEnemyTagValue], @"tag", nil];
    [self.objectQueue addObject: tmpEnemyDictionary];
        
    [enemy release];
}

- (void) createBulletCastWithPosition: (CGPoint) position
                          andCastType: (CastType) cType {
    
    BulletCast *bulletCast = [[BulletCast alloc] initWithLocation: position 
                                                      andCastType: cType];
    bulletCast.gamePlayLayer = self;
    bulletCast.delegate = self;
    
    NSString *displayFrameName;
    float duration;
    
    GameManager *m = [GameManager sharedGameManager];
    NSMutableDictionary *tD = m.selectedHero.talentTree;
    
    switch (cType) {
            
            // FYI: this will never be called from here
        case kCastRage:
            PLAYSOUNDEFFECT(rage_sound);
            displayFrameName = [NSString stringWithFormat: @"rage_effect_1.png"];
            duration = kRageDuration;
            self.powerButtonTimer = kPowerOneDuration;
            break;
            
            // FYI: this will never be called from here
        case kCastOverclock:
            PLAYSOUNDEFFECT(overclock_sound);
            displayFrameName = [NSString stringWithFormat: @"overclock_effect_1.png"];
            duration = kOverclockDuration;
            self.powerButtonTimer = kPowerOneDuration;
            break;
            
            // FYI: this will never be called from here
        case kCastLongshot:
            PLAYSOUNDEFFECT(longshot_sound);
            displayFrameName = [NSString stringWithFormat: @"longshot_effect_1.png"];
            duration = kLongshotDuration;
            self.powerButtonTimer = kPowerTwoDuration;
            break;
            
        case kCastMeditation:
            PLAYSOUNDEFFECT(meditate_cast_sound);
            displayFrameName = [NSString stringWithFormat: @"c3_p3_1.png"];
            duration = kMeditationDuration;
            self.powerButtonTimer = kPowerThreeDuration - ((float)[[tD objectForKey: @"ImprovedMeditation"] intValue]);
            bulletCast.castType = cType;
            bulletCast.zOrder = 9999;
            break;
            
        case kCastSlow:
            PLAYSOUNDEFFECT(slow_cast_sound);
            displayFrameName = [NSString stringWithFormat: @"c3_p2_1.png"];
            duration = kSlowDuration;
            self.powerButtonTimer = kPowerTwoDuration;
            bulletCast.castType = cType;
            bulletCast.zOrder = 9999;
            break;
            
            // currently using the "Meditation" graphic here
            // may want to replace later
        case kCastBlizzard:
            PLAYSOUNDEFFECT(cast_sound);
            displayFrameName = [NSString stringWithFormat: @"c3_p3_1.png"];
            duration = kBlizzardDuration;
            self.powerButtonTimer = kPowerOneDuration - ((float)[[tD objectForKey: @"ImprovedBlizzard"] intValue]);
            bulletCast.castType = cType;
            bulletCast.zOrder = 9999;
            break;
            
        case kCastPoison:
            PLAYSOUNDEFFECT(cast_sound);
            displayFrameName = [NSString stringWithFormat: @"c2_p2_1.png"];
            duration = 0.75f;
            self.powerButtonTimer = kPowerTwoDuration;
            bulletCast.castType = cType;
            bulletCast.zOrder = 9999;
            break;
            
        case kCastSmite:
            PLAYSOUNDEFFECT(cast_sound);
            displayFrameName = [NSString stringWithFormat: @"c2_p3_1.png"];
            duration = kSmiteDuration;
            // self.powerButtonTimer = kPowerThreeDuration - ((float)[[tD objectForKey: @"ImprovedSmite"] intValue]);
            self.powerButtonTimer = kPowerThreeDuration;
            bulletCast.castType = cType;
            bulletCast.zOrder = 9999;
            break;
            
        case kCastMine:
            PLAYSOUNDEFFECT(mine_cast_sound);
            displayFrameName = [NSString stringWithFormat: @"c1_p3_1.png"];
            duration = kMineDuration;
            self.powerButtonTimer = kPowerThreeDuration - kMineEffect*((float)[[tD objectForKey: @"ImprovedMines"] intValue]);
            bulletCast.bulletType = kBulletMine;
            bulletCast.castType = cType;
            bulletCast.mineTimer = kMineDuration;
            bulletCast.isActive = NO;
            bulletCast.zOrder = 0;            
            break;
            
        default:
            CCLOG(@"GPL: unrecognized cType");
            break;
    }
    
    if (cType != kCastMine) {
        id actionFadeOut = [CCFadeOut actionWithDuration: 0.1f*duration];
        id actionRotate = [CCRotateBy actionWithDuration: 0.9f*duration angle: duration*90];
        id actionDelay = [CCDelayTime actionWithDuration: 0.9f*duration];
        id actionSpawn = [CCSpawn actions: actionDelay, actionRotate, nil];
        
        id actionCallFuncN = [CCCallFuncN actionWithTarget: self selector: @selector(queueBulletToDelete:)];
        
        id actionSequence = [CCSequence actions: actionSpawn, actionFadeOut, actionCallFuncN, nil];
        
        [bulletCast runAction: actionSequence];
    } else {
        
        // this is the animation sequence for the mine
        
        id actionAnimate = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: 
                                                               [[CCAnimationCache sharedAnimationCache] 
                                                                animationByName: @"c1_p3_normal_"]]];
        
        /*
        id actionDelay = [CCDelayTime actionWithDuration: duration];
        id actionCallFuncN = [CCCallFuncN actionWithTarget: self selector: @selector(queueBulletToDelete:)];
        
        id actionSequence = [CCSequence actions: actionDelay, actionCallFuncN, nil];
        */
        
        [bulletCast runAction: actionAnimate];
    }
    
    [self.controlsLayer checkToDisablePowers];
    
    bulletCast.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                               spriteFrameByName: displayFrameName];
        
    NSDictionary *tmpBulletDictionary;
    
    NSNumber *zOrder = [NSNumber numberWithInt: bulletCast.zOrder];
    
    // this is to make sure a reference to Meditation is passed onto GPL
    if (cType == kCastMeditation) {
        tmpBulletDictionary = [NSDictionary dictionaryWithObjectsAndKeys: 
                               bulletCast, @"object", zOrder, @"z", 
                               [NSNumber numberWithInt: kBulletMeditationTagValue], @"tag", nil];
    } else {
        tmpBulletDictionary = [NSDictionary dictionaryWithObjectsAndKeys: 
                                bulletCast, @"object", zOrder, @"z", 
                                [NSNumber numberWithInt: kBulletTagValue], @"tag", nil];
    }
    
    
    [self.objectQueue addObject: tmpBulletDictionary];
    
    [bulletCast release];

}

- (void) createBulletType: (BulletType) bulletType 
      withInitialPosition: (CGPoint) initialPosition
        andTargetPosition: (CGPoint) targetPosition 
    andBulletDamageEffect: (float) bEffect 
        andAccuracyEffect: (float) aEffect 
            andCritEffect: (float) cEffect 
        andTowerReference: ref {
        
    Bullet *bullet;
    
    if (bulletType == kBulletStandard) {
        bullet = (BulletStandard *)[[BulletStandard alloc] init];
    } else if (bulletType == kBulletIce) {
        bullet = (BulletIce *)[[BulletIce alloc] init];        
    } else if (bulletType == kBulletBomb) {
        bullet = (BulletBomb *)[[BulletBomb alloc] init];
    }
    
    // set tower reference
    bullet.towerRef = ref;
    Tower *t = (Tower *) bullet.towerRef;
    
    // add bullet to the tower's temporary bullet array
    // this array holds up to 5 bullets at any given time
    if ([t.bulletArray count] < 5) {
        [t.bulletArray insertObject: bullet atIndex: 0];
        
    } else {
        [t.bulletArray removeLastObject];
        [t.bulletArray insertObject: bullet atIndex: 0];
        
    }
        
    // check if meditate effect is active
    if (self.isMeditateActive == YES) {
        
        // if meditate effect is active, check if target position intersects meditation area
        if (CGRectContainsPoint(self.meditationRef.boundingBox, targetPosition)) {
            cEffect += kMeditationEffect;
        }
    }
    
    // whether bullet misses or not
    float r1 = ((float) arc4random()/ (float) ARC4RANDOM_MAX);
    if (r1 > aEffect) {
        bullet.dud = YES;
        float r2 = ((float) arc4random()/ (float) ARC4RANDOM_MAX)*10.0f - 5.0f;
        float r3 = ((float) arc4random()/ (float) ARC4RANDOM_MAX)*10.0f - 5.0f;
        targetPosition = ccp(targetPosition.x + r2, targetPosition.y + r3);
    }
    
    
    bullet.position = initialPosition;
    bullet.delegate = self;
    bullet.target = targetPosition;
    
    float dX = targetPosition.x - initialPosition.x;
    float dY = targetPosition.y - initialPosition.y;
    

    float angleRadians = atanf(dY/dX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    
    if (dX < 0) {
        angleDegrees = angleDegrees + 180.0f;
    }
    
    bullet.rotationAngle = angleDegrees;
    
    // whether bullet "crits" or not
    float r4 = ((float) arc4random()/ (float) ARC4RANDOM_MAX);
    
    if (r4 > cEffect) {
        bullet.bulletDamage = bullet.bulletDamage*(bEffect);
    } else if (r4 <= cEffect) {
        bullet.bulletDamage = bullet.bulletDamage*(bEffect)*(2.0f);
        bullet.critBullet = YES;
    }
    
    NSDictionary *tmpBulletDictionary = [NSDictionary dictionaryWithObjectsAndKeys: 
                                        bullet, @"object", [NSNumber numberWithInt: kBulletZOrder], @"z", 
                                        [NSNumber numberWithInt: kBulletTagValue], @"tag", nil];
    [self.objectQueue addObject: tmpBulletDictionary];
        
    [bullet release];
}

- (void) queueEnemyToDelete: (Enemy *) enemy {
    [self.enemiesToDelete addObject: enemy];
}

- (void) queueBulletToDelete: (Bullet *) bullet {  
    
    if (bullet.bulletType == kBulletCast) {
        
        BulletCast *bc = (BulletCast *) bullet;
        
        if (bc.castType == kCastMeditation) {
            self.isMeditateActive = NO;
            self.meditationRef = nil;
        }
        
    }
    
    [self.bulletsToDelete addObject: bullet];
}

- (void) queueTowerToDelete: (Tower *) tower {
    [self.towersToDelete addObject: tower];
    [self.towerDelegateCollection removeObject: tower];
}

- (void) showTextLabel: (NSString *) stringToShow 
      andLabelPosition: (CGPoint) labelPosition 
              andScale: (float) scaleValue
         andTimePeriod: (float) timePeriod
              andColor: (ccColor3B) colorToUse {
    
    CCLabelBMFont *textLabel = [CCLabelBMFont labelWithString: stringToShow fntFile: @"MushroomText.fnt"];
    textLabel.position = labelPosition;
    textLabel.scale = scaleValue;
    textLabel.color = colorToUse;
    textLabel.zOrder = 9999;
        
    //id actionDelay = [CCDelayTime actionWithDuration: 0.9*timePeriod];
    id actionFadeOut = [CCFadeOut actionWithDuration: timePeriod];
    id actionCall = [CCCallFuncN actionWithTarget: self selector: @selector(removeTextLabel:)];
    id actionSequence = [CCSequence actions: actionFadeOut, actionCall, nil];
    
    [self addChild: textLabel];
    
    [textLabel runAction: actionSequence];
}

- (void) showDamageText: (int) damageTaken 
       andLabelPosition: (CGPoint) labelPosition
          andCritBullet: (BOOL) critBullet 
               andColor: (ccColor3B) c {

    NSString *stringLabel = [NSString stringWithFormat: @"%d", damageTaken];
     
    CCLabelBMFont *damageText = [CCLabelBMFont labelWithString: stringLabel 
                                                       fntFile: @"MushroomTextSmall.fnt"];
    
    int randomX = (arc4random() % 17) - 8;
    
    damageText.position = ccp(labelPosition.x + randomX, labelPosition.y);
    damageText.zOrder = 9999;
    
    // THIS SHOULD BE PUT INTO THE SPRITE BATCH NODE -- unfortunately, this isn't possible
    [self addChild: damageText];
    
    if (critBullet) {
        id actionUp = [CCMoveBy actionWithDuration: 1.0f position: ccp(0,25)];
        id actionFadeOut = [CCFadeOut actionWithDuration: 1.0f];
        
        id actionScaleUp = [CCScaleTo actionWithDuration: 0.1f scale: 2.0f];
        id actionScaleDown = [CCScaleTo actionWithDuration: 0.5f scale: 1.0f];
        id actionScaleSequence = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
        
        id actionSpawn = [CCSpawn actions: actionUp, actionFadeOut, actionScaleSequence, nil];
        id actionCall = [CCCallFuncN actionWithTarget: self selector: @selector(removeTextLabel:)];
        id actionSequence = [CCSequence actions: actionSpawn, actionCall, nil];
        
        damageText.color = ccYELLOW;
        
        [damageText runAction: actionSequence];
        
    } else {
        id actionUp = [CCMoveBy actionWithDuration: 1.0f position: ccp(0,25)];
        id actionFadeOut = [CCFadeOut actionWithDuration: 1.0f];
        id actionCall = [CCCallFuncN actionWithTarget: self selector: @selector(removeTextLabel:)];
        id actionSpawn = [CCSpawn actions: actionUp, actionFadeOut, nil];
        id actionSequence = [CCSequence actions: actionSpawn, actionCall, nil];
        
        damageText.color = c;
        
        [damageText runAction: actionSequence];
    }
    
}

- (void) removeTextLabel: (CCLabelBMFont *) label {
    [label removeFromParentAndCleanup: YES];
}

- (void) removeBulletCast: (BulletCast *) bCast {
    [bCast removeFromParentAndCleanup: YES];
}

- (void) update: (ccTime) deltaTime
{   
    
    // intro delay of 1.0 seconds
    if (self.introDelay > 0.0f) {
        self.introDelay -= deltaTime;
        return;
    }
    
    // show intro if this is a new player
    GameManager *m = [GameManager sharedGameManager];
    if (m.selectedHero.introSeen == NO) {
        m.selectedHero.introSeen = YES;
        
        // signal game scene
        [self.gs1_reference showIntro];
    }
        
    // updating the power button timer when needed
    [self updateTimer: &powerButtonTimer 
        withDeltaTime: deltaTime];
    
    /*
    // this is unnecessary code that needs to be deleted eventually
    if (initializeTalentButtonPriority == NO) {
        initializeTalentButtonPriority = YES;
        
        [[[CCDirector sharedDirector] touchDispatcher] setPriority: 8888 
                                                       forDelegate: self.controlsLayer.talentButtonMenu];
    }
    */
    
    // self.countdownTimer = -1.0f;
        
    // this is the countdown timer
    if (self.countdownTimer >= 0) {
        
        CCLabelBMFont *labelCount;
        
        if (self.countdownTimer > 181) {
            
            if (self.countdownTimer == 300) {
                NSString *countString = [NSString stringWithFormat: @"Get Ready"];
                
                labelCount = [CCLabelBMFont labelWithString: countString
                                                    fntFile: @"MushroomText.fnt"];

                id actionFadeOut = [CCFadeOut actionWithDuration: 2.0f];
                id actionCall = [CCCallFuncN actionWithTarget: self selector: @selector(removeTextLabel:)];
                id actionSequence = [CCSequence actions: actionFadeOut, actionCall, nil];
                [self addChild: labelCount];
                [labelCount runAction: actionSequence];
                
                labelCount.zOrder = 9999;
                labelCount.position = ccp(screenSize.width/2, screenSize.height/2);
            }
            
            self.countdownTimer = self.countdownTimer - 1;
            
        } else {
            if (self.countdownTimer % 60 == 0) {
                
                int count = self.countdownTimer/60;
                
                CCLabelBMFont *labelCount;
                
                if (self.countdownTimer == 0) {
                    
                    PLAYSOUNDEFFECT(countdown_round_sound);
                                        
                    NSString *roundString = [NSString stringWithFormat: @"Round 1"];
                    [self showTextLabel: roundString
                           andLabelPosition: ccp(screenSize.width/2, screenSize.height/2)
                                   andScale: 0.7f
                              andTimePeriod: 1.5f
                                   andColor: ccWHITE];
                    
                } else {
                    
                    PLAYSOUNDEFFECT(countdown_timer_sound);
                    
                    NSString *countString = [NSString stringWithFormat: @"%d", count];
                    
                    labelCount = [CCLabelBMFont labelWithString: countString
                                                        fntFile: @"MushroomText.fnt"];
                    
                    id actionScaleDown = [CCScaleTo actionWithDuration: 0.9f scale: 0.1f];
                    id actionFadeOut = [CCFadeOut actionWithDuration: 0.9f];
                    id actionSpawn = [CCSpawn actions: actionScaleDown, actionFadeOut, nil];
                    id actionCall = [CCCallFuncN actionWithTarget: self selector: @selector(removeTextLabel:)];
                    id actionSequence = [CCSequence actions: actionSpawn, actionCall, nil];
                    [self addChild: labelCount];
                    [labelCount runAction: actionSequence];
                    
                    labelCount.scale = 2.0f;
                    labelCount.zOrder = 9999;
                    labelCount.position = ccp(screenSize.width/2, screenSize.height/2);
                }
                
            }
            self.countdownTimer = self.countdownTimer - 1;
        }
        
        // this is where the ENEMY GENERATOR is updated
    } else {
        
        [self.enemyGenerator updateGenerator: deltaTime];
    }
    
    // adding effects that were queued
    for (CCNode *effects in self.effectsQueue) {
        
        [gs1SpriteBatchNode addChild: effects];
        effects.tag = kEffectsTagValue;
    }
    [self.effectsQueue removeAllObjects];
    
    // adding objects that were queued to be added
    for (NSDictionary *tmpDictionary in self.objectQueue) {
        id object = [tmpDictionary objectForKey: @"object"];
        int zValue = [[tmpDictionary objectForKey: @"z"] intValue];
        int tagValue = [[tmpDictionary objectForKey: @"tag"] intValue];
        
        // this is meant to obtain a reference to the meditation sprite
        if (tagValue == kBulletMeditationTagValue) {
            tagValue = kBulletTagValue;
            
            // get the reference for meditation
            self.meditationRef = object;
            self.isMeditateActive = YES;
        }
        
        [gs1SpriteBatchNode addChild: object 
                                   z: zValue 
                                 tag: tagValue];
    }
    [self.objectQueue removeAllObjects];
    
    // only "updating" non-effect objects
    NSMutableArray *gcObjects = [NSMutableArray array];
    
    for (id object in [gs1SpriteBatchNode children]) {
        
        CCNode *tmpNode = (CCNode *) object;
        
        if (tmpNode.tag != kEffectsTagValue) {
            [gcObjects addObject: object];
        }
    }
    
    CCArray *listOfGameObjects = [CCArray arrayWithNSArray: gcObjects];
    
    for (GameCharacter *gameCharacter in listOfGameObjects) {
        [gameCharacter updateStateWithDeltaTime: deltaTime
                           andListOfGameObjects: listOfGameObjects];
    }
        
    // removing effects that were queued to be deleted
    for (CCSprite *effects in self.effectsToDelete) {
        [effects removeFromParentAndCleanup: YES];
    }
    [self.effectsToDelete removeAllObjects];
    
    // removing enemies that were queued to be deleted
    for (Enemy *e in self.enemiesToDelete) {
        [enemyCollection removeObject: e];
        [e removeFromParentAndCleanup: YES];
    }
    [self.enemiesToDelete removeAllObjects];
    
    // removing bullets that were queued to be deleted
    for (Bullet *b in self.bulletsToDelete) {        
        [b removeFromParentAndCleanup: YES];
    }
    [self.bulletsToDelete removeAllObjects];
    
    // removing towers that were queued to be deleted
    for (Tower *t in self.towersToDelete) {
        [towerDelegateCollection removeObject: t.tDelegate];
        [t removeFromParentAndCleanup: YES];
    }
    [self.towersToDelete removeAllObjects];
    
} // update:

- (CGPoint) positionForTileCoord: (CGPoint) tileCoord withTileSize: (int) tS {
    
    CGSize tileSize;
    tileSize.width = tS;
    tileSize.height = tS;
    
    CGSize mapSize;
    mapSize.width = 960/tileSize.width;
    mapSize.height = 640/tileSize.height;

    float positionX = (tileSize.width/2)*tileCoord.x + ((tileSize.width/2)/2);
    float positionY = (mapSize.height*(tileSize.height/2)) - (tileSize.height/2)*tileCoord.y - ((tileSize.height/2)/2);
    
    return ccp(positionX,positionY);
}

- (void) initTowerPlacementPoints {
    
    GameManager *m = [GameManager sharedGameManager];
    
    NSDictionary *levelDictionary = [NSDictionary dictionaryWithDictionary: [m getInformationForLevel: m.selectedLevel]];
    
    // extract placement points from levelArray; currently, this is an array of NSString's
    NSArray *tmpPlacementStrings = [levelDictionary valueForKey: @"Tower Placement Points"];
    
    // obtain an array of NSValues from tmpPlacementStrings
    NSArray *tmpPlacementPoints = [NSArray arrayWithArray: [m getPointArrayFromStringArray: tmpPlacementStrings]];
    
    for (NSValue *v in tmpPlacementPoints) {
        
        // get the CGPoint from the array
        CGPoint tileCoord = [v CGPointValue];
        
        // get the correct openGL coordinates
        CGPoint pointCoord = [self positionForTileCoord: tileCoord withTileSize: 8];
        
        // create the sprite at that position
        TowerPlacement *s = [TowerPlacement node];
        s.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                          spriteFrameByName: @"tower_placement_1.png"];
        s.position = pointCoord;
        
        // set sprite visibility to NO, and zOrder to low
        // also, tag as "effect" so it doesn't get affected by the update loop
        s.scale = 0.8f;
        s.visible = NO;
        s.zOrder = -9999;
        s.tag = kEffectsTagValue;
        
        // animate the sprite
        id actionRotate = [CCRotateBy actionWithDuration: 2.0f angle: 360];
        
        id actionScaleUp1 = [CCScaleTo actionWithDuration: 0.4f scale: 0.9f];
        id actionScaleDown1 = [CCScaleTo actionWithDuration: 0.6f scale: 0.8f];
        id actionScaleUp2 = [CCScaleTo actionWithDuration: 0.4f scale: 0.9f];
        id actionScaleDown2 = [CCScaleTo actionWithDuration: 0.6f scale: 0.8f];
        id actionSequence = [CCSequence actions: actionScaleUp1, actionScaleDown1, actionScaleUp2, actionScaleDown2, nil];
        
        id actionSpawn = [CCSpawn actions: actionRotate, actionSequence, nil];
                
        id actionForever = [CCRepeatForever actionWithAction: actionSpawn];
        [s runAction: actionForever];
        
        // add sprite to array
        [self.towerPlacementSprites addObject: s];
        
        // add sprite to the sprite batch node
        [self.gs1SpriteBatchNode addChild: s];
    }
    
}

- (void) nextRoundLabel: (CCLabelBMFont *) label withString: (NSString *) textString {
    
    label.string = textString;
    
}


- (id) initWithLayer: (BackgroundLayer *) bg {
    if (self = [super init]) {
        
        self.backgroundLayer = bg;
        
        self.introDelay = 0.75f;

        self.effectsQueue = [NSMutableArray array];
        self.objectQueue = [NSMutableArray array];
        self.effectsToDelete = [NSMutableArray array];
        self.enemiesToDelete = [NSMutableArray array];
        self.bulletsToDelete = [NSMutableArray array];
        self.towersToDelete = [NSMutableArray array];
        self.towerDelegateCollection = [NSMutableArray array];
        self.enemyCollection = [NSMutableArray array];
        self.towerPlacementSprites = [NSMutableArray array];
                        
        self.screenSize = [[CCDirector sharedDirector] winSize];
        self.enemySpawnTimer = 0.0f;
        self.countdownTimer = 300;
        
        self.powerButtonTimer = -1.0f;
                                
        // creating CCSpriteBatchNode for this layer
        self.gs1SpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile: @"gs1atlas.png"];
        
        [self initTowerPlacementPoints];
                                
        [self addChild: gs1SpriteBatchNode
                     z: 0
                   tag: 0];

        initializeTalentButtonPriority = NO;
        
        self.enemyGenerator = [EnemyGenerator createGenerator];
        self.enemyGenerator.delegate = self;
        
        self.isMeditateActive = NO;
        
        [self scheduleUpdate];
    }
    
    return self;
}



@end
























