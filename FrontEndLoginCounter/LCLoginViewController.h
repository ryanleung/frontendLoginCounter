//
//  LCLoginViewController.h
//  FrontEndLoginCounter
//
//  Created by Ryan Leung on 2/15/13.
//  Copyright (c) 2013 Ryan Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"

extern NSString * const SERVER_URL;

@interface LCLoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UITextView *messageField;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) AFHTTPClient *httpClient;
@end
