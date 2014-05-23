//
//  MenuScene.m
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright 2011 Mobile_x. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
#import "HowToScene.h"

@implementation MenuScene

enum {
    kTagBackground = 0,
    kTagMenu = 1
};

@synthesize newGameMenuItem, aboutMenuItem, OpenFeintMenuItem, Ninjaimage,Title;

- (id) init {
	if( (self=[super init]) ) {
		oriented = 0;
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg_main.png"];        
        bgSprite.anchorPoint = CGPointZero;
        [bgSprite setPosition: ccp(0, 0)];
        [self addChild:bgSprite z:kTagBackground tag:kTagBackground];
        
		self.newGameMenuItem = [CCMenuItemImage itemFromNormalImage:@"btn_start.png" 
                                                          selectedImage:@"btn_start_s.png" 
                                                                 target:self 
                                                               selector:@selector(newGameMenuCallback:)];
		newGameMenuItem.position = ccp(-500,50);
        
		id action = [CCMoveTo actionWithDuration:1 position:ccp(140,0)];
		id action2 = [CCEaseIn actionWithAction:action rate:2];
		id action3 = [CCMoveTo actionWithDuration:.2 position:ccp(130,0)];
		id action4 = [CCEaseOut actionWithAction:action3 rate:5];
        id scaleUpDown = [CCCallFuncN actionWithTarget:self 
                                                  selector:@selector(scaleUpMove:)];

		id action5 = [CCSequence actions:action2,action4, action2,
                      scaleUpDown, nil];
		[newGameMenuItem runAction:action5];
		
        self.aboutMenuItem       = [CCMenuItemImage itemFromNormalImage:@"btn_howto.png" 
                                                          selectedImage:@"btn_howto_s.png" 
                                                                 target:self 
                                                               selector:@selector(aboutMenuCallback:)];
		
		aboutMenuItem.position = ccp(-500,-60);
		id aboutaction = [CCMoveTo actionWithDuration:1.2 position:ccp(140,-60)];
		id aboutaction2 = [CCEaseIn actionWithAction:aboutaction rate:2];
		id aboutaction3 = [CCMoveTo actionWithDuration:.2 position:ccp(130,-60)];
		id aboutaction4 = [CCEaseOut actionWithAction:aboutaction3 rate:4];
		id aboutaction5 = [CCSequence actions:aboutaction2,aboutaction4, aboutaction2,
                           scaleUpDown,nil];
        [aboutMenuItem runAction:aboutaction5];
		
		
		self.OpenFeintMenuItem       = [CCMenuItemImage itemFromNormalImage:@"btn_openfeint.png" 
															  selectedImage:@"btn_openfeint_s.png" 
																	 target:self 
																   selector:nil];
		
		OpenFeintMenuItem.position = ccp(180,-200);
		id OpenFeintaction = [CCMoveTo actionWithDuration:1 position:ccp(180,-120)];
		id OpenFeintaction2 = [CCEaseIn actionWithAction:OpenFeintaction rate:2];
		id OpenFeintaction3 = [CCMoveTo actionWithDuration:.2 position:ccp(180,-120)];
		id OpenFeintaction4 = [CCEaseOut actionWithAction:OpenFeintaction3 rate:5];
		id OpenFeintaction5 = [CCSequence actions:OpenFeintaction2,OpenFeintaction4, OpenFeintaction2,nil];
		[OpenFeintMenuItem runAction:OpenFeintaction5];
		
		self.Ninjaimage          = [CCMenuItemImage itemFromNormalImage:@"ninja.png" 
														   selectedImage:@"ninja.png" 
																  target:self 
																selector:nil];
		
		Ninjaimage.position = ccp(-500,-100);
		id Ninjaaction = [CCMoveTo actionWithDuration:1 position:ccp(-140,-40)];
		id Ninjaaction2 = [CCEaseIn actionWithAction:Ninjaaction rate:2];
		id Ninjaaction3 = [CCMoveTo actionWithDuration:.2 position:ccp(-160,-40)];
		id Ninjaaction4 = [CCEaseOut actionWithAction:Ninjaaction3 rate:5];
        id moveUpDown = [CCCallFuncN actionWithTarget:self 
                                              selector:@selector(moveUpDown:)];
		id Ninjaaction5 = [CCSequence actions:Ninjaaction2,Ninjaaction4, Ninjaaction2,moveUpDown, nil];
		[Ninjaimage runAction:Ninjaaction5];
        
		self.Title          = [CCMenuItemImage itemFromNormalImage:@"title.png" 
														  selectedImage:@"title.png" 
																 target:self 
															   selector:nil];
		
		
		Title.position = ccp(100,300);
		id Titleaction = [CCMoveTo actionWithDuration:1 position:ccp(120,90)];
		id Titleaction2 = [CCEaseIn actionWithAction:Titleaction rate:2];
		id Titleaction3 = [CCMoveTo actionWithDuration:.2 position:ccp(100,90)];
		id Titleaction4 = [CCEaseOut actionWithAction:Titleaction3 rate:5];
		id Titleaction5 = [CCSequence actions:Titleaction2,Titleaction4, Titleaction2,nil];
		[Title runAction:Titleaction5];

		
		CCMenu *menu = [CCMenu menuWithItems: self.newGameMenuItem,
						self.aboutMenuItem,self.Ninjaimage,self.Title,
						//self.OpenFeintMenuItem,
						nil];
        [self addChild:menu z:kTagMenu tag:kTagMenu];	

	}
	return self;
}

// 메뉴가 최종적으로 아래위로 움직이는 애니메이션을 위한 메소드
-(void) moveUpDown:(id)sender withOffset:(int)offset
{
	// CCMoveBy에 의해 상대적인 위치로 이동한다
	id moveUp = [CCMoveBy actionWithDuration:0.9 position:ccp(offset, 0)];
	id moveDown = [CCMoveBy actionWithDuration:0.9 position:ccp(-offset, 0)];
	// 아래위 움직임을 반복한다
	id moveUpDown = [CCSequence actions:moveUp, moveDown, nil];
	
	[sender runAction:[CCRepeatForever actionWithAction:moveUpDown]];	
}

-(void)moveUpDown:(id)sender
{
	//	NSLog(@"menuMove1 sender=%@", sender);
	[self moveUpDown:sender withOffset:60];
}

-(void)scaleUpMove:(id)sender
{
	//	NSLog(@"menuMove1 sender=%@", sender);
    //	[self menuMoveUpDown:sender withOffset:12];
	// CCMoveBy에 의해 상대적인 위치로 이동한다
	id scaleDown = [CCScaleTo actionWithDuration:0.9 scale:0.8];
	id scaleUp = [CCEaseBackOut actionWithAction:[CCScaleTo 
                                                  actionWithDuration:0.3 
                                                  scale:1.0]];
	// 아래위 움직임을 반복한다
	id scaleUpDown = [CCSequence actions:
					  [CCDelayTime actionWithDuration:3.0],
					  scaleDown, scaleUp, scaleDown, scaleUp, nil];
	
	[sender runAction:[CCRepeatForever actionWithAction:scaleUpDown]];	
}

- (void) newGameMenuCallback: (id) sender {
	GameScene *scene = [GameScene node];
	[[CCDirector sharedDirector] replaceScene:[CCFlipXTransition transitionWithDuration:1.0 scene:scene orientation:oriented]];
}

- (void) aboutMenuCallback: (id) sender {
	HowToScene *HTScene = [HowToScene node];
	[[CCDirector sharedDirector] replaceScene:[CCFadeDownTransition transitionWithDuration:1.5 scene:HTScene]];
}

- (void) dealloc {
    [newGameMenuItem	release];
    [aboutMenuItem		release];
	[OpenFeintMenuItem  release];
	[Ninjaimage         release];
    [super dealloc];
}

@end
