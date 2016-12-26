//
//  ViewController.m
//  Snake
//
//  Created by Ryan on 2016/3/12.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "SnakeModel.h"
#import "FruitModel.h"

@interface ViewController ()<DirectionChangeProtocol>

@property (strong, nonatomic) DrawView *drawView;
@property (strong, nonatomic) SnakeModel *snakeModel;
@property (strong, nonatomic) FruitModel *fruitModel;
@property (assign, nonatomic) NSInteger cubeSize;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger nowScore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCubeSize: 10];
    [self updateBestScore];
    [self.labelNowScore setText: [NSString stringWithFormat: @"Score:%li", self.nowScore]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self resizeGameView];
}

- (void) startGame {
    [self setupSnake];
    [self setupView];
    [self setupFruitModel];
    [self setNowScore: 0];
    [self.labelNowScore setText: [NSString stringWithFormat: @"Score:%li", self.nowScore]];
    [self setTimer: [NSTimer scheduledTimerWithTimeInterval: 0.1
                                                     target: self
                                                   selector: @selector(change:)
                                                   userInfo: nil
                                                    repeats: YES]];
}

- (void) change:(NSTimer *)timer {
    [self.drawView setCoordinateObjectArray: self.snakeModel.postionArray];
    [self.snakeModel snakeMoveAnStep];
    //    NSLog(@"x is %ld, y is %ld", (long)self.snakeModel.postionArray[0].x, (long)self.snakeModel.postionArray[0].y);
    if ([self.snakeModel isSnakeTouchItsBody]) {
        [self gameOver];
    }
    
    if ([self.snakeModel isSnakeTouchFruit: self.fruitModel.fruitPosition]) {
        [self.snakeModel addSnakeBody];
        [self setupFruitModel];
        self.nowScore ++;
        [self.labelNowScore setText: [NSString stringWithFormat: @"Score:%li", self.nowScore]];
    }
    [self.drawView setNeedsDisplay];
}

- (void) gameOver {
    [self.timer invalidate];
    [self setTimer: nil];
    [self updateBestScore];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Game Over"
                                                                   message: [NSString stringWithFormat: @"Your score is %li", self.nowScore]
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle: @"Play again"
                                                       style: UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [self startGame];
                                                     }];
    
    [alert addAction: OKAction];
    
    [self presentViewController: alert animated: YES completion: nil];
}

- (void) updateBestScore {
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    NSInteger bestScore = 0;
    if ( [userData objectForKey: @"bestScore"] ) {
        bestScore = [userData integerForKey: @"bestScore"];
    }
    if (self.nowScore > bestScore) {
        bestScore = self.nowScore;
        [userData setInteger: bestScore forKey: @"bestScore"];
    }
    [self.labelBestScore setText: [NSString stringWithFormat: @"Best Score: %li", bestScore]];
    [userData synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonStartGame:(id)sender {
    [self startGame];
    [self.buttonStartGame setHidden: YES];
}

#pragma mark - SetupModel
- (void) setupSnake {
    [self setSnakeModel: [[SnakeModel alloc] init]];
    [self.snakeModel setPostionArray: [[NSMutableArray alloc] init]];
    [self.snakeModel setSnakeSize: self.cubeSize];
    [self.snakeModel setScreenWidth: self.gameRangeView.frame.size.width];
    [self.snakeModel setScreenHeight: self.gameRangeView.frame.size.height];
    for ( int i = 0; i < 5; i++) {
        CoordinateObject *postionObject = [[CoordinateObject alloc] init];
        [postionObject setX: ((int)([UIScreen mainScreen].bounds.size.width/self.cubeSize/2))*10 + i*self.cubeSize];
        [postionObject setY: ((int)([UIScreen mainScreen].bounds.size.height/self.cubeSize/2))*self.cubeSize];
        [self.snakeModel.postionArray addObject: postionObject];
    }
}

- (void) setupView {
    [self setDrawView: [[DrawView alloc] initWithFrame: CGRectMake(0,
                                                                   0,
                                                                   self.gameRangeView.frame.size.width,
                                                                   self.gameRangeView.frame.size.height)]];
    [self.drawView setIDelegate: self];
    [self.drawView setCoordinateObjectArray: self.snakeModel.postionArray];
    [self.drawView setCubeSize: self.cubeSize];
    [self.gameRangeView addSubview: self.drawView];
}

- (void) setupFruitModel {
    if (self.fruitModel) {
        self.fruitModel = nil;
    }
    
    self.fruitModel = [[FruitModel alloc] init];
    [self.fruitModel setFruitSize: self.cubeSize];
    [self.fruitModel setupFruitPositionForWidth: self.gameRangeView.frame.size.width
                                         Height: self.gameRangeView.frame.size.height];
    if (![self.fruitModel isFruitInSnakeBody: self.snakeModel.postionArray]) {
        [self.drawView setFrultPosition: self.fruitModel.fruitPosition];
    }else {
        [self setupFruitModel];
    }
}

- (void) resizeGameView {
    [self.gameRangeView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect rect = self.gameRangeView.frame;
    NSInteger width = (NSInteger)rect.size.width;
    NSInteger height = (NSInteger)rect.size.height;

    NSLog(@"old %@", NSStringFromCGRect(self.gameRangeView.frame));
    if ((width%self.cubeSize) !=0) {
        width = (int)(width/self.cubeSize) *self.cubeSize;
    }
    if ((height%self.cubeSize) !=0) {
        height = (int)(height/self.cubeSize) *self.cubeSize;
    }
    [self.gameRangeView setFrame: CGRectMake((self.view.frame.size.width/2) - (width/2),
                                             rect.origin.y,
                                             width,
                                             height)];
}

#pragma mark - DirectionChangeProtocol
- (void) directionChangeTo:(NSInteger)direction {
    switch (direction) {
        case left:
            if (self.snakeModel.direction == up || self.snakeModel.direction == down) {
                self.snakeModel.direction = left;
            }
            break;
        case right:
            if (self.snakeModel.direction == up || self.snakeModel.direction == down) {
                self.snakeModel.direction = right;
            }
            break;
        case up:
            if (self.snakeModel.direction == left || self.snakeModel.direction == right) {
                self.snakeModel.direction = up;
            }
            break;
        case down:
            if (self.snakeModel.direction == left || self.snakeModel.direction == right) {
                self.snakeModel.direction = down;
            }
            break;
        default:
            break;
    }
}

@end
