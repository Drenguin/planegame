//
//  APObstaclePlane.m
//  FighterPlanes
//
//  Created by Andrew Reardon on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APObstaclePlane.h"


@implementation APObstaclePlane

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"obstaclePlane2.png"];
    if (!self) return(nil);
    
    self.scale = .75f;
    self.health = 1;
    _speed = 1.0f;
    
    return self;
}

- (void)tick:(CCTime)delta {
    self.position = ccp(self.position.x+delta*60.0f*_speed*sin(CC_DEGREES_TO_RADIANS(self.rotation)), self.position.y+delta*60.0f*_speed*cos(CC_DEGREES_TO_RADIANS(self.rotation)));
}

@end
