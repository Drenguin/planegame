//
//  APWeapon.h
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface APWeapon : CCSprite {
    float _damage;
    float _speed;
    float _reloadRate;
}

- (float)getDamage;
- (float)getSpeed;
- (float)getReloadRate;

- (void)update:(CCTime)delta;

@end