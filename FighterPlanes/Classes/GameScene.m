//
//  GameScene.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "GameScene.h"
#import <CoreMotion/CoreMotion.h>


@implementation GameScene {
    CMMotionManager *_motionManager;
    CCSprite *_planeSprite;
}


+ (GameScene *)scene {
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    _motionManager = [[CMMotionManager alloc] init];
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Create a colored background (Dark Grey)
    CCSprite *background = [CCSprite spriteWithImageNamed:@"California.png"];
    
    _planeSprite = [CCSprite spriteWithImageNamed:@"plane.png"];
    _planeSprite.position = ccp(screenSize.width/2.0f, screenSize.height/2.0f);
    _planeSprite.scale = 2.0f;
    [_planeSprite.texture setAntialiased:NO];
    
    [self addChild:background];
    [self addChild:_planeSprite];
    
    // done
    return self;
}

- (void)update:(CCTime)delta {
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
}

- (void)onEnter {
    [super onEnter];
    [_motionManager startAccelerometerUpdates];
}

- (void)onExit {
    [_motionManager stopAccelerometerUpdates];
}


@end
