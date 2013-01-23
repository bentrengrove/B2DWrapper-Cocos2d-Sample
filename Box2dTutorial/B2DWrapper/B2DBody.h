//
//  B2DBody.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "B2DTypes.h"
#import "B2DFixture.h"

typedef enum B2DBodyType
{
	B2D_staticBody = 0,
	B2D_kinematicBody,
	B2D_dynamicBody
    
	// TODO_ERIN
	//b2_bulletBody,
} B2DBodyType;

/// A body definition holds all the data needed to construct a rigid body.
/// You can safely re-use body definitions. Shapes are added to a body after construction.
typedef struct B2DBodyDef
{
	/// The body type: static, kinematic, or dynamic.
	/// Note: if a dynamic body would have zero mass, the mass is set to one.
	B2DBodyType type;
    
	/// The world position of the body. Avoid creating bodies at the origin
	/// since this can lead to many overlapping shapes.
	B2DVec2 position;
    
	/// The world angle of the body in radians.
	double angle;
    
	/// The linear velocity of the body's origin in world co-ordinates.
	B2DVec2 linearVelocity;
    
	/// The angular velocity of the body.
	double angularVelocity;
    
	/// Linear damping is use to reduce the linear velocity. The damping parameter
	/// can be larger than 1.0f but the damping effect becomes sensitive to the
	/// time step when the damping parameter is large.
	double linearDamping;
    
	/// Angular damping is use to reduce the angular velocity. The damping parameter
	/// can be larger than 1.0f but the damping effect becomes sensitive to the
	/// time step when the damping parameter is large.
	double angularDamping;
    
	/// Set this flag to false if this body should never fall asleep. Note that
	/// this increases CPU usage.
	bool allowSleep;
    
	/// Is this body initially awake or sleeping?
	bool awake;
    
	/// Should this body be prevented from rotating? Useful for characters.
	bool fixedRotation;
    
	/// Is this a fast moving body that should be prevented from tunneling through
	/// other moving bodies? Note that all bodies are prevented from tunneling through
	/// kinematic and static bodies. This setting is only considered on dynamic bodies.
	/// @warning You should use this flag sparingly since it increases processing time.
	bool bullet;
    
	/// Does this body start out active?
	bool active;
    
	/// Use this to store application specific body data.
	void* userData;
    
	/// Scale the gravity applied to this body.
	double gravityScale;
} B2DBodyDef;

static B2DBodyDef B2DBodyDefInit();
static inline B2DBodyDef B2DBodyDefInit()
{
    B2DBodyDef def;
    def.userData = NULL;
    def.position = B2DVec2Make(0.0, 0.0);
    def.angle = 0.0f;
    def.linearVelocity = B2DVec2Make(0.0, 0.0);
    def.angularVelocity = 0.0f;
    def.linearDamping = 0.0f;
    def.angularDamping = 0.0f;
    def.allowSleep = YES;
    def.awake = YES;
    def.fixedRotation = NO;
    def.bullet = NO;
    def.type = B2D_staticBody;
    def.active = YES;
    def.gravityScale = 1.0f;
    return def;
}

@interface B2DBody : NSObject
{
    
}

- (id)initWithB2Body:(void*)body;
- (void*)b2Body;
- (void)createFixture:(B2DFixtureDef)fixtureDef;
- (void*)userData;
- (B2DVec2)position;
- (double)angle;

@end
