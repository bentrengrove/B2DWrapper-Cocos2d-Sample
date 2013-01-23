//
//  B2DEdgeShape.m
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DEdgeShape.h"
#import "B2DTypes.h"
#include "Box2D.h"
#import "B2DHelper.h"

@interface B2DEdgeShape()
{
    b2EdgeShape _shape;
}

@end

@implementation B2DEdgeShape

- (id)init
{
    self = [super init];
    if (self) {
        _shape = b2EdgeShape();
    }
    return self;
}

- (id)initWithVecA:(B2DVec2)a andVecB:(B2DVec2)b
{
    self = [self init];
    [self setVecA:a andVecB:b];

    return self;
}

- (void)setVecA:(B2DVec2)a andVecB:(B2DVec2)b
{
    _shape.Set(B2DVecToCPlusPlus(a), B2DVecToCPlusPlus(b));
}

- (void*)b2Shape
{
    return &_shape;
}

@end
