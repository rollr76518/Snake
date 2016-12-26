//
//  SnakeModel.h
//  Snake
//
//  Created by Ryan on 2016/3/12.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateObject.h"

enum Direction {
    left = 0,
    right,
    up,
    down
};

@interface SnakeModel : NSObject

@property (nonatomic, strong) NSMutableArray<CoordinateObject *> *postionArray;
@property (nonatomic, assign) enum Direction direction;
@property (assign, nonatomic) NSInteger snakeSize;
@property (nonatomic, assign) NSInteger screenHeight;
@property (nonatomic, assign) NSInteger screenWidth;

- (void) snakeMoveAnStep;
- (void) addSnakeBody;
- (BOOL) isSnakeTouchItsBody;
- (BOOL) isSnakeTouchFruit:(CoordinateObject *)fruitPostion;

@end
