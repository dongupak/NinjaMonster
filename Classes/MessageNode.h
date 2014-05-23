//
//  MessageNode.h
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright 2011 Mobile_x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// miss, perfect, correct 정보를 보여주는 메시지 노드 
@interface MessageNode : CCNode
{
	// 각각의 정보를 보여주기 위한 스프라이트 노드의 사용 
	CCSprite *miss;
	CCSprite *correct;
	CCSprite *bonus;
	
	BOOL missVisible;
	BOOL correctVisible;
	BOOL bonusVisible;
}

// 각 메시지 정보의 상수선언 
extern int const MISS_MESSAGE;
extern int const CORRECT_MESSAGE;
extern int const BONUS_MESSAGE;

@property (nonatomic, retain) CCSprite *miss;
@property (nonatomic, retain) CCSprite *correct;
@property (nonatomic, retain) CCSprite *bonus;

-(void)showMessage:(int) message;

@end

