//
//  GameScene.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene


+ (GameScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Create a colored background (Dark Grey)
    CCSprite *background = [CCSprite spriteWithImageNamed:@"California.png"];
    
    CCSprite *planeSprite = [CCSprite spriteWithImageNamed:@"plane.png"];
    planeSprite.position = ccp(screenSize.width/2.0f, screenSize.height/2.0f);
    planeSprite.scale = 2.0f;
    [planeSprite.texture setAntialiased:NO];
    
    [self addChild:background];
    [self addChild:planeSprite];
    
    // done
    return self;
}


@end
