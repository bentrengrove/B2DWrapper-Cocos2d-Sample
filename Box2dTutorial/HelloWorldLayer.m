//
//  HelloWorldLayer.mm
//  Box2dTutorial
//
//  Created by Ben Trengrove on 21/01/13.
//  Copyright Shiny Things 2013. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"

#include "Box2D.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@interface HelloWorldLayer()
{
    b2World *_world;
    b2Body *_body;
}
@end

@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)createBallAtPosition:(CGPoint)pt
{
    CCSprite *ball = [CCSprite spriteWithFile:@"Ball.png" rect:CGRectMake(0, 0, 52, 52)];
    ball.position = ccp(pt.x, pt.y);
    [self addChild:ball];
    
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(pt.x/PTM_RATIO, pt.y/PTM_RATIO);
    ballBodyDef.userData = (__bridge void*) ball;
    _body = _world->CreateBody(&ballBodyDef);
    
    float scale = arc4random_uniform(100)/100.0f;
    ball.scale = scale;
    
    b2CircleShape circle;
    circle.m_radius = (26.0*scale)/PTM_RATIO;
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.2f;
    ballShapeDef.restitution = 0.8f;
    _body->CreateFixture(&ballShapeDef);
}

-(id) init
{
	if( (self=[super init])) {
#if defined __cplusplus
        NSLog(@"C Plus Plus!");
#endif
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        b2Vec2 gravity = b2Vec2(0.0f, -30.0f);
        _world = new b2World(gravity);
        
        b2BodyDef groundBodyDef;
        groundBodyDef.position.Set(0, 0);
        b2Body *groundBody = _world->CreateBody(&groundBodyDef);
        
        b2EdgeShape groundEdge;
        b2FixtureDef boxShapeDef;
        
        boxShapeDef.shape = &groundEdge;
        
        groundEdge.Set(b2Vec2(0, 0), b2Vec2(winSize.width/PTM_RATIO, 0));
        groundBody->CreateFixture(&boxShapeDef);
        
        groundEdge.Set(b2Vec2(0,0), b2Vec2(0, winSize.height/PTM_RATIO));
        groundBody->CreateFixture(&boxShapeDef);
        
        groundEdge.Set(b2Vec2(0, winSize.height/PTM_RATIO),
                       b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO));
        groundBody->CreateFixture(&boxShapeDef);
        
        groundEdge.Set(b2Vec2(winSize.width/PTM_RATIO,
                              winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO, 0));
        groundBody->CreateFixture(&boxShapeDef);
        
        [self createBallAtPosition:ccp(100, 100)];
        
        [self schedule:@selector(tick:)];
        
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled = YES;
	}
	return self;
}

- (void)tick:(ccTime)dT
{
    _world->Step(dT, 10, 10);
    for (b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (__bridge CCSprite*)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
            //ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }
    }
}

- (void)dealloc {
    delete _world;
    _body = NULL;
    _world = NULL;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    // Landscape left values
    b2Vec2 gravity(acceleration.y * 15, -acceleration.x *15);
    _world->SetGravity(gravity);
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self createBallAtPosition:location];
}
@end
