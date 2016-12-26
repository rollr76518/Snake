//
//  Quartz2DView.h
//  Quartz2DPractice
//
//  Created by Ryan on 2016/3/14.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinateObject.h"

@protocol DirectionChangeProtocol <NSObject>

- (void) directionChangeTo:(NSInteger) direction;

@end

@interface DrawView : UIView

@property (nonatomic, strong) NSMutableArray<CoordinateObject *> *coordinateObjectArray;
@property (nonatomic, assign) CGFloat screenScale;
@property (nonatomic, assign) BOOL isSetupGesture;
@property (nonatomic, weak) id<DirectionChangeProtocol> iDelegate;
@property (nonatomic, strong) CoordinateObject *frultPosition;
@property (assign, nonatomic) NSInteger cubeSize;

@end
