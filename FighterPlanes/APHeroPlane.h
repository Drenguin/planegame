//
//  APHeroPlane.h
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "APPlane.h"
#import "APWeapon.h"

@interface APHeroPlane : APPlane {
    
}

- (APWeapon *)shoot:(int)weaponType;

@end
