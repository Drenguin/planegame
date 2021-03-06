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
#import "APEnemyShooterPlane.h"
#import "APEnemyBulletWeapon.h"
#import "APExplosion.h"

#define SPAWN_BOUNDS_OFFSET 100


@implementation GameScene {
    CMMotionManager *_motionManager;
    APHeroPlane *_planeSprite;
    NSMutableArray *_heroWeapons;
    NSMutableArray *_enemyPlanes;
    NSMutableArray *_enemyWeapons;
    CCSprite *_background;
}
@synthesize score = _score;

float rotationSpeed = 10.0f;

float newEnemyTimer;
float newEnemyReloadTime;

float totalTime;


+ (GameScene *)scene {
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    _motionManager = [[CMMotionManager alloc] init];
    
    _background = [CCSprite spriteWithImageNamed:@"california2.png"];
    
    _planeSprite = [[APHeroPlane alloc] init];
    
    
    [self addChild:_background z:-1];
    [self addChild:_planeSprite z:1];
    
    [self schedule:@selector(incrementScore) interval:1.0f];
    
    [self restart];
    // done
    return self;
}

- (void)restart {
    if (_heroWeapons) {
        for (CCSprite *s in _heroWeapons) {
            [self removeChild:s];
        }
    }
    if (_enemyWeapons) {
        for (CCSprite *s in _enemyWeapons) {
            [self removeChild:s];
        }
    }
    if (_enemyPlanes) {
        for (CCSprite *s in _enemyPlanes) {
            [self removeChild:s];
        }
    }
    
    _heroWeapons = [[NSMutableArray alloc] init];
    _enemyPlanes = [[NSMutableArray alloc] init];
    _enemyWeapons = [[NSMutableArray alloc] init];
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Create a colored background (Dark Grey)
    _background.anchorPoint = ccp(0,0);
    _background.position = ccp(0, 0);
    _background.scale = 0.5f;
    
    newEnemyReloadTime = 1.1f;
    newEnemyTimer = newEnemyReloadTime;
    
    _planeSprite.parentScene = self;
    _planeSprite.position = ccp(screenSize.width/2.0f, screenSize.height/2.0f);
    _planeSprite.scale = 1.0f;
    [_planeSprite.texture setAntialiased:NO];
    
    _score = 0;
    
    totalTime = 0.0f;

    [self.gameHudScene updateScoreLabel];
}

- (void)incrementScore {
    _score += 1;
    [self.gameHudScene updateScoreLabel];
}

- (void)update:(CCTime)delta {
    totalTime += delta;
    
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    _planeSprite.rotation += acceleration.y*delta*rotationSpeed*60.0f;
    _planeSprite.position = ccp(_planeSprite.position.x+[_planeSprite getSpeed]*delta*60.0f*sin(CC_DEGREES_TO_RADIANS(_planeSprite.rotation)), _planeSprite.position.y + [_planeSprite getSpeed]*delta*60.0f*cos(CC_DEGREES_TO_RADIANS(_planeSprite.rotation)));
    
    if (_planeSprite.position.x + _planeSprite.radius > _background.boundingBox.size.width) {
        _planeSprite.position = ccp(_background.boundingBox.size.width - _planeSprite.radius, _planeSprite.position.y);
    } else if (_planeSprite.position.x - _planeSprite.radius < 0) {
        _planeSprite.position = ccp(_planeSprite.radius, _planeSprite.position.y);
    }
    
    if (_planeSprite.position.y + _planeSprite.radius > _background.boundingBox.size.height) {
        _planeSprite.position = ccp(_planeSprite.position.x, _background.boundingBox.size.height - _planeSprite.radius);
    } else if (_planeSprite.position.y - _planeSprite.radius < 0) {
        _planeSprite.position = ccp(_planeSprite.position.x, _planeSprite.radius);
    }
    
    
    
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
        if (!CGRectIntersectsRect([p boundingBox], CGRectInset([_background boundingBox], -2*SPAWN_BOUNDS_OFFSET, -2*SPAWN_BOUNDS_OFFSET))) {
            [enemyPlanesToRemove addObject:p];
        }
        
        if (ccpDistance(p.position, _planeSprite.position) < (p.radius+_planeSprite.radius)) {
            [self.gameHudScene gameOver];
        }
    }
    for (APPlane *p in enemyPlanesToRemove) {
        [self removeChild:p];
        [_enemyPlanes removeObject:p];
        _score += p.scoreValue;
    }
    
    NSMutableArray *heroWeaponsToRemove = [[NSMutableArray alloc] init];
    
    for (APWeapon *w in _heroWeapons) {
        [w tick:delta];
        if (!CGRectIntersectsRect([w boundingBox], CGRectInset([_background boundingBox], -2*SPAWN_BOUNDS_OFFSET, -2*SPAWN_BOUNDS_OFFSET))) {
            [heroWeaponsToRemove addObject:w];
        }
    }
    
    for (CCSprite *w in heroWeaponsToRemove) {
        [self removeChild:w];
        [_heroWeapons removeObject:w];
    }
    
    heroWeaponsToRemove = [[NSMutableArray alloc] init];
    enemyPlanesToRemove = [[NSMutableArray alloc] init];
    
    for (APWeapon *w in _heroWeapons) {
        for (APPlane *p in _enemyPlanes) {
            if (w.visible && p.visible && (ccpDistance(p.position, w.position) < (p.radius+w.radius))) {
                [heroWeaponsToRemove addObject:w];
                w.visible = NO;
                
                p.health -= [w getDamage];
                if (p.health <= 0) {
                    if (![enemyPlanesToRemove containsObject:p]) {
                        [enemyPlanesToRemove addObject:p];
                    }
                    
                    p.visible = NO;
                }
            }
        }
    }
    
    for (APPlane *p in enemyPlanesToRemove) {
        [self removeEnemy:p];
    }
    for (CCSprite *w in heroWeaponsToRemove) {
        [self removeChild:w];
        [_heroWeapons removeObject:w];
    }
    
    NSMutableArray *enemyWeaponsToRemove = [[NSMutableArray alloc] init];
    
    for (APWeapon *w in _enemyWeapons) {
        [w tick:delta];
        if (!CGRectIntersectsRect([w boundingBox], CGRectInset([_background boundingBox], -2*SPAWN_BOUNDS_OFFSET, -2*SPAWN_BOUNDS_OFFSET))) {
            [enemyWeaponsToRemove addObject:w];
        } else if (w.visible && (ccpDistance(_planeSprite.position, w.position) < (_planeSprite.radius+w.radius))) {
            [enemyWeaponsToRemove addObject:w];

            _planeSprite.health -= [w getDamage];
            if (_planeSprite.health <= 0) {
                [self.gameHudScene gameOver];
            }
        }
    }
    
    for (CCSprite *w in enemyWeaponsToRemove) {
        [self removeChild:w];
        [_enemyWeapons removeObject:w];
    }
    
    newEnemyTimer -= delta;
    if (newEnemyTimer <= 0) {
        newEnemyTimer = newEnemyReloadTime;
        
        if (newEnemyReloadTime > 0.6f) {
            newEnemyReloadTime -= 0.01f;
        }
        
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

- (void)removeEnemy:(APPlane *)e
{
    APExplosion *exp = [[APExplosion alloc] init];
    exp.position = e.position;
    [self addChild:exp];
    
    [self removeChild:e];
    [_enemyPlanes removeObject:e];
}

- (void)createEnemy {
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    APPlane *enemyPlane;
    
    int planeType = 0;
    
    if (totalTime > 15.0f) {
        planeType = arc4random()%3;
    }
    
    if (planeType == 0) {
        enemyPlane = [[APObstaclePlane alloc] init];
    } else if (planeType == 1) {
        enemyPlane = [[APEnemySuicidePlane alloc] init];
        ((APEnemySuicidePlane *)enemyPlane).heroSprite = _planeSprite;
    } else if (planeType == 2) {
        enemyPlane = [[APEnemyShooterPlane alloc] init];
        ((APEnemyShooterPlane *)enemyPlane).parentScene = self;
        ((APEnemyShooterPlane *)enemyPlane).heroSprite = _planeSprite;
    }
    
    enemyPlane.rotation = (arc4random()%365);
    
    float x = (arc4random()%((int)_background.boundingBox.size.width));
    float y = (arc4random()%((int)_background.boundingBox.size.height));
    
    while (!((x>(-1*self.position.x+screenSize.width+SPAWN_BOUNDS_OFFSET) || x<(-1*self.position.x-SPAWN_BOUNDS_OFFSET)) && (y>(-1*self.position.y+screenSize.height+SPAWN_BOUNDS_OFFSET) || y<(-1*self.position.y-SPAWN_BOUNDS_OFFSET)))) {
        
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
    int z = 0;
    if ([s isKindOfClass:[APEnemyBulletWeapon class]]) {
        [_enemyWeapons addObject:s];
    } else if ([s isKindOfClass:[APWeapon class]]) {
        [_heroWeapons addObject:s];
    } else if ([s isKindOfClass:[APPlane class]]) {
        [_enemyPlanes addObject:s];
        z = 1;
    }
    [self addChild:s z:z];
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
