//
//  Mothership.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Mothership.h"
#import "GameScene.h"

#define MAX_SHIELD_ACTIVATIONS 3

@interface Mothership ()

@property (nonatomic, assign) int shieldActivations;
@property (nonatomic, assign) SKSpriteNode *shieldNode;

@end

@implementation Mothership

- (id) initWithLife:(float)life
{
    self = [super initWithImageNamed:@"MotherShip"];

    _wholeLife = life;
    _lifeLeft = life;
    
    _dying = NO;
    
    _shieldActivations = 0;
    
    _lifePercentage = [NSNumber numberWithFloat:100];
    
    self.position = CGPointMake(50, 160);
    self.zPosition = 10;
    
    [self addBodyToMothership];
    [self addBurst];
        
    return self;
}

// This methond is getting called when the user moves the ship with his finger
// We do not want the ship to be higher than 280, because in that area we have our health bar an other stuff
// TODO: Limit the position on the bottom?
- (void) moveToY:(int)yCoord
{
    int y;
    y = yCoord;
    
    if (yCoord > 280){
        y=280;
    }
    
    [self setPosition:CGPointMake(self.position.x, y)];
}


- (void) addBodyToMothership
{
    CGMutablePathRef diamondPath = CGPathCreateMutable();
    CGPathMoveToPoint(diamondPath, NULL, -20, 0);
    CGPathAddLineToPoint(diamondPath, NULL, -5, 20);
    CGPathAddLineToPoint(diamondPath, NULL, 20, 0);
    CGPathAddLineToPoint(diamondPath, NULL, -5, -20);
    
    self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:diamondPath];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cShip];
    self.physicsBody.contactTestBitMask =   [Categories getCategoryBitMask:cEnemy] |
                                            [Categories getCategoryBitMask:cEnemyProjectile] |
                                            [Categories getCategoryBitMask:cMeteor];
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}


- (void) addBurst
{
    //adding the smokeTrail
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"mothershipBurst" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(-20, 0);
    [self addChild:smokeTrail];
}


- (void) mothershipGotHitWithDamage:(float)damage
{    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    //[self vibrate];
    
    _lifeLeft = _lifeLeft - damage;
    [self setLifePercentage:[NSNumber numberWithFloat:100*_lifeLeft/_wholeLife]];
    if (_lifeLeft <= 0) {
        [_pulseTimer invalidate];
        _pulseTimer = nil;
        [(GameScene*)self.parent goToLevelFinished];
    }
    
    //show bloody frame
    else if (_lifeLeft <= 20 && _dying == NO){
        [self addPulsingBloodScreen];
        _dying = YES;
    }
}


- (void) addShieldWithDuration:(float)duration
{
    if (_shieldActivations < MAX_SHIELD_ACTIVATIONS) {
        _shieldActivations += 1;
        
        _shieldNode = [SKSpriteNode spriteNodeWithImageNamed:@"shield"];
        _shieldNode.position = CGPointMake(-10, 0);
        [self addChild:_shieldNode];
        
        _shieldNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:35];
        _shieldNode.physicsBody.dynamic = YES;
        _shieldNode.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cShield];
        _shieldNode.physicsBody.contactTestBitMask =   [Categories getCategoryBitMask:cEnemy] |
        [Categories getCategoryBitMask:cEnemyProjectile] |
        [Categories getCategoryBitMask:cMeteor];
        _shieldNode.physicsBody.collisionBitMask = 0;
        _shieldNode.physicsBody.usesPreciseCollisionDetection = YES;
        
        [self performSelector:@selector(removeShield) withObject:self afterDelay:duration];
    }
}


- (void) removeShield
{
    [_shieldNode removeFromParent];
}


- (void) addPulsingBloodScreen
{
    CGSize screenSize = CGSizeMake(568, 320);
    SKSpriteNode *blood = [SKSpriteNode spriteNodeWithImageNamed:@"bloody frame@2x.png"];
    blood.position = CGPointMake(CGRectGetMidX(self.parent.frame), CGRectGetMidY(self.parent.frame));
    blood.size = screenSize;
    blood.alpha = 0;
    blood.zPosition = 0;
    [self.parent addChild:blood];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(vibrate)
                                                    userInfo:nil
                                                     repeats:YES];
    _pulseTimer = timer;
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:1.0];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1.0];
    SKAction *wait = [SKAction waitForDuration:0.5];
    SKAction *sequence = [SKAction sequence:@[fadeIn,fadeOut,wait]];
    SKAction *rep = [SKAction repeatActionForever:sequence];
    [blood runAction:rep];
}


// Adding vibration when life < 20
- (void) vibrate {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSMutableArray* arr = [NSMutableArray array ];
    
    [arr addObject:[NSNumber numberWithBool:YES]]; //vibrate for 100ms
    [arr addObject:[NSNumber numberWithInt:100]];
    
    [arr addObject:[NSNumber numberWithBool:NO]];  //stop for 500ms
    [arr addObject:[NSNumber numberWithInt:500]];
    
    [dict setObject:arr forKey:@"VibePattern"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"Intensity"];
    
    
    AudioServicesPlaySystemSoundWithVibration(4095,nil,dict);
}



@end
