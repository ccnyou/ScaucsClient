//
//  LvKangViewController.m
//  ScaucsClient
//
//  Created by ccnyou on 14-4-7.
//  Copyright (c) 2014年 ccnyou. All rights reserved.
//

#import "LvKangViewController.h"

@interface LvKangViewController ()

@property (nonatomic, strong) IBOutlet UITextField* userNameTextField;
@property (nonatomic, strong) IBOutlet UITextField* passwordTextField;

@end

@implementation LvKangViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITextField* userNameTextField = _userNameTextField;
    userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    userNameTextField.placeholder = @"用户名";
    userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameTextField.returnKeyType = UIReturnKeyDone;
    
    UIImageView* userNameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    userNameTextField.leftView = userNameImageView;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UITextField* passwordTextField = _passwordTextField;
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.placeholder = @"●●●●●●●●";
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    
    UIImageView* passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.png"]];
    passwordTextField.leftView = passwordImageView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* userName = [userDefaults objectForKey:@"UserName"];
    NSString* psw = [userDefaults objectForKey:@"Password"];
    
    if (userName.length > 0) {
        _userNameTextField.text = userName;
    }
    
    if (psw.length > 0) {
        _passwordTextField.text = psw;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gameClicked:(id)sender
{
    
    
    
}

@end
