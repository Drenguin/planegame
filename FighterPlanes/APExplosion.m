//
//  APExplosion.m
//  FighterPlanes
//
//  Created by Andrew Reardon on 11/1/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APExplosion.h"


@implementation APExplosion 

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"explosion.png"];
    if (!self) return(nil);
    
    self.scale = .1f;
    self.grow_lifetime_remaining = 0.5f;
    self.shrink_lifetime_remaining = 0.6f;
    
    return self;
}

- (void)update:(CCTime)delta {
    if (self.grow_lifetime_remaining > 0) {
        self.scale = .1 + (.5 - self.grow_lifetime_remaining);
        self.grow_lifetime_remaining -= delta;
    }
    else{
        if (self.shrink_lifetime_remaining > 0) {
            self.scale = .6 - (0.6 - self.shrink_lifetime_remaining);
            self.shrink_lifetime_remaining -= delta;
        }
        else {
            [self removeFromParent];
        }
    }
}

@end
