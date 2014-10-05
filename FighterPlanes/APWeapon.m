//
//  APWeapon.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APWeapon.h"


@implementation APWeapon

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
    self.position = ccp(self.position.x+delta*60.0f*_speed*sin(CC_DEGREES_TO_RADIANS(self.rotation)), self.position.y+delta*60.0f*_speed*cos(CC_DEGREES_TO_RADIANS(self.rotation)));
}

@end
