//
//  B2DEdgeShape.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import "B2DShape.h"
#import "B2DTypes.h"

@interface B2DEdgeShape : B2DShape

- (id)initWithVecA:(B2DVec2)a andVecB:(B2DVec2)b;
- (void)setVecA:(B2DVec2)a andVecB:(B2DVec2)b;

@end
