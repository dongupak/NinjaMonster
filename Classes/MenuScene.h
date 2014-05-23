//
//  MenuScene.h
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright 2011 Mobile_x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuScene : CCScene {
	CCMenuItem *newGameMenuItem; //Game시작 버튼
    CCMenuItem *aboutMenuItem;	 //about 버튼
	CCMenuItem *OpenFeintMenuItem;
	CCMenuItem *Ninjaimage;
	CCMenuItem *Title;
	int oriented;
}

@property (nonatomic, retain) CCMenuItem *newGameMenuItem;
@property (nonatomic, retain) CCMenuItem *aboutMenuItem;
@property (nonatomic, retain) CCMenuItem *OpenFeintMenuItem;
@property (nonatomic, retain) CCMenuItem *Ninjaimage;
@property (nonatomic, retain) CCMenuItem *Title;

@end