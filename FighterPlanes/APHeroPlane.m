//
//  APHeroPlane.m
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import "APHeroPlane.h"


@implementation APHeroPlane

- (id)init {
    // Apple recommend assigning self with supers return value
    self = [super initWithImageNamed:@"enemyPlane.png"];
    if (!self) return(nil);
    
    self.health = 5;
    _speed = 3.0f;
    
    return self;
}

@end
