//
//  LCLoginViewController.m
//  FrontEndLoginCounter
//
//  Created by Ryan Leung on 2/15/13.
//  Copyright (c) 2013 Ryan Leung. All rights reserved.
//

#import "LCLoginViewController.h"
#import "AFJSONRequestOperation.h"
#import "LCSuccessViewController.h"
#import <QuartzCore/QuartzCore.h>

NSString * const SERVER_URL = @"http://stormy-gorge-1267.herokuapp.com/";

@interface LCLoginViewController ()

@end

@implementation LCLoginViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(id)init
{
    if (self = [super init])
    {
        self.httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        [self.httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.httpClient setDefaultHeader:@"Accept" value:@"application/json"];
        self.httpClient.parameterEncoding = AFJSONParameterEncoding;
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

-(void)viewWillAppear:(BOOL)animated
{
    [self.messageField setText:@"Please enter your credentials below"];
    [super viewWillAppear:YES];
}

-(void)setupViews
{
    // setup message field
    self.messageField = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 73)];
    self.messageField.text = @"Please enter your credentials below";
    self.messageField.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    self.messageField.layer.borderWidth = 3.0f;
    self.messageField.editable = NO;
    self.messageField.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:self.messageField];
    
    // setup username label
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 119, 118, 21)];
    usernameLabel.text = @"Username: ";
    usernameLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    [self.view addSubview:usernameLabel];
    
    // setup password label
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 166, 118, 21)];
    passwordLabel.text = @"Password: ";
    passwordLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    [self.view addSubview:passwordLabel];
    
    // setup username text field
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(117, 117, 183, 30)];
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameField.placeholder = @"Enter Username";
    self.usernameField.delegate = self;
    [self.view addSubview:self.usernameField];
    
    // setup password text field
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(117, 162, 183, 30)];
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.placeholder = @"Enter Password";
    self.passwordField.delegate = self;
    [self.view addSubview:self.passwordField];
    
    // setup login button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(20, 247, 131, 49);
    [loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    // setup add user button
    UIButton *addUserButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addUserButton setTitle:@"Add User" forState:UIControlStateNormal];
    addUserButton.frame = CGRectMake(169, 247, 131, 49);
    [addUserButton addTarget:self action:@selector(addUserButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addUserButton];
}

-(void)addUserButtonPressed
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text, @"user", self.passwordField.text, @"password", nil];
    [self.httpClient postPath:@"/users/add" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int errCode = ((NSString *)[responseObject objectForKey:@"errCode"]).intValue;
        switch (errCode) {
            case 1:
            {
                NSLog(@"Successfully added user");
                int count = ((NSString *) [responseObject objectForKey:@"count"]).intValue;
                LCSuccessViewController *successVC = [[LCSuccessViewController alloc] initWithUsername:self.usernameField.text andCount:count];
                [self presentViewController:successVC animated:YES completion:nil];
            }
                break;
            case -2:
            {
                NSLog(@"ERR_USER_EXISTS");
                [self.messageField setText:@"This user name already exists. Please try again."];
            }
                break;
            case -3:
            {
                NSLog(@"ERR_BAD_USERNAME");
                self.messageField.text = @"The user name should be non-empty and at most 128 characters long. Please try again.";
            }
                break;
            case -4:
            {
                NSLog(@"ERR_BAD_PASSWORD");
                self.messageField.text = @"The password should be at most 128 characters long. Please try again.";
            }
                break;
            default:
            {
                NSLog(@"????? what error code did you get....errCode: %i", errCode);
            }
                break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

-(void)loginButtonPressed
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text, @"user", self.passwordField.text, @"password", nil];
    [self.httpClient postPath:@"/users/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int errCode = ((NSString *)[responseObject objectForKey:@"errCode"]).intValue;
        switch (errCode) {
            case 1:
            {
                NSLog(@"Successfully logged in");
                int count = ((NSString *) [responseObject objectForKey:@"count"]).intValue;
                LCSuccessViewController *successVC = [[LCSuccessViewController alloc] initWithUsername:self.usernameField.text andCount:count];
                [self presentViewController:successVC animated:YES completion:nil];
            }
                break;
            case -1:
            {
                NSLog(@"ERR_BAD_CREDENTIALS");
                self.messageField.text = @"Invalid username and password combination. Please try again.";
            }
                break;
            default:
            {
                NSLog(@"????? what error code did you get....errCode: %i", errCode);
            }
                break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
