//
//  HelloWorldLayer.m
//  ActionNinja
//
//  Created by mac on 11. 5. 27..
//  Copyright Mobile_x 2011. All rights reserved.
//

// Import the interfaces
#import "GameScene.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"

@implementation Game

@synthesize layer = _layer;

- (id)init {
    if ((self = [super init])) {
        self.layer = [GameScene node];
		[self addChild:_layer];
    }
	return self;
}

- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}	

@end

#define IMG_WIDTH 1504

#define ENEMY_SPRITE_WIDTH 61
#define ENEMY_SPRITE_HEIGHT 60

enum  {
	kTag_Parallax,
	kTag_Parallax2,
	kTag_Parallax3,
	kTag_Parallax4
};

enum  {
	ztarget = 3,
	zplayer = 4,
	zprojectile = 5,
	kGameSceneTagScoreLabel = 6,
	kTagMessage = 7,
	kTagPause = 8,
};


@implementation GameScene

@synthesize targetChoice, scoreLabel, gameoverLabel, player, actualY, interval, message, LifeSprite, scoreNumSprite, PauseItem;


-(void)spriteMoveFinished:(id)sender {
	[self removeChild:LifeSprite cleanup:YES];
	
	if (Life > 0) {
		[sae playEffect:@"Wrong.wav"];
		[message showMessage:MISS_MESSAGE];
		id actionTo = [CCBlink actionWithDuration:0.5 blinks:3];
		[player runAction:actionTo];
	}
	Life -= 1;
	[self LifeLabel];
	[self.LifeSprite setContentSize:CGSizeMake(0, 0)];
	if (Life == -1) {
		Life = 0;
	}
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
	if (Life == 0) {
		[self unscheduleAllSelectors];
		[sae playEffect:@"Bye.mp3"];
		
		id actionSc = [CCRotateBy actionWithDuration:0.5 angle:540];
		id actionMo = [CCMoveBy actionWithDuration:0.5 position:ccp(0, -280)];
		[player runAction:[CCSequence actions:actionSc,  actionMo, nil]];
		
		self.isTouchEnabled = NO;
		[self performSelector:@selector(gameover) withObject:nil afterDelay:3.5];
	}
	
	
}

-(void)gameover
{
	GameOverScene *gameOverScene = [GameOverScene node];
	[[CCDirector sharedDirector] replaceScene:[CCTurnOffTilesTransition 
											   transitionWithDuration:1.5 
											   scene:gameOverScene]];
	[self removeAllChildrenWithCleanup:YES];	
}

-(void)addTarget {
	self.targetChoice = rand()%4;
	
	CCSpriteSheet *monsterSheet = [CCSpriteSheet spriteSheetWithFile:@"alienSpriteSheet.png" capacity:30];
	[self addChild:monsterSheet z:0 tag:0];
	
	CCAnimation *animation = [CCAnimation animationWithName:@"animation" delay:0.1f];
	CCSpriteFrame *frame = nil;
	if (targetChoice == 0) {
		enermy = [CCSprite spriteWithFile:@"alienSpriteSheet.png" 
									 rect:CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, 0, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT)];
		
		for (int y = 0; y<4; y++) {
			CGRect aRect = CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, ENEMY_SPRITE_HEIGHT*y, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT);
			frame = [CCSpriteFrame frameWithTexture:monsterSheet.texture rect:aRect offset:ccp(0,0)];
			[animation addFrame:frame];
		}
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
		[enermy runAction:repeat];
	}
	else if (targetChoice == 1) {
		enermy = [CCSprite spriteWithFile:@"alienSpriteSheet.png" 
									 rect:CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, 0, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT)];
		
		for (int y = 0; y<4; y++) {
			CGRect aRect = CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, ENEMY_SPRITE_HEIGHT*y, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT);
			frame = [CCSpriteFrame frameWithTexture:monsterSheet.texture rect:aRect offset:ccp(0,0)];
			[animation addFrame:frame];
		}
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
		[enermy runAction:repeat];
	}
	else if (targetChoice == 2) {
		enermy = [CCSprite spriteWithFile:@"alienSpriteSheet.png" 
									 rect:CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, 0, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT)];
		
		for (int y = 0; y<4; y++) {
			CGRect aRect = CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, ENEMY_SPRITE_HEIGHT*y, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT);
			frame = [CCSpriteFrame frameWithTexture:monsterSheet.texture rect:aRect offset:ccp(0,0)];
			[animation addFrame:frame];
		}
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
		[enermy runAction:repeat];
	} else if (targetChoice == 3) {
		enermy = [CCSprite spriteWithFile:@"alienSpriteSheet.png" 
									 rect:CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, 0, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT)];
		
		for (int y = 0; y<4; y++) {
			CGRect aRect = CGRectMake(ENEMY_SPRITE_WIDTH*targetChoice, ENEMY_SPRITE_HEIGHT*y, ENEMY_SPRITE_WIDTH, ENEMY_SPRITE_HEIGHT);
			frame = [CCSpriteFrame frameWithTexture:monsterSheet.texture rect:aRect offset:ccp(0,0)];
			[animation addFrame:frame];
		}
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
		[enermy runAction:repeat];
	}
	
	
	if (_projectilesDestroyed != 0 && _projectilesDestroyed % 180 == 0) {
		enermy = [CCSprite spriteWithFile:@"heart.png" rect:CGRectMake(0, 0, 50, 50)];
	}
	
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	//  고친 부분
	//	int minY = target.contentSize.height/2;
	//	int maxY = winSize.height - target.contentSize.height/2;
	//	int rangeY = maxY - minY;
	//	actualY = (arc4random() % rangeY) + minY;
	
	int minX = enermy.contentSize.width/2;
	int maxX = winSize.width - enermy.contentSize.width/2;
	int rangeX = maxX - minX;
	actualX = (arc4random() % rangeX) + minX;
	
	//int actualY = target.contentSize.height / 2;
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	//  고친 부분
	enermy.position = ccp(actualX, winSize.height + (enermy.contentSize.height/2));

	[self addChild:enermy z:ztarget tag:ztarget];
	
	// Determine speed of the target
	int minDuration = 2.0;
	int maxDuration = 4.0;
	int rangeDuration = maxDuration - minDuration;
	float actualDuration = (arc4random() % rangeDuration) + minDuration;
	int center = 240;
	// Create the actions actualY
	
	//  고친 부분
	id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(center, -enermy.contentSize.height/2 + 100)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	//id actionMovetwo = [CCSpawn actions:[CCFadeTo actionWithDuration:0.5 opacity:250],
//						[CCMoveTo actionWithDuration:actualDuration position:ccp(actualX, 1000)], nil];
	[enermy runAction:[CCSequence actions:actionMove,actionMoveDone, nil]];
	// Add to targets array
	enermy.tag = 1;
	
	[_targets addObject:enermy];
}

- (void)LifeLabel{
	LifeEG = 20;
	LifeSprite = [CCSprite spriteWithFile:@"life1.png" rect:CGRectMake(0, 0, LifeEG * Life, 20)];
	LifeSprite.anchorPoint = ccp(0,0);
	LifeSprite.position = CGPointMake(120, 290);
	[self addChild:LifeSprite z:20 tag:kTagMessage];
}

-(void)ninjaRunAction
{
	CCAnimation *animation = [CCAnimation animationWithName:@"ninjaRunning" delay:0.1f];	
	
	for (int i = 1; i <= 3; i ++) {
		[animation addFrameWithFilename:[NSString stringWithFormat:@"run_%d.png",i]];
	}
	
	id PlayerAction = [CCAnimate actionWithAnimation:animation];
	[player runAction:[CCRepeatForever actionWithAction:PlayerAction]];
	
}

-(void)gameLogic:(ccTime)dt
{
	[self addTarget];
}

-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		winSizeBG = [[CCDirector sharedDirector]winSize];
		[self createBackgroundParallax];
		
		message = [[MessageNode alloc]init];
		[self addChild:message z:20 tag:kTagMessage];
		
		// Enable touch events
		self.isTouchEnabled = YES;
		
		_targets = [[NSMutableArray alloc] init];
		_projectiles = [[NSMutableArray alloc] init];
		
		self.PauseItem = [CCMenuItemImage itemFromNormalImage:@"btn_pause.png" 
												selectedImage:@"btn_play.png" 
													   target:self 
													 selector:@selector(pauseGame:)];
		PauseItem.position = ccp(-220,-130);
		CCMenu *menu = [CCMenu menuWithItems: self.PauseItem,nil];
		[self addChild:menu z:kTagPause tag:kTagPause];
		Pause = NO;
		
		sae = [SimpleAudioEngine sharedEngine];
		[sae preloadEffect:@"bounus.wav"];
		[sae preloadEffect:@"Wrong.wav"];
		[sae preloadEffect:@"Bye.mp3"];
		[sae preloadEffect:@"background-music-aac.caf"];
		[sae preloadEffect:@"SpiderMan.wav"];
		
		// 고친 부분
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		player = [CCSprite spriteWithFile:@"run_1.png" rect:CGRectMake(0, 0, 68, 85)];
		player.position = ccp(winSize.width/2, player.contentSize.height/2 +2);
		[self ninjaRunAction];
		
		[self addChild:player z:zplayer tag:zplayer];
		
		CCSprite *scoreSprite = [CCSprite spriteWithFile:@"score.png" rect:CGRectMake(0, 0, 64, 21)];
		scoreSprite.anchorPoint = ccp(0,0);
		scoreSprite.position = CGPointMake(320, 290);
		[self addChild:scoreSprite z:kGameSceneTagScoreLabel tag:kGameSceneTagScoreLabel];
		
		CCSprite *LifeLabelSprite = [CCSprite spriteWithFile:@"gamelife.png" rect:CGRectMake(0, 0, 45, 21)];
		LifeLabelSprite.anchorPoint = ccp(0,0);
		LifeLabelSprite.position = CGPointMake(60, 290);
		[self addChild:LifeLabelSprite z:kGameSceneTagScoreLabel tag:kGameSceneTagScoreLabel];
		Life = 3;
		
		CCLabelAtlas *sco = [CCLabelAtlas labelAtlasWithString:@"0" 
												   charMapFile:@"score_number.png" 
													 itemWidth:20
													itemHeight:28 
												  startCharMap:'0'];
		self.scoreNumSprite = sco;
		[sco release];
		scoreNumSprite.position = ccp(400, 290);
		[self addChild:scoreNumSprite z:25 tag:kGameSceneTagScoreLabel];
		_projectilesDestroyed = 0;
		
		[self LifeLabel];
		srand(time(NULL));
		interval = 1.0;
		//		
        //[self gameLogic:interval];
		
        [self schedule:@selector(update:)];
        [self schedule:@selector(gameLogic:) interval:interval];
        
		[sae playBackgroundMusic:@"background-music-aac.caf" loop:YES];
		
		
		
	}
	return self;
}

- (void)update:(ccTime)dt {
	NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
	for (CCSprite *projectile in _projectiles) {
		
		CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2), 
										   projectile.position.y - (projectile.contentSize.height/2), 
										   projectile.contentSize.width, 
										   projectile.contentSize.height);
		
		NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
		for (CCSprite *target in _targets) {
			CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2), 
										   target.position.y - (target.contentSize.height/2), 
										   target.contentSize.width, 
										   target.contentSize.height);
			
			if (CGRectIntersectsRect(projectileRect, targetRect)) {
				if (target.contentSize.height == 50) {
					[message showMessage:BONUS_MESSAGE];
					[sae playEffect:@"bounus.wav"];
					[targetsToDelete addObject:target];
				}else {
					[message showMessage:CORRECT_MESSAGE];
					[targetsToDelete addObject:target];
				}
			}
		}
		
		for (CCSprite *target in targetsToDelete) {
			if (target.contentSize.height == 50) {
				[message showMessage:BONUS_MESSAGE];
				if (Life < 5) {
					Life++;
					[self removeChild:LifeSprite cleanup:YES];
					[self LifeLabel];
				}
			}
			id action1 = [CCRotateBy actionWithDuration:0.3 angle:720];
			id action2 = [CCSpawn actions:[CCFadeTo actionWithDuration:0.4 opacity:250],
						  [CCMoveTo actionWithDuration:0.4 position:ccp(240, 900)],nil];
			id action3 = [CCScaleBy actionWithDuration:0.5 scale:0.0];
			[target runAction:[CCSequence actions:
							  
							   action2, action1,
							   action3, nil]];
			[self performSelector:@selector(targetDelete:) withObject:target afterDelay:0.1];
			
			_projectilesDestroyed++;
			
			[scoreNumSprite setString:[NSString stringWithFormat:@"%d", _projectilesDestroyed]];
			
		}
		
		
		if (targetsToDelete.count > 0) {
			[projectilesToDelete addObject:projectile];
		}
		[targetsToDelete release];
	}
	
	for (CCSprite *projectile in projectilesToDelete) {
		[_projectiles removeObject:projectile];
		[self removeChild:projectile cleanup:YES];
	}
	[projectilesToDelete release];
}

- (void)targetDelete:(id)sender{
	CCSprite *target = sender;
	[_targets removeObject:target];
	[self removeChild:target cleanup:YES];
}

- (void)pauseGame:(id)sender {
	if (Pause == NO) {
		[[CCDirector sharedDirector] stopAnimation];
		Pause = YES;
		self.isTouchEnabled = NO;
	}else {
		[[CCDirector sharedDirector] startAnimation];
		Pause = NO;
		self.isTouchEnabled = YES;
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	CCAnimation *animation = [CCAnimation animationWithName:@"hit_1.png" delay:0.05f];	
	
	for (int i = 1; i <= 3; i++) {
		[animation addFrameWithFilename:[NSString stringWithFormat:@"hit_%d.png",i]];
	}
	
	id PlayerAction = [CCAnimate actionWithAnimation:animation];
	[player runAction:PlayerAction];
	
	UITouch *touch = [touches anyObject];
	CGPoint locations = [touch locationInView:[touch view]];
	CGPoint location = [[CCDirector sharedDirector] convertToGL:locations];
	
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	CCSprite *projectile = [CCSprite spriteWithFile:@"shuriken.png" rect:CGRectMake(0, 0, 35, 35)];
	projectile.position = ccp(winSize.width/2, 50);	//  고친 부분
	
	id projectileAction = [CCRotateBy actionWithDuration:0.2 angle:360];
	[projectile runAction:[CCRepeatForever actionWithAction:projectileAction]];
	
	int offX = location.x - projectile.position.x;
	int offY = location.y - projectile.position.y;
	
	
	if (offY <= 0) return;
    
    [self addChild:projectile z:zprojectile tag:zprojectile];
	
	[sae playEffect:@"SpiderMan.wav"];
	
	int realY = winSize.height + (projectile.contentSize.height/2);
	float ratio = (float) offX / (float) offY;
	int realX = (realY * ratio) + projectile.position.x;
	CGPoint realDest = ccp(realX, realY);
	
	int offRealX = realX - projectile.position.x;
	int offRealY = realY - projectile.position.y;
	float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
	float velocity = 480/1; // 480pixels/1sec
	float realMoveDuration = length/velocity;
	
	[projectile runAction:[CCSequence actions:
						   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
						   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
						   nil]];
	projectile.tag = 2;
	[_projectiles addObject:projectile];
	
}
- (void)createBackgroundParallax{
	
	CCSprite *bgSpriteMainBG = [CCSprite spriteWithFile:@"bg_play4.png"];
	bgSpriteMainBG.anchorPoint = ccp(0,0);
	CCParallaxNode *voidNode = [CCParallaxNode node];
	[voidNode addChild:bgSpriteMainBG z:0 parallaxRatio:ccp(1.0f,0) positionOffset:CGPointZero];
	
	[self addChild:voidNode z:kTag_Parallax tag:kTag_Parallax];
	
	CCSprite *bgSpriteMainBG2 = [CCSprite spriteWithFile:@"bg_play3.png"];
	bgSpriteMainBG2.anchorPoint = ccp(0,0);
	CCParallaxNode *voidNode2 = [CCParallaxNode node];
	[voidNode2 addChild:bgSpriteMainBG2 z:0 parallaxRatio:ccp(1.0f,0) positionOffset:CGPointZero];
	
	[self addChild:voidNode2 z:kTag_Parallax2 tag:kTag_Parallax2];
	
	CCSprite *bgSpriteMainBG3 = [CCSprite spriteWithFile:@"bg_play2.png"];
	bgSpriteMainBG3.anchorPoint = ccp(0,0);
	CCParallaxNode *voidNode3 = [CCParallaxNode node];
	[voidNode3 addChild:bgSpriteMainBG3 z:0 parallaxRatio:ccp(1.0f,0) positionOffset:CGPointZero];
	
	[self addChild:voidNode3 z:kTag_Parallax3 tag:kTag_Parallax3];
	
	CCSprite *bgSpriteMainBG4 = [CCSprite spriteWithFile:@"bg_play1.png"];
	bgSpriteMainBG4.anchorPoint = ccp(0,0);
	CCParallaxNode *voidNode4 = [CCParallaxNode node];
	[voidNode4 addChild:bgSpriteMainBG4 z:0 parallaxRatio:ccp(1.0f,0) positionOffset:CGPointZero];
	
	[self addChild:voidNode4 z:kTag_Parallax4 tag:kTag_Parallax4];
}

- (void)onEnter{
	[super onEnter];
	[self moveBackground];
}

- (void)moveBackground{
	CCNode *voidNode = [self getChildByTag:kTag_Parallax];
	
	//CGFloat duration = 8.5f;
	CGFloat duration = 6.0f;
	CGFloat xRatio = 1.0;
	id go = [CCMoveBy actionWithDuration:duration position:ccp(-(IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id back = [CCMoveBy actionWithDuration:0 position:ccp((IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id seq = [CCSequence actions:go, back, nil];
	[voidNode runAction:[CCRepeatForever actionWithAction:seq]];
	
	
	CCNode *voidNode2 = [self getChildByTag:kTag_Parallax2];
	
	id bg2 = [CCMoveBy actionWithDuration:duration position:ccp(-(IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id bgback2 = [CCMoveBy actionWithDuration:0 position:ccp((IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id seq2 = [CCSequence actions:bg2, bgback2, nil];
	[voidNode2 runAction:[CCRepeatForever actionWithAction:seq2]];
	
	CCNode *voidNode3 = [self getChildByTag:kTag_Parallax3];
	
	id bg3 = [CCMoveBy actionWithDuration:duration position:ccp(-(IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id bgback3 = [CCMoveBy actionWithDuration:0 position:ccp((IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id seq3 = [CCSequence actions:bg3, bgback3, nil];
	[voidNode3 runAction:[CCRepeatForever actionWithAction:seq3]];
	
	CCNode *voidNode4 = [self getChildByTag:kTag_Parallax4];
	
	id bg4 = [CCMoveBy actionWithDuration:duration position:ccp(-(IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id bgback4 = [CCMoveBy actionWithDuration:0 position:ccp((IMG_WIDTH - winSizeBG.width) / xRatio,0)];
	id seq4 = [CCSequence actions:bg4, bgback4, nil];
	[voidNode4 runAction:[CCRepeatForever actionWithAction:seq4]];
	
	
}

- (void) dealloc
{
	[PauseItem release];
	[_targets release];
	_targets = nil;
	[_projectiles release];
	_projectiles = nil;
	
	[super dealloc];
}

@end