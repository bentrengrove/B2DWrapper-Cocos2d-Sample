//
//  B2DRevoluteJoint.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DJoint.h"
#import "B2DTypes.h"
#import "B2DBody.h"

typedef struct m_B2DRevoluteJointDef
{
    /// The joint type is set automatically for concrete joint types.
	B2DJointType type;
    
	/// Use this to attach application specific data to your joints.
	void* userData;
    
	/// The first attached body.
	__unsafe_unretained B2DBody* bodyA;
    
	/// The second attached body.
	__unsafe_unretained B2DBody* bodyB;
    
	/// Set this flag to true if the attached bodies should collide.
	BOOL collideConnected;
    
    /// The local anchor point relative to bodyA's origin.
	B2DVec2 localAnchorA;
    
	/// The local anchor point relative to bodyB's origin.
	B2DVec2 localAnchorB;
    
	/// The bodyB angle minus bodyA angle in the reference state (radians).
	double referenceAngle;
    
	/// A flag to enable joint limits.
	BOOL enableLimit;
    
	/// The lower angle for the joint limit (radians).
	double lowerAngle;
    
	/// The upper angle for the joint limit (radians).
	double upperAngle;
    
	/// A flag to enable the joint motor.
	BOOL enableMotor;
    
	/// The desired motor speed. Usually in radians per second.
	double motorSpeed;
    
	/// The maximum motor torque used to achieve the desired motor speed.
	/// Usually in N-m.
	double maxMotorTorque;
} B2DRevoluteJointDef;

static B2DRevoluteJointDef B2DRevoluteJointDefInit();
static inline B2DRevoluteJointDef B2DRevoluteJointDefInit()
{
    B2DRevoluteJointDef def;
    def.type = b2d_revoluteJoint;
    def.userData = NULL;
    def.bodyA = NULL;
    def.bodyB = NULL;
    def.collideConnected = NO;
    
    def.localAnchorA = B2DVec2Make(0, 0);
    def.localAnchorB = B2DVec2Make(0, 0);
    def.referenceAngle = 0.0;
    def.lowerAngle = 0.0;
    def.upperAngle = 0.0;
    def.maxMotorTorque = 0.0;
    def.motorSpeed = 0.0;
    def.enableLimit = NO;
    def.enableMotor = NO;
    
    return def;
}

@interface B2DRevoluteJoint : B2DJoint

@end
