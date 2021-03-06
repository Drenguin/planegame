//
//  APEnemySuicidePlane.h
//  FighterPlanes
//
//  Created by Patrick Mc Gartoll on 10/4/14.
//  Copyright 2014 Drenguin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "APPlane.h"

@interface APEnemySuicidePlane : APPlane {
    
}

@property (nonatomic, retain) CCSprite *heroSprite;
@property (nonatomic, assign) BOOL locked_on;

- (void)tick:(CCTime)delta;

@end
