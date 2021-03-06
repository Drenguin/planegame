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
    
    self.scale = .1f;
    _damage = 1.0f;
    _speed = 8.0f;
    _reloadRate = .1f;
    
    self.radius = 4.0f;
    
    return self;
}
@end
