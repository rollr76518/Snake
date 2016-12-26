//
//  Quartz2DView.m
//  Quartz2DPractice
//
//  Created by Ryan on 2016/3/14.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setIsSetupGesture: NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (![self isSetupGesture]) {
        [self setIsSetupGesture: YES];
        [self addGesture];
    }

    [self cleanScreen:rect];
    [self drawSnake];
    [self drawFrult];
}

- (void)cleanScreen:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextFillRect(ctx, rect);
}

- (void)drawSnake {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < self.coordinateObjectArray.count; i++) {
        UIBezierPath *cube = [UIBezierPath bezierPathWithRect: CGRectMake(self.coordinateObjectArray[i].x,
                                                                          self.coordinateObjectArray[i].y,
                                                                          self.cubeSize,
                                                                          self.cubeSize)];
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        [cube fill];
    }
}

- (void) drawFrult{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *cube = [UIBezierPath bezierPathWithRect: CGRectMake(self.frultPosition.x,
                                                                      self.frultPosition.y,
                                                                      self.cubeSize,
                                                                      self.cubeSize)];
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    [cube fill];
}

- (void) addGesture {
    UISwipeGestureRecognizer* recognizerUP = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                       action: @selector(up)];
    [recognizerUP setDirection: UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer: recognizerUP];
    
    UISwipeGestureRecognizer* recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                         action: @selector(down)];
    [recognizerDown setDirection: UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer: recognizerDown];
    
    UISwipeGestureRecognizer* recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                         action: @selector(left)];
    [recognizerLeft setDirection: UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer: recognizerLeft];
    
    UISwipeGestureRecognizer* recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                                                          action: @selector(right)];
    [recognizerRight setDirection: UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer: recognizerRight];
}

- (void) up{
    [self.iDelegate directionChangeTo: 2];
}

- (void) down {
    [self.iDelegate directionChangeTo: 3];
}

- (void) left {
    [self.iDelegate directionChangeTo: 0];
}

- (void) right {
    [self.iDelegate directionChangeTo: 1];
}

@end
