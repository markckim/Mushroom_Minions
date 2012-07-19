//
//  Enemy.m
//  
//
//  Created by Mark Kim on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Bullet.h"
#import "BulletCast.h"
#import "BackgroundLayer.h"
#import "BulletStandard.h"
#import "Tower.h"

@implementation Enemy

@synthesize backgroundLayer;
@synthesize delegate;
@synthesize path;

@synthesize velocityEffect;
@synthesize currentDestination;
@synthesize health;
@synthesize normalHealth;
@synthesize armorValue;
@synthesize enemyType;
@synthesize frozenEffectTimer;
@synthesize bombEffectTimer;

@synthesize deltaX;
@synthesize deltaY;
@synthesize distanceToDestination;
@synthesize towerIceExplosionSprite;
@synthesize healthbar;
@synthesize healthbarBack;
@synthesize towerIceExplosionActive;
@synthesize directionState;

@synthesize coinValue;
@synthesize enemyStatusEffectSprite;
@synthesize poisonEffectTimer;
@synthesize poisonCounter;
@synthesize smiteEffectTimer;
@synthesize slowEffectTimer;
@synthesize slowEffect;

- (void) dealloc {
        
    self.delegate = nil;
    self.backgroundLayer = nil;
    self.path = nil;
    self.towerIceExplosionSprite = nil;
    self.healthbar = nil;
    self.healthbarBack = nil;
    self.enemyStatusEffectSprite = nil;
    
    [super dealloc];
}

- (void) changeDirectionState: (DirectionState) dState {
    CCLOG(@"this method should be overridden");
    
    self.directionState = dState;
}

- (int) takeDamage: (float) baseDamage {    
    
    // THIS IS WHERE ARMOR PIERCING AFFECTS THE GAME
    GameManager *m = [GameManager sharedGameManager];
    NSMutableDictionary *tD = m.selectedHero.talentTree;
    
    // calculate armor piercing effect
    // this is a number from 0 to 5
    int armorPiercingTalent = [[tD objectForKey: @"ArmorPiercing"] intValue];
    int armorPiercingEffect = 0;
    
    if (m.selectedHero.characterID == 1) {
        
        // calculate random number
        int randomInt = (arc4random() % 10) + 1; // random integer from 1 through 10
        
        
        if  (randomInt <= armorPiercingTalent) {
            armorPiercingEffect = 10;
        }
    }
    
    int actualArmorValue = fmax(0, self.armorValue - armorPiercingEffect);
    float actualDamageTaken = fmax(0, baseDamage - actualArmorValue);
    
    int roundedActualDamageTaken = (int) (actualDamageTaken + 0.5);
    
    self.health = self.health - roundedActualDamageTaken;
    
    // scale health bar
    float healthbarScaling = fmax(0.0f,self.health/self.normalHealth);
    self.healthbar.scaleX = healthbarScaling;
    
    return roundedActualDamageTaken;
}

- (void) checkForStateChange {
    
    if ([self state] == kStateDead) {
        return;
    }
    
    CharacterState newState;
    
    GameManager *m = [GameManager sharedGameManager];
    NSMutableDictionary *tD = m.selectedHero.talentTree;
    
    if (bombEffectTimer > 0.0f) {
        newState = kStateOnFire;
        self.velocityEffect = kVelocityEffectOnFire;
    } else if (frozenEffectTimer > 0.0f) {
        newState = kStateFrozen;
        self.velocityEffect = kVelocityEffectFrozen -  kDeepFreezeEffect*((float) [[tD objectForKey: @"DeepFreeze"] intValue]);
    } else {
        newState = kStateNormal;
        self.velocityEffect = 1.0f;
    }
    
    if (self.state != newState) {
        
        [self changeState: newState];
    }
    
    DirectionState newDirectionState;
    
    float angleRadians = atanf(deltaY/deltaX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    
    if (deltaX >= 0) {
        if (angleDegrees >= -22.5f && angleDegrees < 22.5f) {
            newDirectionState = kEast;
        } else if (angleDegrees >= 22.5f && angleDegrees < 67.5f) {
            newDirectionState = kNorthEast;
        } else if (angleDegrees >= -67.5f && angleDegrees < -22.5f) {
            newDirectionState = kSouthEast;
        } else if (angleDegrees >= -90.0f && angleDegrees < -67.5f) {
            newDirectionState = kSouth;
        } else if (angleDegrees >= 67.5 && angleDegrees < 90.0f) {
            newDirectionState = kNorth;
        }
    } else if (deltaX < 0) {
        angleDegrees = angleDegrees + 180.0f;
        
        if (angleDegrees >= 90.0f && angleDegrees < 112.5f) {
            newDirectionState = kNorth;
        } else if (angleDegrees >= 112.5f && angleDegrees < 157.5f) {
            newDirectionState = kNorthWest;
        } else if (angleDegrees >= 157.5f && angleDegrees < 202.5f) {
            newDirectionState = kWest;
        } else if (angleDegrees >= 202.5f && angleDegrees < 247.5f) {
            newDirectionState = kSouthWest;
        } else if (angleDegrees >= 247.5f && angleDegrees < 270.0f) {
            newDirectionState = kSouth;
        }
    }
    
    if (self.directionState != newDirectionState) {
        [self changeDirectionState: newDirectionState];
    }
}

- (void) towerIceExplosionEffect {
        
    [self.towerIceExplosionSprite stopAllActions];
        
    if (self.towerIceExplosionActive == NO) {
        self.towerIceExplosionActive = YES;
        
        self.towerIceExplosionSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                                     spriteFrameByName: @"towerice_explosion_1.png"];
        [self.delegate createEffect: self.towerIceExplosionSprite];
    }
    
    if (self.towerIceExplosionSprite.visible == NO) {
        self.towerIceExplosionSprite.visible = YES;
    }
    
    self.towerIceExplosionSprite.zOrder = self.zOrder + 10;
    
    id action = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                 animationByName: @"towerIceExplosionAnim"]];
    [self.towerIceExplosionSprite runAction: action];
    self.towerIceExplosionSprite.position = self.position;
}

- (void) activateEnemyStatusEffect: (CastType) cType {
    
    if (self.enemyStatusEffectSprite == nil) {
        
        self.enemyStatusEffectSprite = [CCSprite node];
        self.enemyStatusEffectSprite.zOrder = self.zOrder;
        self.enemyStatusEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                     spriteFrameByName: @"poisons_effect_1.png"];
        
        float offsetY = self.contentSize.height/2;
        self.enemyStatusEffectSprite.position = ccp(self.position.x, self.position.y + offsetY);
        
        [self.delegate createEffect: self.enemyStatusEffectSprite];
    }
        
    [self.enemyStatusEffectSprite stopAllActions];
        
    self.enemyStatusEffectSprite.scale = 1.0f;
    self.enemyStatusEffectSprite.opacity = 255;
    float statusDuration;
    
    id action1;
    id actionFadeTo = [CCFadeTo actionWithDuration: 1.0f opacity: 0];
    
    switch (cType) {
            
        case kCastPoison:
            
            PLAYSOUNDEFFECT(poison_sound);
                        
            self.enemyStatusEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                         spriteFrameByName: @"poisons_effect_1.png"];
            self.enemyStatusEffectSprite.scale = 0.85f;
            statusDuration = 5.0f*kPoisonDuration;
            self.poisonEffectTimer = 2.0f; // every 2 seconds
            
            self.enemyStatusEffectSprite.rotation = 0;
            
            id actionScaleUp = [CCScaleTo actionWithDuration: 0.25f scale: 1.1f];
            id actionScaleDown = [CCScaleTo actionWithDuration: 0.25f scale: 0.9f];
            id actionSeq = [CCSequence actions: actionScaleUp, actionScaleDown, nil];
            id actionRepeat = [CCRepeat actionWithAction: actionSeq times: 2.0f*(statusDuration-1.0f)];
            
            action1 = actionRepeat;            
            break;
            
        case kCastSlow:
            
            PLAYSOUNDEFFECT(slow_status_sound);
            
            self.enemyStatusEffectSprite.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                                         spriteFrameByName: @"slow_effect_1.png"];
            self.enemyStatusEffectSprite.scale = 0.85f;
            statusDuration = kSlowStatusDuration;
            self.slowEffectTimer = kSlowStatusDuration;
            
            self.enemyStatusEffectSprite.rotation = 0;
            
            id actionScaleUp2 = [CCScaleTo actionWithDuration: 0.25f scale: 1.1f];
            id actionScaleDown2 = [CCScaleTo actionWithDuration: 0.25f scale: 0.9f];
            id actionSeq2 = [CCSequence actions: actionScaleUp2, actionScaleDown2, nil];
            id actionRepeat2 = [CCRepeat actionWithAction: actionSeq2 times: 2.0f*(statusDuration-1.0f)];
            
            action1 = actionRepeat2;
            break;
                        
        default:
            CCLOG(@"Enemy: unrecognized status effect");
            break;
    }
    
    id actionSequence = [CCSequence actions: action1, actionFadeTo, nil];
    
    [self.enemyStatusEffectSprite runAction: actionSequence];
}


- (void) deletingSelf {
    
    if (self.towerIceExplosionActive == YES) {
        
        [self.towerIceExplosionSprite stopAllActions];
        [self.delegate queueEffectToDelete: self.towerIceExplosionSprite];
    }
    
    if (self.enemyStatusEffectSprite != nil) {
        
        [self.enemyStatusEffectSprite stopAllActions];
        [self.delegate queueEffectToDelete: self.enemyStatusEffectSprite];
    }
    
    [self.delegate queueEffectToDelete: self.healthbar];
    [self.delegate queueEffectToDelete: self.healthbarBack];
    
    [self.delegate queueEnemyToDelete: self];
}

- (void) updateTimer: (float *) timerPointer 
       withDeltaTime: (ccTime) deltaTime {
    
    if (*timerPointer < 0.0f) {
        return;
    }
    
    *timerPointer = *timerPointer - deltaTime;
    
    if (*timerPointer < 0.0f) {
        
        if (timerPointer == &poisonEffectTimer) {
            
            if (poisonCounter < 4) {
                poisonCounter += 1;
                                
                *timerPointer = kPoisonDuration;
                
                GameManager *m = [GameManager sharedGameManager];
                NSMutableDictionary *tD = m.selectedHero.talentTree;
                float talentPoisonDamage = (float) [[tD objectForKey: @"ImprovedPoison"] intValue];
                
                [self takePoisonDamage: kBasePoisonDamage + talentPoisonDamage];
               
            } else {
                *timerPointer = -1.0f;
            }
            
        } else {
            
            // reset slow effect
            if (timerPointer == &slowEffectTimer) {
                
                self.slowEffect = 1.0f;
                
            }
            
            *timerPointer = -1.0f;
        }        
    }
    
    
}

- (void) takePoisonDamage: (float) poisonDamage {
    
    
    PLAYSOUNDEFFECT(poison_sound);
    
    self.health -= poisonDamage;
    CGPoint labelPosition = ccp(self.position.x, 
                                self.position.y + 0.9*self.contentSize.height/2);
    
    [self.delegate showDamageText: poisonDamage 
                 andLabelPosition: labelPosition
                    andCritBullet: NO
                         andColor: ccMAGENTA];
    
    // scale health bar
    float healthbarScaling = fmax(0.0f,self.health/self.normalHealth);
    self.healthbar.scaleX = healthbarScaling;
    
    if ([self health] <= 0) {
        PLAYSOUNDEFFECT(coin_sound);
        PLAYSOUNDEFFECT(death_sound);
        
        [self.enemyStatusEffectSprite stopAllActions];
        self.enemyStatusEffectSprite.visible = NO;
        
        [self changeState: kStateDead];
        self.healthbar.visible = NO;
        self.healthbarBack.visible = NO;
        [[GameManager sharedGameManager] enemyKilled];
        [self.delegate receiveCoins: self.coinValue];
        return;
    }
}

- (void) updateStateWithDeltaTime: (ccTime) deltaTime 
             andListOfGameObjects: (CCArray *) listOfGameObjects
{   
    
    if (self.healthbarBack == nil) {
        self.healthbarBack = [CCSprite node];
        self.healthbarBack.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                           spriteFrameByName: @"enemy_healthbar_back_1.png"];
        [self.delegate createEffect: self.healthbarBack];
        self.healthbarBack.anchorPoint = ccp(0,0.5);
    }
    
    if (self.healthbar == nil) {        
        self.healthbar = [CCSprite node];
        self.healthbar.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                       spriteFrameByName: @"enemy_healthbar_1.png"];
        [self.delegate createEffect: self.healthbar];
        self.healthbar.anchorPoint = ccp(0,0.5);
    }
    
    CGPoint uiPosition = [[CCDirector sharedDirector] convertToUI: self.position];
    self.zOrder = uiPosition.y;
    self.healthbar.zOrder = uiPosition.y;
    
    if ([self.towerIceExplosionSprite numberOfRunningActions] == 0) {
        self.towerIceExplosionSprite.visible = NO;
    }
    
    if ([self state] == kStateDead) {
        if ([self numberOfRunningActions] == 0) {
            [self deletingSelf];            
            return;
        } else if ([self numberOfRunningActions] > 0) {
            return;
        }
    }
    
    deltaX = self.currentDestination.x - self.position.x;
    deltaY = self.currentDestination.y - self.position.y;
    distanceToDestination = sqrt(pow(deltaX,2) + pow(deltaY,2));
    
    if (distanceToDestination < 3) {
        
        if ([self.path.selectedPath count] == 1) {
            self.isActive = NO;
            [[GameManager sharedGameManager] lifeLost];
            [self deletingSelf];
            return;
        }
        self.currentDestination = [self.path nextPoint];
        deltaX = self.currentDestination.x - self.position.x;
        deltaY = self.currentDestination.y - self.position.y;
        distanceToDestination = sqrt(pow(deltaX,2) + pow(deltaY,2));
    }
    
    [self checkForStateChange];
    
    [self updateTimer: &frozenEffectTimer 
        withDeltaTime: deltaTime];
    
    [self updateTimer: &bombEffectTimer 
        withDeltaTime: deltaTime];
    
    [self updateTimer: &poisonEffectTimer
        withDeltaTime: deltaTime];
    
    [self updateTimer: &smiteEffectTimer
        withDeltaTime: deltaTime]; 
    
    [self updateTimer: &slowEffectTimer
        withDeltaTime: deltaTime];
    
        
    // detects bullet collisions and enemy takes damage; bullet is taken out of play        
    for (GameCharacter *object in listOfGameObjects) {
        if (CGRectIntersectsRect([self boundingBox],[object boundingBox])) {
            
            if (object.tag == kBulletTagValue && object.isActive == YES) {
                Bullet *b = (Bullet *) object;
                
                
                // THIS IS WHERE I SHOULD HANDLE ALL THE BULLET CASTS (except Mine -- )
                // note: Mine bulletType is kBulletMine -- not kBulletCast
                if (b.bulletType == kBulletCast) {
                    
                    BulletCast *bCast = (BulletCast *) b;
                    
                    if (bCast.castType == kCastBlizzard) {
                        
                        if (self.enemyType != kEnemyPhib) {
                            PLAYSOUNDEFFECT(freeze_status_sound);
                            PLAYSOUNDEFFECT(bulletice_explosion_sound);
                            frozenEffectTimer = kFrozenEffectTimer;
                            [self towerIceExplosionEffect];
                            
                        }
                        
                    } else if (bCast.castType == kCastPoison) {
                        
                        if (poisonEffectTimer == -1.0f) {       
                            
                            self.poisonCounter = 0;
                            self.poisonEffectTimer = kPoisonDuration;
                            
                            [self activateEnemyStatusEffect: kCastPoison];
                            
                            GameManager *m = [GameManager sharedGameManager];
                            NSMutableDictionary *tD = m.selectedHero.talentTree;
                            float talentPoisonDamage = (float) [[tD objectForKey: @"ImprovedPoison"] intValue];
                            
                            [self takePoisonDamage: kBasePoisonDamage + talentPoisonDamage];
                                                        
                        }                        
                    } else if (bCast.castType == kCastSmite) {
                        
                        // this is only to prevent this enemy from taking damage from smite again
                        // for a temporary period
                        // therefore, enemy takes damage from smite only once during the duration of that spell cast
                        if (smiteEffectTimer == -1.0f) {
                            
                            self.smiteEffectTimer = 2.0f;
                            
                            PLAYSOUNDEFFECT(onfire_status_sound);
                            bombEffectTimer = kBombEffectTimer;
                            
                            GameManager *m = [GameManager sharedGameManager];
                            NSMutableDictionary *tD = m.selectedHero.talentTree;
                            float focusedFireTalents = (float) [[tD objectForKey: @"FocusedFire"] intValue];
                            float improvedSmiteTalents = (float) [[tD objectForKey: @"ImprovedSmite"] intValue];
                            
                            float focusedFireCritEffect = kFocusedFireEffect*focusedFireTalents;
                            float improvedSmiteEffect = kImprovedSmiteEffect*improvedSmiteTalents;
                                                        
                            float r4 = ((float) arc4random()/ (float) ARC4RANDOM_MAX);
                            
                            float damageToTake;
                            BOOL spellCrit;
                            
                            // check if spell should crit
                            
                            if (r4 > focusedFireCritEffect) {
                                damageToTake = (kBaseSmiteDamage + improvedSmiteEffect*kBaseSmiteDamage);
                                spellCrit = NO;
                            } else if (r4 <= focusedFireCritEffect) {
                                damageToTake = (kBaseSmiteDamage + improvedSmiteEffect*kBaseSmiteDamage)*2.0f;
                                spellCrit = YES;
                            }
                            
                            int damageTaken = [self takeDamage: damageToTake];
                            
                            if (damageTaken > 0) {
                                
                                if (spellCrit == YES) {
                                    PLAYSOUNDEFFECT(crit_hit_sound);
                                } else {                            
                                    PLAYSOUNDEFFECT(regular_hit_sound);
                                }
                                
                                CGPoint labelPosition = ccp(self.position.x, 
                                                            self.position.y + 0.9*self.contentSize.height/2);
                                [self.delegate showDamageText: damageTaken 
                                             andLabelPosition: labelPosition
                                                andCritBullet: spellCrit
                                                     andColor: ccWHITE];
                            }
                            
                            if ([self health] <= 0) {
                                PLAYSOUNDEFFECT(coin_sound);
                                PLAYSOUNDEFFECT(death_sound);
                                
                                [self changeState: kStateDead];
                                self.healthbar.visible = NO;
                                self.healthbarBack.visible = NO;
                                
                                self.enemyStatusEffectSprite.visible = NO;
                                
                                if (self.enemyStatusEffectSprite != nil) {
                                    [self.enemyStatusEffectSprite stopAllActions];
                                    self.enemyStatusEffectSprite.visible = NO;
                                }
                                [[GameManager sharedGameManager] enemyKilled];
                                [self.delegate receiveCoins: self.coinValue];
                                return;
                            }
                            
                        }
                        
                    } else if (bCast.castType == kCastSlow) {
                        
                        if (slowEffectTimer == -1.0f) {
                            
                            self.slowEffectTimer = kSlowStatusDuration;
                            
                            GameManager *m = [GameManager sharedGameManager];
                            NSMutableDictionary *tD = m.selectedHero.talentTree;
                            float slowEffectTalents = (float) [[tD objectForKey: @"ImprovedSlow"] intValue];
                            float additionalSlowEffectToAdd = kSlowEffect*slowEffectTalents;
                            
                            self.slowEffect = kBaseVelocityEffectSlow - additionalSlowEffectToAdd;
                            
                            [self activateEnemyStatusEffect: kCastSlow];
                        }
                    }
                                        
                } else if (b.dud != YES) {
                    
                    if (b.bulletType != kBulletBomb && b.bulletType != kBulletMine) {
                        [b changeState: kStateDead];
                    }
                    
                    int damageTaken = [self takeDamage: b.bulletDamage];
                                        
                    if (damageTaken > 0) {
                        
                        if (b.critBullet == YES) {
                            PLAYSOUNDEFFECT(crit_hit_sound);
                            
                            if (b.bulletType == kBulletStandard) {
                                /*
                                id actionAnim = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                                                 animationByName: @"towerStandardBulletCritAnim"]];
                                */
                                
                                b.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] 
                                                  spriteFrameByName: @"bulletstandard_impact_ae_4.png"];
                                b.zOrder = 9999;
                                
                                id actionScaleUp = [CCScaleTo actionWithDuration: 0.3f scale: 2.0f];
                                id actionFadeOut = [CCFadeOut actionWithDuration: 0.5f];
                                id actionSpawn = [CCSpawn actions: actionScaleUp, actionFadeOut, nil];
                                
                                b.rotation = -b.rotationAngle;
                                [b runAction: actionSpawn];
                            }
                                                                                    
                            // activate proc effect on the bullet's tower, if hero has the proc static power
                            if ([GameManager sharedGameManager].proc_static_power == YES) {
                                if (b.towerRef != nil) {
                                    
                                    // note: this crashes if you remove the tower at this moment
                                    [b.towerRef activateProcEffect];
                                }
                                
                            }
                            
                        } else {
                            
                            // choose the right regular hit sound to play
                            if (self.enemyType == kEnemyMinion) {
                                
                                int randIntMinion = arc4random() % 2;
                                
                                if (randIntMinion == 0) {
                                    PLAYSOUNDEFFECT(sword_hit_sound);
                                } else {
                                    PLAYSOUNDEFFECT(sword_hit_sound_2);
                                }                                
                            } else if (self.enemyType == kEnemyCritling || self.enemyType == kEnemyPinki || self.enemyType == kEnemyTarling) {
                                PLAYSOUNDEFFECT(regular_hit_sound_4);
                            } else {
                                int randInt = (arc4random() % 2) + 1; // random integer between 1 to 3
                                
                                if (randInt == 1) {
                                    PLAYSOUNDEFFECT(regular_hit_sound);
                                } else if (randInt == 2) {
                                    PLAYSOUNDEFFECT(regular_hit_sound_2);
                                }
                            }
                            
                            if (b.bulletType == kBulletStandard) {
                                
                                id actionAnim = [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] 
                                                                                 animationByName: @"towerStandardBulletImpactAnim"]];
                                id actionFadeOut = [CCFadeTo actionWithDuration: 0.01f opacity: 0];
                                id actionDelay = [CCDelayTime actionWithDuration: 0.5f];
                                
                                id actionSequence = [CCSequence actions: actionAnim, actionFadeOut, actionDelay, nil];
                                
                                b.rotation = -b.rotationAngle;
                                
                                // add a bit of noise to the bullet impact animation scale
                                float impactNoise = (((float) arc4random()/ (float) ARC4RANDOM_MAX) - 0.5f)*2.0f*0.2f; // -0.2 through 0.2 scale
                                
                                b.scale = 1.4f + impactNoise;
                                [b runAction: actionSequence];
                            }
                        }
                        
                        
                        CGPoint labelPosition = ccp(self.position.x, 
                                                    self.position.y + 0.9*self.contentSize.height/2);
                        [self.delegate showDamageText: damageTaken 
                                     andLabelPosition: labelPosition
                                        andCritBullet: b.critBullet
                                             andColor: ccWHITE];
                    }
                                        
                    if ([self health] <= 0) {
                        PLAYSOUNDEFFECT(coin_sound);
                        PLAYSOUNDEFFECT(death_sound);
                        
                        [self changeState: kStateDead];
                        self.healthbar.visible = NO;
                        self.healthbarBack.visible = NO;
                        
                        if (self.enemyStatusEffectSprite != nil) {
                            [self.enemyStatusEffectSprite stopAllActions];
                            self.enemyStatusEffectSprite.visible = NO;
                        }
                        
                        [[GameManager sharedGameManager] enemyKilled];
                        [self.delegate receiveCoins: self.coinValue];
                        return;
                    }
                    
                    if ([b bulletType] == kBulletIce) {
                        
                        if (self.enemyType != kEnemyPhib) {
                            PLAYSOUNDEFFECT(freeze_status_sound);
                            PLAYSOUNDEFFECT(bulletice_explosion_sound);
                            frozenEffectTimer = kFrozenEffectTimer;
                            [self towerIceExplosionEffect];
                            
                        }
                    } else if ([b bulletType] == kBulletBomb) {
                        PLAYSOUNDEFFECT(onfire_status_sound);
                        bombEffectTimer = kBombEffectTimer;
                    }
                }
            }
        }
    }
    
    // enemy movement; don't forget to move any status effects present on the enemy    
    float newPositionX = self.position.x + (self.velocity)*(self.velocityEffect)*(self.slowEffect)*(deltaTime)*(deltaX)/(distanceToDestination);
    float newPositionY = self.position.y + (self.velocity)*(self.velocityEffect)*(self.slowEffect)*(deltaTime)*(deltaY)/(distanceToDestination);
    self.position = ccp(newPositionX,newPositionY);
    
    self.healthbarBack.position = ccp(self.position.x - self.healthbarBack.contentSize.width/2, 
                                  self.position.y + 0.75f*self.contentSize.height);
    self.healthbar.position = ccp(self.position.x - self.healthbar.contentSize.width/2, 
                                  self.position.y + 0.75f*self.contentSize.height);
    
    if (self.enemyStatusEffectSprite != nil) {
        float offsetY = self.contentSize.height/2;
        self.enemyStatusEffectSprite.position = ccp(self.position.x, self.position.y + offsetY);

        self.enemyStatusEffectSprite.zOrder = self.zOrder;
    }
}

- (void) initPathGenerator {
    
    GameManager *m = [GameManager sharedGameManager];
    
    NSDictionary *levelDictionary = [NSDictionary dictionaryWithDictionary: [m getInformationForLevel: m.selectedLevel]];
    
    // extract path points and path solutions from levelArray; currently, tmpPathStrings is an array of NSString's
    NSArray *tmpPathStrings = [levelDictionary valueForKey: @"Path Points"];
    NSArray *tmpPathSolutions = [levelDictionary valueForKey: @"Path Solutions"];
    
    NSArray *tmpPathPoints = [NSArray arrayWithArray: [m getPointArrayFromStringArray: tmpPathStrings]];
        
    self.path = [PathGenerator pathWithPathPoints: tmpPathPoints 
                                 andPathSolutions: tmpPathSolutions];
}

- (id) init {
    if (self = [super init]) {
        offScreenWidth = screenSize.width + [self boundingBox].size.width;
        
        [self initPathGenerator];
        
        self.velocityEffect = 1.0f;
        self.slowEffect = 1.0f;
        self.objectType = kEnemyType;
        self.frozenEffectTimer = -1.0f;
        self.bombEffectTimer = -1.0f;
        self.armorValue = 0.0f;
        self.towerIceExplosionSprite = [CCSprite node];
        self.towerIceExplosionActive = NO;
        
        self.poisonEffectTimer = -1.0f;
        self.poisonCounter = 0;
        
        self.smiteEffectTimer = -1.0f;
        self.slowEffectTimer = -1.0f;
        
        self.directionState = kDirectionNone;
    }
    return self;
}

@end









