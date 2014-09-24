//
//  MainScene.m
//  PROJECTNAME
//
//  Created by @cocojoe on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "chipmunk/chipmunk_unsafe.h"

#define SCALE_MODIFIER 0.1f

@implementation MainScene {
    CCPhysicsNode* _physicsNode;
    CCNode* _box;
}

- (void)didLoadFromCCB {
    _physicsNode.debugDraw = YES;
    _physicsNode.collisionDelegate = self;
}

- (void)scaleUp {
    [self scaleBox:SCALE_MODIFIER];
}

- (void)scaleDown {
    [self scaleBox:-SCALE_MODIFIER];
}

- (void)reset {
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainScene"]];
}

- (void) add {
    CCNode* newBox = [CCBReader load:@"physicsbox"];
    newBox.position = _box.position;
    [_physicsNode addChild:newBox];
}

- (void)scaleBox:(float)scale {
     CCLOG(@"Scale Box: %f",scale);
    _box.scale+=scale;

    for(ChipmunkCircleShape* shape in [_box.physicsBody chipmunkObjects]) {
        CCLOG(@"Physics Object: %@",shape);

        if([shape isKindOfClass:[ChipmunkCircleShape class]]) {

            cpCircleShapeSetRadius([shape shape],_box.boundingBox.size.width*0.5f);
            cpCircleShapeSetOffset([shape shape],_box.anchorPointInPoints);
        }
        
    }

}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair smallbox:(CCNode *)block bigbox:(CCNode *)item {
    CCLOG(@"Collision!");
    return YES;
}

@end
