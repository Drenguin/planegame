//
//  APExplosion.h
//  FighterPlanes
//
//  Created by Andrew Reardon on 11/1/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface APExplosion : CCSprite {
}

@property (nonatomic, retain) GameScene *parentScene;
@property (nonatomic, assign) float grow_lifetime_remaining;
@property (nonatomic, assign) float shrink_lifetime_remaining;

- (void)update:(CCTime)delta;

@end
