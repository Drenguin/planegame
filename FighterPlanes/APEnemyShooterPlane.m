//
//  APEnemyShooterPlane.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APEnemyShooterPlane.h"
#import "APEnemyBulletWeapon.h"
#import "APDefinedAttributes.h"


@implementation APEnemyShooterPlane
float timeToWaitForReload;
- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"enemyPlane.png"];
    if (!self) return(nil);
    
    self.scale = .125f;
    self.health = 3;
    timeToWaitForReload = 0.0f;
    _scoreValue = 5;
    _speed = 0.0f;
    _damageOnCollision = 1.0f;
    
    
    return self;
}

- (void)tick:(CCTime)delta {
    float deltx = self.heroSprite.position.x - self.position.x;
    float delty = self.heroSprite.position.y - self.position.y;
    float angle = atan(delty/deltx);
    if (deltx < 0) {
        angle = angle + M_PI;
    }
    angle = -1*angle + M_PI/2;
    self.rotation = CC_RADIANS_TO_DEGREES(angle);
    
    timeToWaitForReload -= delta;
    if (timeToWaitForReload <= 0) {
        APEnemyBulletWeapon *bul = [[APEnemyBulletWeapon alloc] init];
        bul.rotation = self.rotation;
        bul.position = self.position;
        timeToWaitForReload = [bul getReloadRate];
        [self.parentScene addSprite:bul];
    }
    
    
    //self.position = ccp(self.position.x+delta*60.0f*_speed*sin(CC_DEGREES_TO_RADIANS(self.rotation)), self.position.y+delta*60.0f*_speed*cos(CC_DEGREES_TO_RADIANS(self.rotation)));
}


@end
