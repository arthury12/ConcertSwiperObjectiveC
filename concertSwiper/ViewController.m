//
//  ViewController.m
//  concertSwiper
//
//  Created by Arthur Yu on 2/23/16.
//  Copyright © 2016 Arthur Yu. All rights reserved.
//


//add a view, center of VC, red, cover entireView

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) NSString *urlStr;
@property (nonatomic, weak) NSURL *url;
@end

@implementation ViewController

//typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
//    UIAlertControllerStyleAction
//};

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self parseJSON];
    // Do any additional setup after loading the view, typically from a nib.
    
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2, 414, 736)];
    UIView *rectView = [[UIView alloc] init];
    rectView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:rectView];
//    
//    [rectView addConstraint: [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:25.0]];
//    [rectView addConstraint: [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0]];
//    [rectView addConstraint: [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:3.0]];
//    [rectView addConstraint: [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3.0]];
    
}
- (IBAction)SignInButton:(UIButton *)sender {
    
}
- (IBAction)displayActionsButton:(UIButton *)sender {
    UIAlertController* view = [UIAlertController alertControllerWithTitle:@"To Do List" message:@"Select one from below" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)testButton:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"alert!" message:@"This is a test!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
