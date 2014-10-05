//
//  APEnemySuicidePlane.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APEnemySuicidePlane.h"


@implementation APEnemySuicidePlane

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"suicidePlane.png"];
    if (!self) return(nil);
    
    self.scale = .25f;
    self.health = 1;
    _speed = 2.0f;
    
    return self;
}

- (float) setDirection {
    float deltx = self.heroSprite.position.x - self.position.x;
    float delty = self.heroSprite.position.y - self.position.y;
    
    return 0.0;
}

- (void)update:(CCTime)delta {
    self.rotation = [self setDirection];
    self.position = ccp(self.position.x+delta*_speed*sin(CC_DEGREES_TO_RADIANS(self.rotation)), self.position.y+delta*_speed*cos(CC_DEGREES_TO_RADIANS(self.rotation)));
}

@end
