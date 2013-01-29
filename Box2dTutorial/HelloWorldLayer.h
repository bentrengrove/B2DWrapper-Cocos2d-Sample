//
//  HelloWorldLayer.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 21/01/13.
//  Copyright Shiny Things 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
