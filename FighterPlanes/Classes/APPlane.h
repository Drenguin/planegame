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
}

@property (nonatomic, assign) float health;

- (void)update:(CCTime)delta;

@end
