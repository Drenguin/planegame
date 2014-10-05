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

- (void)update:(CCTime)delta {
    self.position = ccp(self.position.x+self.velocity.x, self.position.y+self.velocity.y);
}

@end
