//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Michael Henry on 10/14/13.
//  Copyright (c) 2013 Digital Javelina, LLC. All rights reserved.
//

#import "BullsEyeViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController {
    int _currentValue;
    int _targetValue;
    int _score;
    int _currentRound;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
                                [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
                                
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
                                 [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
                                 
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
                                 
                                 [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
                                 
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
                                 [self.slider setMinimumTrackImage:trackRightImage forState:UIControlStateNormal];
                                 
                                
}

- (void)startNewRound {
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    self.slider.value = _currentValue;
    _currentRound = _currentRound + 1;
}

- (void)updateLabels {
    self.targetLabel.text = [NSString stringWithFormat:@"%d",_targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", _currentRound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert {
    int difference = abs(_currentValue - _targetValue);
    int bullseyeValue = _currentValue;
    int points = 100-difference;
    int bonus = 0;
    
    if (difference == 0) {
        bonus = 100;
    } else if (difference < 5) {
        bonus = 50;
}
    _score += points + bonus;


    NSString *title;
    if (difference == 0) {
        title = @"Perfect! You received an extra 100 points for hitting the Bull's Eye!";
    } else if (difference < 5) {
        title = @"You almost had it! You received an extra 50 points for being super-close!";
    } else if (difference < 10) {
        title = @"Pretty good!";
    } else {
        title = @"Not even close!";
    }
    

    NSString *message = [NSString stringWithFormat:
                         @"You moved the bullseye to %d. You scored %d points", bullseyeValue, points+bonus];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)sliderMoved:(UISlider *)slider {
    _currentValue = lroundf(slider.value);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    [self startNewRound];
    [self updateLabels];
}

-(IBAction)startOver {
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
   
    _currentRound = 0;
    _score = 0;
    [self startNewRound];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}


@end
