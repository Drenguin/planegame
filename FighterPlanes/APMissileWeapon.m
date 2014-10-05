//
//  APMissileWeapon.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APMissileWeapon.h"


@implementation APMissileWeapon

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"missile.png"];
    if (!self) return(nil);
    
    
    self.scale = .1;
    _damage = 5.0f;
    _speed = 5.0f;
    _reloadRate = 3.0f;
    
    return self;
}
@end
