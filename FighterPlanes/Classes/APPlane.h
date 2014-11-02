//
//  APPlane.h
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface APPlane : CCSprite {
    float _speed;
    float _damageOnCollision;
    
    @protected
    int _scoreValue;
}

@property (nonatomic, assign) float health;
@property (nonatomic, readonly) int scoreValue;

- (void)tick:(CCTime)delta;
- (float)getSpeed;

@end
