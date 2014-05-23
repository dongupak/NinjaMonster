//
//  GameOverScene.h
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright 2011 Mobile_x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCColorLayer {
	CCLabel *_label;
	CCMenuItem *MainGoItem;

}

@property (nonatomic, retain) CCLabel *label;
@property (nonatomic, retain) CCMenuItem *MainGoItem;

@end

@interface GameOverScene : CCScene {
	GameOverLayer *_layer;
		
}


@property (nonatomic, retain) GameOverLayer *layer;


@end
