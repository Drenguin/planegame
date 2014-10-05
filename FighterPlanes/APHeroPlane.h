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
#import "GameScene.h"

@interface APHeroPlane : APPlane {
    
}

@property (nonatomic, retain) GameScene *parentScene;

- (void)startShooting:(int)weaponType;
- (void)stopShooting:(int)weaponType;

- (void)tick:(CCTime)delta;

@end
