//
//  APMachineGunWeapon.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APMachineGunWeapon.h"


@implementation APMachineGunWeapon

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"bullet.png"];
    if (!self) return(nil);
    
    _damage = 0.2f;
    _speed = 8.0f;
    _reloadRate = .1f;
    
    return self;
}
@end
