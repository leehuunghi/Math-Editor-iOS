//
//  ViewController.m
//  ZAMathEditor
//
//  Created by LeHuuNghi on 1/19/19.
//  Copyright © 2019 huunghi. All rights reserved.
//

#import "ViewController.h"
#import "MTEditableMathLabel.h"
#import "MTMathKeyboardRootView.h"

@interface ViewController ()<MTEditableMathLabelDelegate>
@property (strong, nonatomic) MTEditableMathLabel* label;
@property (nonatomic) NSLayoutConstraint *heightLabel;
@property (nonatomic) NSLayoutConstraint *widthLabel;
@property (nonatomic) NSLayoutConstraint *leftLabel;
@property (nonatomic) NSLayoutConstraint *topLabel;
@property (nonatomic) UILabel *placeHolder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _label = [MTEditableMathLabel new];
    _label.delegate = self;
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_label];
    [_label setBackgroundColor:[UIColor whiteColor]];
    
    _leftLabel = [_label.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
    [self.leftLabel setActive:YES];
    _topLabel = [_label.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    [self.topLabel setActive:YES];
    _widthLabel = [_label.widthAnchor constraintEqualToAnchor:self.view.widthAnchor];
    [self.widthLabel setActive:YES];
    _heightLabel = [_label.heightAnchor constraintEqualToAnchor:self.view.heightAnchor];
    [self.heightLabel setActive:YES];
    _label.keyboard = [MTMathKeyboardRootView sharedInstance];

    [_label enableTap:YES];
    [_label enablePan:YES];
    [_label enablePinch:YES];

    
    _placeHolder =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2)];
    
    [_placeHolder setText:@"Tap to begin"];
    [self.label addSubview:self.placeHolder];
    _placeHolder.textAlignment = NSTextAlignmentCenter;
    [_placeHolder setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.placeHolder.centerXAnchor constraintEqualToAnchor:self.label.centerXAnchor] setActive:YES];
    [[self.placeHolder.centerYAnchor constraintEqualToAnchor:self.label.centerYAnchor] setActive:YES];
    [[self.placeHolder.widthAnchor constraintEqualToAnchor:self.label.widthAnchor multiplier:0.5] setActive:YES];
    [[self.placeHolder.heightAnchor constraintEqualToAnchor:self.label.heightAnchor multiplier:0.5] setActive:YES];
}


// Called when the return key is pressed
- (void) returnPressed:(MTEditableMathLabel*) label {
    NSLog(@"press");
}
// called when any text is modified
- (void) textModified:(MTEditableMathLabel*) label {
    NSLog(@"%@", label);
    
    
    CGSize mathSize = label.mathDisplaySize;
    
    //increase height
    if (mathSize.height > self.heightLabel.constant - 10) {
        // animate
        [UIView animateWithDuration:0.5 animations:^{
            self.heightLabel.constant = mathSize.height + 10;
//            [label layoutIfNeeded];
        }];
    }

//    increase width
    if (mathSize.width > self.widthLabel.constant - 10) {
        // animate
        [UIView animateWithDuration:0.5 animations:^{
            self.widthLabel.constant = mathSize.width + 10;
//            [label layoutIfNeeded];
        }];
    }
    [label layoutIfNeeded];
//    //transition center label with caretView is center
//    [UIView animateWithDuration:0.5 animations:^{
//        self.leftLabel.constant = ((float)UIScreen.mainScreen.bounds.size.width /2 - (label.caretPoint.x - self.label.frame.origin.x))/2;
//        self.topLabel.constant = ((float)UIScreen.mainScreen.bounds.size.height /4 - (label.caretPoint.y - self.label.frame.origin.y))/2;
////        [label layoutIfNeeded];
//    }];
    
}

- (void) didBeginEditing:(MTEditableMathLabel*) label {
    self.placeHolder.hidden = YES;
}
- (void) didEndEditing:(MTEditableMathLabel*) label {
    
}


@end
