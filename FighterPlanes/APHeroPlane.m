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
#import "APDefinedAttributes.h"


@implementation APHeroPlane

float machineGunTimeToWaitForReload;
float missileTimeToWaitForReload;

NSMutableDictionary *weaponsToShoot;

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"heroPlane.png"];
    if (!self) return(nil);
    
    self.health = 5;
    _speed = 2.5f;
    
    machineGunTimeToWaitForReload = 0.0f;
    missileTimeToWaitForReload = 0.0f;
    
    weaponsToShoot = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)update:(CCTime)delta {
    machineGunTimeToWaitForReload -= delta;
    missileTimeToWaitForReload -= delta;
    
    if ([[weaponsToShoot objectForKey:@(MACHINE_GUN)] boolValue]) {
        if (machineGunTimeToWaitForReload <= 0) {
            APMachineGunWeapon *machn = [[APMachineGunWeapon alloc] init];
            machn.rotation = self.rotation;
            machn.position = self.position;
            machineGunTimeToWaitForReload = [machn getReloadRate];
            [self.parentScene addSprite:machn];
        }
    }
    if ([[weaponsToShoot objectForKey:@(MISSILE)] boolValue]) {
        if (missileTimeToWaitForReload <= 0) {
            APMissileWeapon *mssl = [[APMissileWeapon alloc] init];
            mssl.rotation = self.rotation;
            mssl.position = self.position;
            missileTimeToWaitForReload = [mssl getReloadRate];
            [self.parentScene addSprite:mssl];
        }
    }
}

- (void)startShooting:(int)weaponType {
    [weaponsToShoot setObject:@(YES) forKey:@(weaponType)];
}

- (void)stopShooting:(int)weaponType {
    [weaponsToShoot setObject:@(NO) forKey:@(weaponType)];
}

@end
