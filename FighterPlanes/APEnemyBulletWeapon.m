//
//  APEnemyBulletWeapon.m
//  FighterPlanes
//
//  Created by Andrew Reardon on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APEnemyBulletWeapon.h"


@implementation APEnemyBulletWeapon

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"bullet.png"];
    if (!self) return(nil);
    
    self.scale = .1f;
    _damage = 0.5f;
    _speed = 5.0f;
    _reloadRate = 2.0f;
    
    return self;
}


@end
