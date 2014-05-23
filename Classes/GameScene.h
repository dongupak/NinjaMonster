//
//  HelloWorldLayer.h
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright Mobile_x 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "MessageNode.h"
#import "SimpleAudioEngine.h"

@interface GameScene : CCColorLayer {
	
	NSMutableArray *_targets;
	NSMutableArray *_projectiles;
	
	int _projectilesDestroyed;
	int Life;
	int LifeEG;
	int targetChoice;
	int actualX;
	int actualY;
	float interval;
	
	MessageNode *message;
	CCSprite *player;
	CCSprite *LifeSprite;
	CCSprite *PowerProjectiles;
	CCSprite *enermy;
	
	CCLabelAtlas *scoreLabel;
	CCLabel *gameoverLabel;
	CCLabelAtlas *scoreNumSprite;
	CGSize winSizeBG;
	
	CCMenuItem *PauseItem;
	SimpleAudioEngine *sae;
	
	BOOL Pause;
}

@property (nonatomic, retain) CCMenuItem *PauseItem;
@property (nonatomic, retain) MessageNode *message;
@property (nonatomic, retain) CCLabelAtlas *scoreLabel;
@property (nonatomic, retain) CCLabel *gameoverLabel;
@property (nonatomic, retain) CCLabelAtlas *scoreNumSprite;
@property (nonatomic, retain) CCSprite *player;
@property (nonatomic, retain) CCSprite *LifeSprite;
@property (nonatomic, readwrite) int targetChoice;
@property (nonatomic, readwrite) int actualY;
@property (nonatomic, readwrite) float interval;

- (void)createBackgroundParallax;
- (void)moveBackground;
- (void)LifeLabel;
- (void)gameover:(id)sender;
-(void)gameover;

@end

@interface Game : CCScene {
    Game *_layer;
}

@property (nonatomic, retain) Game *layer;

@end
