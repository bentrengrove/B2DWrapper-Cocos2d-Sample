//
//  B2DContactListener.m
//  Box2dTutorial
//
//  Created by Ben Trengrove on 24/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DContactListener.h"
#import "Box2D.h"

#pragma mark - C++ Implementation

class b2DInternalContactListener : private b2ContactListener
{
    B2DContactListener *_wrapper;
public:
    b2DInternalContactListener (B2DContactListener *objCContactListener);
    
    void BeginContact(b2Contact* contact);
    void EndContact(b2Contact* contact);
};

b2DInternalContactListener::b2DInternalContactListener( B2DContactListener *wrapper )
{
    _wrapper = wrapper;
}

void b2DInternalContactListener::BeginContact(b2Contact *contact)
{
    if (_wrapper.beginContactBlock) {
        void *userData1 = contact->GetFixtureA()->GetBody()->GetUserData();
        void *userData2 = contact->GetFixtureB()->GetBody()->GetUserData();
        
        _wrapper.beginContactBlock(userData1, userData2);
    }
}

void b2DInternalContactListener::EndContact(b2Contact *contact)
{
    if (_wrapper.endContactBlock) {
        void *userData1 = contact->GetFixtureA()->GetBody()->GetUserData();
        void *userData2 = contact->GetFixtureB()->GetBody()->GetUserData();
        
        _wrapper.endContactBlock(userData1, userData2);
    }
}

#pragma mark - Objective C Wrapper


@interface B2DContactListener()
{
    b2DInternalContactListener *_listener;
}

@end


@implementation B2DContactListener

- (id)init
{
    self = [super init];
    if (self) {
        _listener = new b2DInternalContactListener(self);
    }
    return self;
}

- (void*)internalListener
{
    return _listener;
}

@end
