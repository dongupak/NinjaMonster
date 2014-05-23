//
//  GameOverScene.m
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright 2011 Mobile_x. All rights reserved.
//

#import "GameOverScene.h"
#import "MenuScene.h"

@implementation GameOverScene

@synthesize layer = _layer;


- (id)init {
	if ((self = [super init])) {
		NSLog(@"3");
		self.layer = [GameOverLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {
	[_layer release];
	_layer = nil;
	[super dealloc];
}

@end

@implementation GameOverLayer

enum {
    kTagBackground = 0,
	kTagMenu = 1
};

@synthesize label = _label;
@synthesize MainGoItem;

-(id) init {
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		
		[[CCTextureCache sharedTextureCache] removeUnusedTextures];
		CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg_gameover.png"];
		bgSprite.anchorPoint = CGPointZero;
		[bgSprite setPosition: ccp(0, 0)];
		[self addChild:bgSprite z:kTagBackground tag:kTagBackground];


		CCSprite *player = [CCSprite spriteWithFile:@"dead.png" rect:CGRectMake(0, 0, 208, 266)];
		player.position = ccp(240, 130);
		[self addChild:player z:2 tag:2];
	
		
		[[CCTextureCache sharedTextureCache] removeUnusedTextures];

		self.MainGoItem = [CCMenuItemImage itemFromNormalImage:@"btn_white.png" 
												 selectedImage:@"btn_white.png" 
														target:self 
													  selector:@selector(gameOverDone:)];
		
		CCMenu *menu = [CCMenu menuWithItems: MainGoItem, nil];
        menu.position = CGPointMake(160, 240);
		[self addChild:menu z:kTagMenu tag:kTagMenu];		


		

	}	
	return self;
}



- (void)gameOverDone:(id)sender {
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	MenuScene *menuScene = [MenuScene node];
	[[CCDirector sharedDirector] replaceScene:[CCTurnOffTilesTransition transitionWithDuration:0.5 scene:menuScene]];
}

- (void)dealloc {
	[_label release];
	_label = nil;
	[super dealloc];
}

@end
