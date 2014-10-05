//
//  GameScene.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "GameScene.h"
#import <CoreMotion/CoreMotion.h>
#import "APHeroPlane.h"
#import "APObstaclePlane.h"
#import "APEnemySuicidePlane.h"


@implementation GameScene {
    CMMotionManager *_motionManager;
    APHeroPlane *_planeSprite;
    NSMutableArray *_heroWeapons;
    NSMutableArray *_enemyPlanes;
    CCSprite *_background;
}

float rotationSpeed = 10.0f;

float newEnemyTimer;
float newEnemyReloadTime;


+ (GameScene *)scene {
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    _motionManager = [[CMMotionManager alloc] init];
    
    _heroWeapons = [[NSMutableArray alloc] init];
    _enemyPlanes = [[NSMutableArray alloc] init];
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Create a colored background (Dark Grey)
    _background = [CCSprite spriteWithImageNamed:@"california.png"];
    _background.anchorPoint = ccp(0,0);
    _background.position = ccp(0, 0);
    _background.scale = 0.5f;
    
    newEnemyReloadTime = 0.5f;
    newEnemyTimer = newEnemyReloadTime;
    
    _planeSprite = [[APHeroPlane alloc] init];
    _planeSprite.parentScene = self;
    _planeSprite.position = ccp(screenSize.width/2.0f, screenSize.height/2.0f);
    _planeSprite.scale = 1.0f;
    [_planeSprite.texture setAntialiased:NO];
    
    [self addChild:_background z:-1];
    [self addChild:_planeSprite z:1];
    
    // done
    return self;
}

- (void)update:(CCTime)delta {
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    _planeSprite.rotation += acceleration.y*delta*rotationSpeed*60.0f;
    _planeSprite.position = ccp(_planeSprite.position.x+[_planeSprite getSpeed]*delta*60.0f*sin(CC_DEGREES_TO_RADIANS(_planeSprite.rotation)), _planeSprite.position.y + [_planeSprite getSpeed]*delta*60.0f*cos(CC_DEGREES_TO_RADIANS(_planeSprite.rotation)));
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    float x = MAX(_planeSprite.position.x, screenSize.width/2.0f);
    float y = MAX(_planeSprite.position.y, screenSize.height/2.0f);
    x = MIN(x, _background.boundingBox.size.width-screenSize.width/2.0f);
    y = MIN(y, _background.boundingBox.size.height-screenSize.height/2.0f);
    
    CGPoint centerOfView = ccp(screenSize.width/2, screenSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, ccp(x,y));
    self.position = viewPoint;
    
    // To get this working we need to change self.position by the sin and cos of _planeSprite.rotation
    //self.rotation = _planeSprite.rotation;
    //self.position = ccp(self.position.x + screenSize.width*sin(CC_DEGREES_TO_RADIANS(self.rotation)), self.position.y + screenSize.width*cos(CC_DEGREES_TO_RADIANS(self.rotation)));
    
    [_planeSprite tick:delta];
    
    NSMutableArray *enemyPlanesToRemove = [[NSMutableArray alloc] init];
    
    for (APPlane *p in _enemyPlanes) {
        [p tick:delta];
        if (!CGRectIntersectsRect([p boundingBox], [_background boundingBox])) {
            [enemyPlanesToRemove addObject:p];
        }
        
        if (CGRectIntersectsRect([p boundingBox], [_planeSprite boundingBox])) {
            [self setPaused:YES];
            [self.gameHudScene gameOver];
        }
    }
    for (CCSprite *p in enemyPlanesToRemove) {
        [self removeChild:p];
        [_enemyPlanes removeObject:p];
    }
    
    NSMutableArray *weaponsToRemove = [[NSMutableArray alloc] init];
    
    for (APWeapon *w in _heroWeapons) {
        [w tick:delta];
        if (!CGRectIntersectsRect([w boundingBox], [_background boundingBox])) {
            [weaponsToRemove addObject:w];
        }
    }
    
    for (CCSprite *w in weaponsToRemove) {
        [self removeChild:w];
        [_heroWeapons removeObject:w];
    }
    
    weaponsToRemove = [[NSMutableArray alloc] init];
    enemyPlanesToRemove = [[NSMutableArray alloc] init];
    
    for (APWeapon *w in _heroWeapons) {
        for (APPlane *p in _enemyPlanes) {
            if (w.visible && p.visible && CGRectIntersectsRect([w boundingBox], [p boundingBox])) {
                [weaponsToRemove addObject:w];
                w.visible = NO;
                
                p.health -= [w getDamage];
                if (p.health <= 0) {
                    [enemyPlanesToRemove addObject:p];
                    p.visible = NO;
                }
            }
        }
    }
    
    for (CCSprite *p in enemyPlanesToRemove) {
        [self removeChild:p];
        [_enemyPlanes removeObject:p];
    }
    for (CCSprite *w in weaponsToRemove) {
        [self removeChild:w];
        [_heroWeapons removeObject:w];
    }
    
    newEnemyTimer -= delta;
    if (newEnemyTimer <= 0) {
        newEnemyTimer = newEnemyReloadTime;
        [self createEnemy];
    }
    
    /*//float newRotOffset = -1*acceleration.y*delta*60.0f;
    float newXOffset = -1*planeSpeed*delta*60.0f*sin(CC_DEGREES_TO_RADIANS(_planeSprite.rotation));
    float newYOffset = -1*planeSpeed*delta*60.0f*cos(CC_DEGREES_TO_RADIANS(_planeSprite.rotation));
    
    for (CCSprite *s in _sprites) {
        s.position = ccp(s.position.x+newXOffset, s.position.y+newYOffset);
        //s.anchorPoint = ccp((_planeSprite.position.x-s.position.x)/s.boundingBox.size.width + 0.5f,( _planeSprite.position.y-s.position.y)/s.boundingBox.size.height + 0.5f);
        //s.anchorPoint = ccp(s.anchorPoint.x-(newXOffset/s.boundingBox.size.width), s.anchorPoint.y-(newYOffset/s.boundingBox.size.height));
        //NSLog(@"%f, %f",s.anchorPoint.x, s.anchorPoint.y);
        //s.rotation = s.rotation + newRotOffset;
    }*/
}

- (void)createEnemy {
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    APPlane *enemyPlane;
    
    int planeType = arc4random()%2;
    if (planeType == 0) {
        enemyPlane = [[APEnemySuicidePlane alloc] init];
        ((APEnemySuicidePlane *)enemyPlane).heroSprite = _planeSprite;
    } else if (planeType == 1) {
        enemyPlane = [[APObstaclePlane alloc] init];
    }
    
    enemyPlane.rotation = (arc4random()%365);
    
    float x = (arc4random()%((int)_background.boundingBox.size.width));
    float y = (arc4random()%((int)_background.boundingBox.size.height));
    
    while (!((x>(self.position.x+screenSize.width) || x<(self.position.x)) && (y>(self.position.y+screenSize.height) || y<(self.position.y)))) {
        
        x = (arc4random()%((int)_background.boundingBox.size.width));
        y = (arc4random()%((int)_background.boundingBox.size.height));
    }
    enemyPlane.position = ccp(x,y);
    
    [self addSprite:enemyPlane];
}

- (void)heroStartShoot:(int)weaponType {
    [_planeSprite startShooting:weaponType];
}

- (void)heroStopShoot:(int)weaponType {
    [_planeSprite stopShooting:weaponType];
}

- (void)addSprite:(CCSprite *)s {
    if ([s isKindOfClass:[APWeapon class]]) {
        [_heroWeapons addObject:s];
    } else if ([s isKindOfClass:[APPlane class]]) {
        [_enemyPlanes addObject:s];
    }
    [self addChild:s];
}

- (void)onEnter {
    [super onEnter];
    [_motionManager startAccelerometerUpdates];
}

- (void)onExit {
    [super onExit];
    [_motionManager stopAccelerometerUpdates];
}


@end
