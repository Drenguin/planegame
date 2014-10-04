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
    NSMutableArray *_sprites;
}

float planeSpeed = 3.0f;
float rotationSpeed = 10.0f;


+ (GameScene *)scene {
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    _motionManager = [[CMMotionManager alloc] init];
    
    _sprites = [[NSMutableArray alloc] init];
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Create a colored background (Dark Grey)
    CCSprite *background = [CCSprite spriteWithImageNamed:@"california.png"];
    background.position = ccp(screenSize.width/2.0f, screenSize.height/2.0f);
    background.scale = 0.5f;
    
    _planeSprite = [CCSprite spriteWithImageNamed:@"plane.png"];
    _planeSprite.position = ccp(screenSize.width/2.0f, screenSize.height/2.0f);
    _planeSprite.scale = 1.0f;
    [_planeSprite.texture setAntialiased:NO];
    
    [_sprites addObject:background];
    
    [self addChild:background];
    [self addChild:_planeSprite];
    
    // done
    return self;
}

- (void)update:(CCTime)delta {
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    _planeSprite.rotation += acceleration.y*delta*rotationSpeed*60.0f;
    //_planeSprite.position = ccp(_planeSprite.position.x+planeSpeed*delta*60.0f*sin(CC_DEGREES_TO_RADIANS(_planeSprite.rotation)), _planeSprite.position.y + planeSpeed*delta*60.0f*cos(CC_DEGREES_TO_RADIANS(_planeSprite.rotation)));
    
    //float newRotOffset = -1*acceleration.y*delta*60.0f;
    float newXOffset = -1*planeSpeed*delta*60.0f*sin(CC_DEGREES_TO_RADIANS(_planeSprite.rotation));
    float newYOffset = -1*planeSpeed*delta*60.0f*cos(CC_DEGREES_TO_RADIANS(_planeSprite.rotation));
    
    for (CCSprite *s in _sprites) {
        s.position = ccp(s.position.x+newXOffset, s.position.y+newYOffset);
        //s.anchorPoint = ccp((_planeSprite.position.x-s.position.x)/s.boundingBox.size.width + 0.5f,( _planeSprite.position.y-s.position.y)/s.boundingBox.size.height + 0.5f);
        //s.anchorPoint = ccp(s.anchorPoint.x-(newXOffset/s.boundingBox.size.width), s.anchorPoint.y-(newYOffset/s.boundingBox.size.height));
        //NSLog(@"%f, %f",s.anchorPoint.x, s.anchorPoint.y);
        //s.rotation = s.rotation + newRotOffset;
    }
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
