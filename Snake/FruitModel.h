//
//  FruitModel.h
//  Snake
//
//  Created by Ryan on 2016/3/16.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateObject.h"

@interface FruitModel : NSObject

@property (nonatomic, strong) CoordinateObject *fruitPosition;
@property (assign, nonatomic) NSInteger fruitSize;

- (void) setupFruitPositionForWidth:(NSInteger)screenWidth Height:(NSInteger)screenHeight;
- (BOOL) isFruitInSnakeBody:(NSMutableArray<CoordinateObject *> *)array ;

@end
