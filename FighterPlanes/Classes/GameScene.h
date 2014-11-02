//
//  GameScene.h
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameHudScene.h"

@interface GameScene : CCScene {
    
}


@property (nonatomic, assign, readonly) int score;
@property (nonatomic, retain) GameHudScene *gameHudScene;

+ (GameScene *)scene;
- (id)init;

- (void)heroStartShoot:(int)weaponType;
- (void)heroStopShoot:(int)weaponType;
- (void)addSprite:(CCSprite *)s;

@end
