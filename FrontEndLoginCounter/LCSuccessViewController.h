//
//  LCSuccessViewController.h
//  FrontEndLoginCounter
//
//  Created by Ryan Leung on 2/16/13.
//  Copyright (c) 2013 Ryan Leung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCSuccessViewController : UIViewController

@property (nonatomic, strong) UITextView *messageField;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) int count;


-(id)initWithUsername:(NSString *)username andCount:(int)count;

@end
