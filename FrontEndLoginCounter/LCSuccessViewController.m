//
//  LCSuccessViewController.m
//  FrontEndLoginCounter
//
//  Created by Ryan Leung on 2/16/13.
//  Copyright (c) 2013 Ryan Leung. All rights reserved.
//

#import "LCSuccessViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LCSuccessViewController ()

@end

@implementation LCSuccessViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(id)initWithUsername:(NSString *)username andCount:(int)count
{
    if (self = [super init])
    {
        self.username = username;
        self.count = count;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

-(void)setupViews
{
    // setup message field
    self.messageField = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 73)];
    self.messageField.text = [NSString stringWithFormat:@"Welcome %@. You have logged in %i times.", self.username, self.count];
    self.messageField.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    self.messageField.layer.borderWidth = 5.0f;
    self.messageField.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:self.messageField];
    
    // setup logout button
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    logoutButton.frame = CGRectMake(95, 166, 131, 49);
    [logoutButton addTarget:self action:@selector(logoutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}

-(void)logoutButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
