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
- (void)update:(CCTime)delta;

@end
