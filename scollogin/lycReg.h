//
//  lycreg.h
//  scollogin
//
//  Created by aotuman on 13-8-27.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lycReg : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *user;
@property (retain, nonatomic) IBOutlet UITextField *pwd;
@property (retain,nonatomic) IBOutlet UITextField *cpwd;
- (IBAction)reg:(UIButton *)sender;
- (IBAction)backgrondTouch:(id)sender;
- (IBAction)returnLogin:(id)sender;

@end
