//
//  B2DJoint.m
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DJoint.h"
#include "Box2D.h"

@interface B2DJoint()
{
    b2Joint *_joint;
}

@end

@implementation B2DJoint

- (id)initWithB2Joint:(void*)joint
{
    self = [super init];
    if (self) {
        _joint = (b2Joint*)joint;
    }
    return self;
}

- (void*)b2Joint
{
    return _joint;
}

- (void)dealloc
{
    _joint = NULL;
}

@end
