//
//  B2DWorld.m
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DWorld.h"
#import "B2DTypes.h"
#include "B2DHelper.h"

@interface B2DWorld()
{
    b2World *_world;
    NSMutableArray *_bodyList;
    NSMutableArray *_jointList;
}

@end

@implementation B2DWorld

#pragma mark - Init, Dealloc
- (id)initWithGravity:(B2DVec2)gravity
{
    if (self = [super init]) {
        b2Vec2 g = b2Vec2(gravity.x, gravity.y);
        _world = new b2World(g);
        
        _bodyList = [NSMutableArray array];
        _jointList = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    delete _world;
}

#pragma mark - Creation and Destruction
- (B2DBody*)createBody:(const B2DBodyDef *)bodyDef
{
    b2BodyDef def;
    def.type = (b2BodyType)bodyDef->type;
    def.position = B2DVecToCPlusPlus(bodyDef->position);
    def.angle = bodyDef->angle;
    def.linearVelocity = B2DVecToCPlusPlus(bodyDef->linearVelocity);
    def.linearDamping = bodyDef->linearDamping;
    def.angularDamping = bodyDef->angularDamping;
    def.allowSleep = bodyDef->allowSleep;
    def.awake = bodyDef->awake;
    def.fixedRotation = bodyDef->fixedRotation;
    def.bullet = bodyDef->bullet;
    def.active = bodyDef->active;
    def.userData = bodyDef->userData;
    def.gravityScale = bodyDef->gravityScale;
    
    b2Body *body = _world->CreateBody(&def);
    B2DBody *objCBody = [[B2DBody alloc] initWithB2Body:body];
    
    [_bodyList addObject:objCBody];
    return objCBody;
}

- (void)destoryBody:(B2DBody*)body
{
    b2Body *b = (b2Body*)[body b2Body];
    _world->DestroyBody(b);
    
    [_bodyList removeObject:body];
}

- (B2DJoint*)createJointOfType:(B2DJointType)type withDef:(const void *)voidDef
{
    b2RevoluteJointDef def;
    
    if (type == b2d_revoluteJoint) {
        B2DRevoluteJointDef *jointDef = (B2DRevoluteJointDef *)voidDef;
        def.type = (b2JointType)jointDef->type;
        def.bodyA = (b2Body*)[jointDef->bodyA b2Body];
        def.bodyB = (b2Body*)[jointDef->bodyB b2Body];
        def.collideConnected = jointDef->collideConnected;
        def.localAnchorA = B2DVecToCPlusPlus(jointDef->localAnchorA);
        def.localAnchorB = B2DVecToCPlusPlus(jointDef->localAnchorB);
        def.referenceAngle = jointDef->referenceAngle;
        def.enableLimit = jointDef->enableLimit;
        def.lowerAngle = jointDef->lowerAngle;
        def.upperAngle = jointDef->upperAngle;
        def.enableMotor = jointDef->enableMotor;
        def.motorSpeed = jointDef->motorSpeed;
        def.maxMotorTorque = jointDef->maxMotorTorque;
    }

    b2Joint *joint = _world->CreateJoint(&def);
    B2DJoint *objCJoint = [[B2DJoint alloc] initWithB2Joint:joint];
    [_jointList addObject:objCJoint];
    
    return objCJoint;
}

- (void)destroyJoint:(B2DJoint*)joint
{
    b2Joint *j = (b2Joint*)[joint b2Joint];
    _world->DestroyJoint(j);
    
    [_jointList removeObject:joint];
}


#pragma mark - World methods

- (void)stepWithDeltaTime:(double)dT velocityIterations:(int)velocityIterations positionIterations:(int)positionIterations
{
    _world->Step(dT, velocityIterations, positionIterations);
}

#pragma mark - Lists

- (NSArray*)bodyList
{
    return [NSArray arrayWithArray:_bodyList];
}

- (NSArray*)jointList
{
    return [NSArray arrayWithArray:_jointList];
}

#pragma mark - Properties

- (void)setContactListener:(B2DContactListener*)listener
{
    b2ContactListener *l = (b2ContactListener*)[listener internalListener];
    _world->SetContactListener(l);
}

- (void)setGravity:(B2DVec2)gravity
{
    _world->SetGravity(B2DVecToCPlusPlus(gravity));
}

- (B2DVec2)gravity
{
    b2Vec2 g = _world->GetGravity();
    return B2DVec2Make(g.x, g.y);
}

@end
