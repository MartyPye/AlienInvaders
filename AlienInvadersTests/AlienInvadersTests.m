//
//  AlienInvadersTests.m
//  AlienInvadersTests
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HighscoreManager.h"

@interface AlienInvadersTests : XCTestCase

@end

@implementation AlienInvadersTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHighscoreManager;
{
    // check that highscores are always sorted by score
    HighscoreManager *highscoreManager = [[HighscoreManager alloc] init];
    [highscoreManager addHighscore:[NSNumber numberWithInt:99] withName:@"Verena"];
    [highscoreManager addHighscore:[NSNumber numberWithInt:100] withName:@"Claude"];
    [highscoreManager addHighscore:[NSNumber numberWithInt:200] withName:@"Marty"];
    assert([[highscoreManager nameOfPlayerAtPosition:0] isEqualToString:@"Marty"]);
    assert([[highscoreManager nameOfPlayerAtPosition:1] isEqualToString:@"Claude"]);
    assert([[highscoreManager nameOfPlayerAtPosition:2] isEqualToString:@"Verena"]);
    
    // check for invalid array index
    assert([[highscoreManager nameOfPlayerAtPosition:3] isEqualToString:@""]);
}

@end
