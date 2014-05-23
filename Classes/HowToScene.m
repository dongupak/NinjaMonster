//
//  HowToScene.m
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright 2011 Mobile_x. All rights reserved.
//

#import "HowToScene.h"
#import "MenuScene.h"

enum {
    kTagBackground = 0,
	kTagMenu = 1
};

@implementation HowToScene

@synthesize MainGoItem;

-(id) init{
	if( (self=[super init]) ) {
		CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg_howto.png"];        
        bgSprite.anchorPoint = CGPointZero;
        [bgSprite setPosition: ccp(0, 0)];
		[self addChild:bgSprite z:kTagBackground tag:kTagBackground];
		self.MainGoItem = [CCMenuItemImage itemFromNormalImage:@"btn_white.png" 
												 selectedImage:@"btn_white.png" 
														target:self 
													  selector:@selector(maingo:)];
		
		CCMenu *menu = [CCMenu menuWithItems: MainGoItem, nil];
        menu.position = CGPointMake(160, 240);
		[self addChild:menu z:kTagMenu tag:kTagMenu];
	}
	return self;
}

-(void)maingo:(id)sender{
	MenuScene *menuScene = [MenuScene node];
	[[CCDirector sharedDirector] replaceScene:[CCFadeDownTransition transitionWithDuration:1.5 scene:menuScene]];
}

- (void)dealloc {
	[MainGoItem release];
	[super dealloc];
}

@end