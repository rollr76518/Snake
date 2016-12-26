//
//  FruitModel.m
//  Snake
//
//  Created by Ryan on 2016/3/16.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import "FruitModel.h"

@implementation FruitModel

- (void) setupFruitPositionForWidth:(NSInteger)screenWidth Height:(NSInteger)screenHeight {
    self.fruitPosition = [[CoordinateObject alloc] init];
    [self.fruitPosition setX: ((int)(arc4random() % (int)(screenWidth/self.fruitSize)*self.fruitSize / self.fruitSize)) * self.fruitSize];
    [self.fruitPosition setY: ((int)(arc4random() % (int)(screenHeight/self.fruitSize)*self.fruitSize / self.fruitSize)) * self.fruitSize];
    NSLog(@"x is %ld", (long)self.fruitPosition.x);
    NSLog(@"y is %ld", (long)self.fruitPosition.y);
}

//- (void) setupFruitPositionWithView:(UIView *)view {
//    
//}

- (BOOL) isFruitInSnakeBody:(NSMutableArray<CoordinateObject *> *)array {
    BOOL isInBody = NO;
    for (int i = 0; i < array.count; i++) {
        if (self.fruitPosition.x == array[i].x) {
            if (self.fruitPosition.y == array[i].y) {
                isInBody = YES;
            }
        }
    }
    return isInBody;
}
@end
