//
//  SnakeTests.m
//  SnakeTests
//
//  Created by Ryan on 2016/3/12.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SnakeModel.h"

@interface SnakeTests : XCTestCase

@end

@implementation SnakeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testHit {
    SnakeModel *snake = [[SnakeModel alloc] init];
    snake.direction = up;
    [snake snakeMoveAnStep];
    snake.direction = right;
    [snake snakeMoveAnStep];
    snake.direction = down;
    [snake snakeMoveAnStep];
    
    XCTAssertEqual([snake isSnakeTouchItsBody], YES, @"蛇沒撞到自己的身體");
}

- (void)testAddTail {
    SnakeModel *snake = [[SnakeModel alloc] init];
    NSInteger oldX = snake.postionArray.lastObject.x;
    NSInteger oldY = snake.postionArray.lastObject.y;
    
    [snake addSnakeBody];
//    XCTAssertEqual(snake.postionArray.lastObject.x, oldX + 20, @"尾巴x應該要在7");
    XCTAssertEqual(snake.postionArray.lastObject.y, oldY, @"尾巴y應該要在0");
    
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
