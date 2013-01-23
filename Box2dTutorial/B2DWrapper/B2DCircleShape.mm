//
//  B2DCircleShape.m
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DCircleShape.h"
#include "Box2D.h"

@interface B2DCircleShape()
{
    b2CircleShape _shape;
}

@end

@implementation B2DCircleShape

- (id)init
{
    self = [super init];
    if (self) {
        _shape = b2CircleShape();
    }
    return self;
}

- (double)radius
{
    return _shape.m_radius;
}

- (void)setRadius:(double)radius
{
    _shape.m_radius = radius;
}

- (void*)b2Shape
{
    return &_shape;
}

@end
