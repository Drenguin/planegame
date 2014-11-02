//
//  APExplosion.m
//  FighterPlanes
//
//  Created by Andrew Reardon on 11/1/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APExplosion.h"


@implementation APExplosion
float grow_lifetime_remaining;
float shrink_lifetime_remaining;

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"explosion.png"];
    if (!self) return(nil);
    
    self.scale = .1f;
    grow_lifetime_remaining = 0.5f;
    shrink_lifetime_remaining = 1.0f;
    
    return self;
}

- (void)tick:(CCTime)delta {
    if (grow_lifetime_remaining > 0) {
        self.scale = .1 + (.5 - grow_lifetime_remaining);
        grow_lifetime_remaining -= delta;
    }
    else{
        if (shrink_lifetime_remaining > 0) {
            self.scale = .6 + (1 - shrink_lifetime_remaining);
            shrink_lifetime_remaining -= delta;
        }
        else {
            [self removeFromParent];
        }
    }
}

@end
