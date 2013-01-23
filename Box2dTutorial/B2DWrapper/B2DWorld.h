//
//  B2DWorld.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "B2DBody.h"
#import "B2DRevoluteJoint.h"
#import "B2DContactListener.h"

@interface B2DWorld : NSObject
{

}

- (id)initWithGravity:(B2DVec2)gravity;

- (B2DBody*)createBody:(const B2DBodyDef *)bodyDef;
- (void)destoryBody:(B2DBody*)body;
- (B2DJoint*)createJointOfType:(B2DJointType)type withDef:(const void *)voidDef;
- (void)destroyJoint:(B2DJoint*)joint;

- (void)stepWithDeltaTime:(double)dT velocityIterations:(int)velocityIterations positionIterations:(int)positionIterations;

- (NSArray*)jointList;
- (NSArray*)bodyList;

- (void)setGravity:(B2DVec2)gravity;
- (B2DVec2)gravity;

- (void)setContactListener:(B2DContactListener*)listener;

@end
