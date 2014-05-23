//
//  MessageNode.m
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright 2011 Mobile_x. All rights reserved.
//

#import "MessageNode.h"
#import "GameScene.h"
@implementation MessageNode

// 각 메시지의 상수 선언으로 enum 타입으로 수정하여도 무방할 듯 함
int const MISS_MESSAGE = 0;
int const CORRECT_MESSAGE = 1;
int const BONUS_MESSAGE = 2;

@synthesize miss, correct, bonus;

-(id) init {
	self = [super init];
	if (self) {
		// 현재 노드에 miss, perfect, correct 스프라이트 노드를 자식 노드로 추가 
		CCSprite *m = [[CCSprite alloc] initWithFile:@"miss.png"];
		//[m setAnchorPoint:ccp(0,0)];
		self.miss = m;
		[m release];
		[self addChild:miss];
		
		CCSprite *c = [[CCSprite alloc] initWithFile:@"hit.png"];
		//[c setAnchorPoint:ccp(0,0)];
		self.correct = c;
		[c release];
		[self addChild:correct];
		
		CCSprite *b = [[CCSprite alloc] initWithFile:@"bonus.png"];
		//[c setAnchorPoint:ccp(0,0)];
		self.bonus = b;
		[b release];
		[self addChild:bonus];
		
		// 각각의 노드에 대한 위치는 화면의 중앙 상단으로 한다
		miss.position = ccp(240, 240);
		correct.position = ccp(240, 260);
		bonus.position = ccp(240, 260);
		
		// 최초 액션인데.. visible 속성으로 조정하는 것이 나을 듯. 
		[correct runAction:[CCFadeOut actionWithDuration:1.0]];
		[miss runAction:[CCFadeOut actionWithDuration:1.0]];
		[bonus runAction:[CCFadeOut actionWithDuration:1.0]];
	}
	
	return self;
}

// showMessage 메소드는 int를 매개변수로 받아서 각 스프라이트를 지역변수 sprite에 할당함.
- (void) showMessage:(int) message
{
	CCSprite *sprite;
	
	if(message == MISS_MESSAGE)
	{
		sprite = miss;
		missVisible = YES;
	}else if(message == CORRECT_MESSAGE)
	{
		sprite = correct;
		correctVisible = YES;
	}else if(message == BONUS_MESSAGE)
	{
		sprite = bonus;
		bonusVisible = YES;
	}
	
	// 짧은 순간에 opacity값을 0으로 만들어서 투명한 스피라이트를 만든다
	[sprite runAction:[CCFadeTo actionWithDuration:0.01 opacity:0]];
	// 순차적인 액션을 보여줌
	[sprite runAction:[CCSequence actions:
					   [CCFadeTo actionWithDuration:0.1 opacity:250],
					   [CCDelayTime actionWithDuration:0.2], 
					   [CCFadeTo actionWithDuration:0.1 opacity:0], 
					   nil]];

//	[sprite runAction:[CCSpawn actions:[CCFadeTo actionWithDuration:0.5 opacity:250],
//					   [CCMoveTo actionWithDuration:0.5 position:ccp(240, 900)], 
//					   nil]];
	
}

- (void) dealloc
{
	[correct release];
	[miss release];
	[bonus release];
	[super dealloc];
}

@end
