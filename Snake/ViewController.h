//
//  ViewController.h
//  Snake
//
//  Created by Ryan on 2016/3/12.
//  Copyright © 2016年 Hanyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *gameRangeView;
@property (strong, nonatomic) IBOutlet UIButton *buttonStartGame;
@property (strong, nonatomic) IBOutlet UILabel *labelBestScore;
@property (strong, nonatomic) IBOutlet UILabel *labelNowScore;

@end

