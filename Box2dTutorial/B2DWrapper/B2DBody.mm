//
//  B2DBody.m
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DBody.h"
#import "Box2D.h"
#import "B2DFixture.h"

@interface B2DBody()
{
    b2Body *_body;
}

@end

@implementation B2DBody

- (id)initWithB2Body:(void*)body
{
    self = [super init];
    if (self) {
        _body = (b2Body*)body;
    }
    return self;
}

- (void)createFixture:(B2DFixtureDef)fixtureDef
{
    b2FixtureDef def;
    def.shape = (const b2Shape*)[fixtureDef.shape b2Shape];
    def.userData = fixtureDef.userData;
    def.friction = fixtureDef.friction;
    def.restitution = fixtureDef.restitution;
    def.density = fixtureDef.density;
    def.isSensor = fixtureDef.isSensor;
    
    //TODO: Filter
    //def.filter = fixtureDef.filter;
    
    _body->CreateFixture(&def);
}

- (void*)b2Body
{
    return _body;
}

- (void*)userData
{
    return _body->GetUserData();
}

- (B2DVec2)position
{
    return B2DVec2Make(_body->GetPosition().x, _body->GetPosition().y);
}

- (double)angle
{
    return _body->GetAngle();
}

- (void)dealloc
{
    _body = NULL;
}

@end
