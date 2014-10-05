//
//  APWeapon.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APWeapon.h"


@implementation APWeapon
@synthesize velocity;

- (float)getDamage {
    return _damage;
}

- (float)getSpeed {
    return _speed;
}

- (float)getReloadRate {
    return _reloadRate;
}

@end
