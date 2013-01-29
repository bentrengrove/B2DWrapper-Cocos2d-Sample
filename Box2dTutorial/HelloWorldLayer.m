//
//  HelloWorldLayer.mm
//  Box2dTutorial
//
//  Created by Ben Trengrove on 21/01/13.
//  Copyright Shiny Things 2013. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"

#import "B2DWrapper.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@interface HelloWorldLayer()
{
    B2DWorld *_world;
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

- (B2DBody*)createBallAtPosition:(CGPoint)pt
{
    float scale = arc4random_uniform(100)/100.0f + 0.25;
    CCSprite *ball = [CCSprite spriteWithFile:@"Ball.png" rect:CGRectMake(0, 0, 52, 52)];
    ball.position = ccp(pt.x, pt.y);
    ball.scale = scale;
    ball.userObject = [NSString stringWithFormat:@"Ball%.2f", scale];
    [self addChild:ball];
    
    B2DBodyDef ballBodyDef = B2DBodyDefInit();
    ballBodyDef.type = B2D_dynamicBody;
    ballBodyDef.position = B2DVec2Make(pt.x/PTM_RATIO, pt.y/PTM_RATIO);
    ballBodyDef.userData = (__bridge void*) ball;
    
    B2DBody *body = [_world createBody:&ballBodyDef];

    B2DCircleShape *circle = [[B2DCircleShape alloc] init];
    circle.radius = (26.0*scale)/PTM_RATIO;
    
    B2DFixtureDef ballShapeDef = B2DFixtureDefInit();
    ballShapeDef.shape = circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.2f;
    ballShapeDef.restitution = 0.5f;
    [body createFixture:ballShapeDef];
    
    return body;
}

- (B2DBody*)createBoxAtPosition:(CGPoint)pt
{
    float scale = arc4random_uniform(100)/100.0f + 0.25;
    CCSprite *box = [CCSprite spriteWithFile:@"Box.png"];
    box.position = ccp(pt.x, pt.y);
    box.scale = scale;
    box.userObject = [NSString stringWithFormat:@"Box%.2f", scale];
    [self addChild:box];
    
    B2DBodyDef ballBodyDef = B2DBodyDefInit();
    ballBodyDef.type = B2D_dynamicBody;
    ballBodyDef.position = B2DVec2Make(pt.x/PTM_RATIO, pt.y/PTM_RATIO);
    ballBodyDef.userData = (__bridge void*) box;
    
    B2DBody *body = [_world createBody:&ballBodyDef];
    
    B2DPolygonShape *boxShape = [[B2DPolygonShape alloc] init];
    [boxShape setAsBoxWithHalfWidth:(25.0 * scale)/PTM_RATIO halfHeight:(25.0 * scale)/PTM_RATIO];
    
    B2DFixtureDef boxShapeDef = B2DFixtureDefInit();
    boxShapeDef.shape = boxShape;
    boxShapeDef.density = 1.0f;
    boxShapeDef.friction = 0.2f;
    boxShapeDef.restitution = 0.5f;
    [body createFixture:boxShapeDef];
    
    return body;
}

-(id) init
{
	if( (self=[super init])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        B2DVec2 gravity = B2DVec2Make(0.0, -30.0f);
        _world = [[B2DWorld alloc] initWithGravity:gravity];
        
        B2DBodyDef groundBodyDef = B2DBodyDefInit();
        groundBodyDef.position = B2DVec2Make(0, 0);
        B2DBody *groundBody = [_world createBody:&groundBodyDef];
        
        B2DEdgeShape *groundEdge = [[B2DEdgeShape alloc] init];
        B2DFixtureDef boxShapeDef = B2DFixtureDefInit();
        
        boxShapeDef.shape = groundEdge;
        
        [groundEdge setVecA:B2DVec2Make(0, 0) andVecB:B2DVec2Make(winSize.width/PTM_RATIO, 0)];
        [groundBody createFixture:boxShapeDef];
        
        [groundEdge setVecA:B2DVec2Make(0, 0) andVecB:B2DVec2Make(0, winSize.height/PTM_RATIO)];
        [groundBody createFixture:boxShapeDef];
        
        [groundEdge setVecA:B2DVec2Make(0, winSize.height/PTM_RATIO) andVecB:B2DVec2Make(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO)];
        [groundBody createFixture:boxShapeDef];
        
        [groundEdge setVecA:B2DVec2Make(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO) andVecB:B2DVec2Make(winSize.width/PTM_RATIO, 0)];
        [groundBody createFixture:boxShapeDef];

        [self createBoxAtPosition:ccp(100, 100)];
        
        [self schedule:@selector(tick:)];
        
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled = YES;
        
        B2DContactListener *listener = [[B2DContactListener alloc] init];
        listener.beginContactBlock = ^(void *userData1, void *userData2) {
            if (userData1 && userData2) {
                CCSprite *body1 = (__bridge CCSprite*)userData1;
                CCSprite *body2 = (__bridge CCSprite*)userData2;
                NSLog(@"Begin contact with %@ & %@", body1.userObject, body2.userObject);
            }
        };
        listener.endContactBlock = ^(void *userData1, void *userData2) {
            if (userData1 && userData2) {
                CCSprite *body1 = (__bridge CCSprite*)userData1;
                CCSprite *body2 = (__bridge CCSprite*)userData2;
                NSLog(@"End contact with %@ & %@", body1.userObject, body2.userObject);
            }
        };
        [_world setContactListener:listener];
	}
	return self;
}

- (void)tick:(ccTime)dT
{
    [_world stepWithDeltaTime:dT velocityIterations:10 positionIterations:10];
    for (B2DBody *b in [_world bodyList]) {
        if ([b userData]) {
            CCSprite *ballData = (__bridge CCSprite*)[b userData];
            B2DVec2 position = [b position];
            ballData.position = ccp(position.x * PTM_RATIO, position.y * PTM_RATIO);
            ballData.rotation = CC_RADIANS_TO_DEGREES([b angle]);
        }
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    // Landscape left values
    B2DVec2 gravity = B2DVec2Make(acceleration.y * 15, -acceleration.x * 15);
    [_world setGravity:gravity];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self createBallAtPosition:location];
}
@end
