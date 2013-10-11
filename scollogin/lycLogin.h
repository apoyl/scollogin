//
//  lycLogin.h
//  scollogin
//
//  Created by aotuman on 13-8-22.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

@interface lycLogin : UIViewController

@property (nonatomic,retain) IBOutlet UITextField *user;
@property (nonatomic,retain) IBOutlet UITextField *pwd;
@property (nonatomic,retain) IBOutlet UISwitch *isSave;
@property (nonatomic,retain) NSData *data;

#pragma mark 登陆操作
- (IBAction)login;
#pragma mark 跳转注册页面
- (IBAction)toreg:(id)sender;

- (IBAction)backgrondTouch:(id)sender;
@end