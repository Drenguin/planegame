//
//  GameHudScene.h
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameHudScene : CCScene {
    
}

+ (GameHudScene *)scene;
- (id)init;

- (void)gameOver;
- (void)updateScoreLabel;

@end
