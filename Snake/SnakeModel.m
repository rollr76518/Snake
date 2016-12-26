//
//  SnakeModel.m
//  Snake
//
//  Created by Ryan on 2016/3/12.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import "SnakeModel.h"

@implementation SnakeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.direction = left;
    }
    return self;
}

- (void) snakeMoveAnStep {
    [self.postionArray removeLastObject];
    CoordinateObject *coordinateObject = [[CoordinateObject alloc] init];
    [coordinateObject setX: self.postionArray.firstObject.x];
    [coordinateObject setY: self.postionArray.firstObject.y];

    switch (self.direction) {
        case down:
            [coordinateObject setY: (coordinateObject.y  + self.snakeSize) % (((int)(self.screenHeight/self.snakeSize)) * self.snakeSize)];
            [self.postionArray insertObject: coordinateObject atIndex: 0];
            break;
        case up:
            [coordinateObject setY: coordinateObject.y - self.snakeSize < 0? (coordinateObject.y + ((int)(self.screenHeight/self.snakeSize)) * self.snakeSize - self.snakeSize):(coordinateObject.y - self.snakeSize)];
            [self.postionArray insertObject: coordinateObject atIndex: 0];
            break;
        case left:
            [coordinateObject setX: coordinateObject.x - self.snakeSize < 0? (coordinateObject.x + ((int)(self.screenWidth/self.snakeSize)) * self.snakeSize - self.snakeSize):(coordinateObject.x - self.snakeSize)];
            [self.postionArray insertObject: coordinateObject atIndex: 0];
            break;
        case right:
            [coordinateObject setX: (coordinateObject.x + self.snakeSize) % (((int)(self.screenWidth/self.snakeSize)) * self.snakeSize)];
            [self.postionArray insertObject: coordinateObject atIndex: 0];
            break;
        default:
            break;
    }
}

- (void) addSnakeBody {
    NSInteger lastX = self.postionArray.lastObject.x;
    NSInteger lastY = self.postionArray.lastObject.y;
    
    NSInteger reciprocal2X = self.postionArray[self.postionArray.count-2].x;
    NSInteger reciprocal2Y = self.postionArray[self.postionArray.count-2].y;

    CoordinateObject *coordinateObjectTail = [[CoordinateObject alloc] init];
    CoordinateObject *coordinateObjectTail2 = [[CoordinateObject alloc] init];

    if (lastX > reciprocal2X) {
        [coordinateObjectTail setX: lastX - self.snakeSize];
        [coordinateObjectTail setY: lastY];
        [coordinateObjectTail2 setX: lastX - 2 * self.snakeSize];
        [coordinateObjectTail2 setY: lastY];
    }else if (lastX < reciprocal2X) {
        [coordinateObjectTail setX: lastX + self.snakeSize];
        [coordinateObjectTail setY: lastY];
        [coordinateObjectTail2 setX: lastX + 2 * self.snakeSize];
        [coordinateObjectTail2 setY: lastY];
    }else if (lastY > reciprocal2Y) {
        [coordinateObjectTail setX: lastX];
        [coordinateObjectTail setY: lastY - self.snakeSize];
        [coordinateObjectTail2 setX: lastX];
        [coordinateObjectTail2 setY: lastY - 2 * self.snakeSize];
    }else if (lastY < reciprocal2Y){
        [coordinateObjectTail setX: lastX];
        [coordinateObjectTail setY: lastY + self.snakeSize];
        [coordinateObjectTail2 setX: lastX];
        [coordinateObjectTail2 setY: lastY + 2 * self.snakeSize];
    }else {

    }
    
    [self.postionArray addObject: coordinateObjectTail];
    [self.postionArray addObject: coordinateObjectTail2];

}

- (BOOL) isSnakeTouchItsBody {
    BOOL isTouch = NO;
    for (int i = 1; i < [self.postionArray count] ; i++) {
        if (self.postionArray.firstObject.x == self.postionArray[i].x) {
            if (self.postionArray.firstObject.y == self.postionArray[i].y) {
                isTouch = YES;
            }
        }
    }
    return isTouch;
}

- (BOOL) isSnakeTouchFruit:(CoordinateObject *)fruitPostion {
    BOOL isTouch = NO;
    if (self.postionArray.firstObject.x == fruitPostion.x) {
        if (self.postionArray.firstObject.y == fruitPostion.y) {
            isTouch = YES;
        }
    }
    return isTouch;
}

@end
