//
//  B2DJoint.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum B2DJointType
{
	b2d_unknownJoint,
	b2d_revoluteJoint,
	b2d_prismaticJoint,
	b2d_distanceJoint,
	b2d_pulleyJoint,
	b2d_mouseJoint,
	b2d_gearJoint,
	b2d_wheelJoint,
    b2d_weldJoint,
	b2d_frictionJoint,
	b2d_ropeJoint
} B2DJointType;

@interface B2DJoint : NSObject

- (id)initWithB2Joint:(void*)joint;
- (void*)b2Joint;

@end
