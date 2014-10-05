//
//  APEnemyShooterPlane.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APEnemyShooterPlane.h"


@implementation APEnemyShooterPlane

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"enemyPlane.png"];
    if (!self) return(nil);
    
    self.scale = .125f;
    self.health = 3;
    _speed = .75f;
    
    return self;
}

@end
