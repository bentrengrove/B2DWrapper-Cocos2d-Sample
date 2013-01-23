//
//  B2DHelper.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 22/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#ifndef Box2dTutorial_B2DHelper_h
#define Box2dTutorial_B2DHelper_h

#if defined __cplusplus
#include "Box2D.h"

static b2Vec2 B2DVecToCPlusPlus(B2DVec2 vec);
static inline b2Vec2 B2DVecToCPlusPlus(B2DVec2 vec)
{
    return b2Vec2(vec.x, vec.y);
}
#endif

#endif
