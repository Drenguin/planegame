//
//  GameHudScene.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "GameHudScene.h"
#import "GameScene.h"
#import "APHeroPlane.h"
#import "APDefinedAttributes.h"


@implementation GameHudScene {
    GameScene *_gameScene;
    CCLabelTTF *scoreLabel;
}

+ (GameHudScene *)scene {
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    
    _gameScene = [GameScene scene];
    _gameScene.gameHudScene = self;
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Trebuchet MS" fontSize:20.0f];
    scoreLabel.position = ccp(screenSize.width/2.0f, screenSize.height-20.0f);
    
    [self addChild:_gameScene];
    [self addChild:scoreLabel z:10];
    
    return self;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    if (touchLocation.x > screenSize.width/2.0f) {
        [_gameScene heroStartShoot:MACHINE_GUN];
    } else {
        [_gameScene heroStartShoot:MISSILE];
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    if (touchLocation.x > screenSize.width/2.0f) {
        [_gameScene heroStopShoot:MACHINE_GUN];
    } else {
        [_gameScene heroStopShoot:MISSILE];
    }
}

- (void)gameOver {
    NSLog(@"GAME OVER");
}

- (void)updateScoreLabel {
    [scoreLabel setString:[NSString stringWithFormat:@"%d", _gameScene.score]];
}

@end
