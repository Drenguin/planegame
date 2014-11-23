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
#import "cocos2d-ui.h"


@implementation GameHudScene {
    GameScene *_gameScene;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *gameOverLabel;
    CCLabelTTF *gameOverScoreLabel;
    CCNodeColor *fadedLayer;
    CCButton *restartButton;
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
    
    scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Courier New" fontSize:20.0f];
    scoreLabel.position = ccp(screenSize.width/2.0f, screenSize.height-20.0f);
    
    
    gameOverLabel = [CCLabelTTF labelWithString:@"GAME OVER!" fontName:@"Chalkduster" fontSize:38.0f];
    gameOverLabel.positionType = CCPositionTypeNormalized;
    gameOverLabel.color = [CCColor redColor];
    gameOverLabel.position = ccp(0.5f, 0.6f);
    
    gameOverScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d     High Score: %d", -1, -1] fontName:@"Courier New" fontSize:24.0f];
    gameOverScoreLabel.positionType = CCPositionTypeNormalized;
    gameOverScoreLabel.color = [CCColor blackColor];
    gameOverScoreLabel.position = ccp(0.5f, 0.45f); // Middle of screen
    
    restartButton = [CCButton buttonWithTitle:@"[ RESTART ]" fontName:@"Courier New" fontSize:24.0f];
    restartButton.positionType = CCPositionTypeNormalized;
    restartButton.position = ccp(0.5f, 0.30f);
    restartButton.color = [CCColor blackColor];
    [restartButton setTarget:self selector:@selector(restart)];
    
    fadedLayer = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1 green:1 blue:1 alpha:0.7f] width:screenSize.width*0.8f height:screenSize.height*0.6f];
    fadedLayer.positionType = CCPositionTypeNormalized;
    fadedLayer.anchorPoint = ccp(0.5f, 0.5f);
    fadedLayer.position = ccp(0.5f, 0.5f);
    
    [self addChild:_gameScene];
    [self addChild:scoreLabel z:10];
    [self addChild:restartButton z:10];
    [self addChild:gameOverLabel z:10];
    [self addChild:gameOverScoreLabel z:10];
    [self addChild:fadedLayer z:9];
    
    gameOverLabel.visible = NO;
    restartButton.visible = NO;
    gameOverScoreLabel.visible = NO;
    fadedLayer.visible = NO;
    
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

- (void)restart {
    [_gameScene setPaused:NO];
    gameOverLabel.visible = NO;
    gameOverScoreLabel.visible = NO;
    restartButton.visible = NO;
    fadedLayer.visible = NO;
    
    scoreLabel.visible = YES;
    [_gameScene restart];
}

- (void)gameOver {
    [_gameScene setPaused:YES];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"] < _gameScene.score) {
        [[NSUserDefaults standardUserDefaults] setInteger:_gameScene.score forKey:@"highscore"];
    }
    
    [gameOverScoreLabel setString:[NSString stringWithFormat:@"Score: %d     High Score: %ld",
                                   _gameScene.score,
                                   (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]]];
    
    gameOverLabel.visible = YES;
    restartButton.visible = YES;
    gameOverScoreLabel.visible = YES;
    fadedLayer.visible = YES;
    
    scoreLabel.visible = NO;
}

- (void)updateScoreLabel {
    [scoreLabel setString:[NSString stringWithFormat:@"%d", _gameScene.score]];
}

@end
