//
//  APHeroPlane.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APHeroPlane.h"
#import "APMachineGunWeapon.h"
#import "APMissileWeapon.h"


@implementation APHeroPlane

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"plane.png"];
    if (!self) return(nil);
    
    self.health = 5;
    _speed = 3.0f;
    
    return self;
}

- (APWeapon *)shoot:(int)weaponType {
    if (weaponType == MACHINE_GUN) {
        APMachineGunWeapon *machn = [[APMachineGunWeapon alloc] init];
        machn.rotation = self.rotation;
        return machn;
    } else {
        APMissileWeapon *mssl = [[APMissileWeapon alloc] init];
        mssl.rotation = self.rotation;
        return mssl;
    }
}



@end
