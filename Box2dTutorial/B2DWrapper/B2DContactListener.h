//
//  B2DContactListener.h
//  Box2dTutorial
//
//  Created by Ben Trengrove on 24/01/13.
//  Copyright (c) 2013 Shiny Things. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "B2DFixture.h"

typedef void(^B2DContactListenerBlock)(void *userData1, void *userData2);

@interface B2DContactListener : NSObject
{
    
}

@property (strong, nonatomic) B2DContactListenerBlock beginContactBlock;
@property (strong, nonatomic) B2DContactListenerBlock endContactBlock;

- (void*)internalListener;

@end
