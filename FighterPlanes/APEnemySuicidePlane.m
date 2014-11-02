//
//  APEnemySuicidePlane.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APEnemySuicidePlane.h"
#import "math.h"


@implementation APEnemySuicidePlane

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"suicidePlane.png"];
    if (!self) return(nil);
    
    self.scale = .25f;
    self.health = 1;
    self.locked_on = false;
    _speed = 2.0f;
    _damageOnCollision = 1.0f;
    
    return self;
}

- (void)tick:(CCTime)delta {
    
    if (!self.locked_on) {
        float deltx = self.heroSprite.position.x - self.position.x;
        float delty = self.heroSprite.position.y - self.position.y;
        float angle = atan(delty/deltx);
        double distance = sqrt(powf(deltx, 2.0f) + powf(delty, 2.0f));
        if (distance < 250) {
            self.locked_on = true;
        }
        if (deltx < 0) {
            angle = angle + M_PI;
        }
        angle = -1*angle + M_PI/2;
        float goToAngleDegrees = CC_RADIANS_TO_DEGREES(angle);
        goToAngleDegrees = fmodf(goToAngleDegrees, 360.0f);
        float rotationDiff = goToAngleDegrees-self.rotation;
        self.rotation += rotationDiff;
    
        self.position = ccp(self.position.x+delta*60.0f*_speed*sin(CC_DEGREES_TO_RADIANS(self.rotation)), self.position.y+delta*60.0f*_speed*cos(CC_DEGREES_TO_RADIANS(self.rotation)));
    }
    else {
        self.position = ccp(self.position.x+delta*60.0f*_speed*sin(CC_DEGREES_TO_RADIANS(self.rotation)), self.position.y+delta*60.0f*_speed*cos(CC_DEGREES_TO_RADIANS(self.rotation)));
    }
    
    
}

@end
