//
//  B2DFixture.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "B2DShape.h"

typedef struct m_B2DFixtureDef
{
	/// The shape, this must be set. The shape will be cloned, so you
	/// can create the shape on the stack.
    __unsafe_unretained B2DShape* shape;
    
	/// Use this to store application specific fixture data.
	void* userData;
    
	/// The friction coefficient, usually in the range [0,1].
	double friction;
    
	/// The restitution (elasticity) usually in the range [0,1].
	double restitution;
    
	/// The density, usually in kg/m^2.
	double density;
    
	/// A sensor shape collects contact information but never generates a collision
	/// response.
	BOOL isSensor;
    
	///TODO: Contact filtering data.
	//b2Filter filter;
} B2DFixtureDef;

static B2DFixtureDef B2DFixtureDefInit();
static inline B2DFixtureDef B2DFixtureDefInit()
{
    B2DFixtureDef def;
    def.shape = NULL;
    def.userData = NULL;
    def.friction = 0.2;
    def.restitution = 0.0;
    def.density = 0.0;
    def.isSensor = NO;
    
    return def;
}

@interface B2DFixture : NSObject

@end
