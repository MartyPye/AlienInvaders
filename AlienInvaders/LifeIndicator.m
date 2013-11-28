//
//  LifeIndicator.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "LifeIndicator.h"
//#import "GameScene.h"
//#import "GameSceneViewController.h"

@implementation LifeIndicator

- (id) init {
    self = [super initWithImageNamed:@"white"];
    self.size = CGSizeMake(100, 10);
    self.position = CGPointMake(65, 300);
    
    self.color = [UIColor greenColor];
    self.colorBlendFactor = 0.8;
    
    self.LifeIsCritical = NO;
    
    _redCross = [[SKSpriteNode alloc] initWithImageNamed:@"redCross"];
    _redCross.position = CGPointMake(-(self.size.width/2)-8, 0);
    [self addChild:_redCross];
    
    return self;
}

- (void) updateIndicatorWithLifePercentage:(float)percentage
{
    self.size = CGSizeMake(percentage, 10);
    self.position = CGPointMake(15+percentage/2, 300);
    self.color = [UIColor colorWithRed:1-(percentage/100) green:(percentage/100) blue:0 alpha:1.0];
    
    _redCross.position = CGPointMake(-(self.size.width/2)-8, 0);
    
    // start filter -------------------------------------------------------
    NSString *filePath =
    [[NSBundle mainBundle] pathForResource:@"MainMenuBachground" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    CIImage *beginImage =
    [CIImage imageWithContentsOfURL:fileNameAndPath];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", [NSNumber numberWithFloat:0.0], nil];
    if(percentage <=20){
        self.LifeIsCritical = YES;
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                      keysAndValues: kCIInputImageKey, beginImage,
                            @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
        
        
    }
    /*else{
        self.LifeIsCritical = NO;
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                      keysAndValues: kCIInputImageKey, beginImage,
                            @"inputIntensity", [NSNumber numberWithFloat:0.0], nil];
        
    }*/
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    //[bloodView setImage:newImg];
    
    CGImageRelease(cgimg);
    
    // end filter -------------------------------------------------------
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateIndicatorWithLifePercentage:[[change objectForKey:NSKeyValueChangeNewKey] floatValue]];
}


@end
