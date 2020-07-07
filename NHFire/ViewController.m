//
//  ViewController.m
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "libIos.h"

@interface ViewController ()

@property (nonatomic, retain) ObjcRainpass* theIrukeyLib;

@property (strong, nonatomic) IBOutlet UIButton *btnId;
@property (strong, nonatomic) IBOutlet UIButton *btnPw;
@property (strong, nonatomic) IBOutlet UIButton *btnOtp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.theIrukeyLib = [[ObjcRainpass alloc] init];
}

#pragma  User define Action
- (IBAction)touchBtnOtp:(id)sender{
    NSString* pin = @"111111";
    NSString* data = @"KE4WQV4FJB4HU4MEHFCY6W4ENE5EKTVGQB5W8XUIIXDGQQKDII6ZESMYKBAYS53SMB5WQ7C2IXBDUYVHPB4GEYCXIT5FWNVHGN6G44VVKPBHNYCRPFAY6UVFFPFFETKYIFVGU8BVPBEYQVCGKJZGYNUWNTUFE4VBIXWXEPKTJW3E8NB3IFNCY8VZGBYG2NMGNX3E87V4GTAVS45NJTZFI2JZKB7GNYCPFP6XEUUFK7MVKXKPGBNEY45KGPKGQTUUKBEHA24RRJYE8VVPI7IWKW4CJXTHE5D2MFEGUVBTGI5XAN3YNX5VEVDBGJTVEX5XKS2EISTMPFSYUPTXGJHHW6VTJ7YGKXCRHBJXCQKTJXJYNVUWPXJHKM4NPIXWQV5QGFNFQ6VWQXMHEP4CIW2EKTMCPPMFG5USF74HW6M4GJGWW6TYP3YVA2UGHF4VAWVDIXEE4M4SHFZVQPJVQ6XXGWDXIW5GUNCCQ64ZWTUBIJDGN7J2KW3YI7UIHF5U8S3RKPGYK44WJFKHEWDCIFGEUYDXGT6DEV32MBWYE45JPBEHW74BJS4VE8VGQB5HK4VIGTDYU3JVNP4EIN5TJ7YGITVEQPVHNXKBNJ7GIQBVGB5GQ8CXQW2DS8JTP7DZUM5DJ7KC8PUXP62EENU2JJYEY3MEPXZVU5DZGPWZUP4SGFBEGWVRGBEDNV5MN36HI8KMITDXKNKCNF4FG";
    
    NSString * str = [self.theIrukeyLib add3:pin encryptedData:data];
    
    NSLog(@"OTID:  %@", str);
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"iRukey인증번호"
                              message:str
                              preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action){
                            [alert dismissViewControllerAnimated:NO completion:nil];
        
                            if(![str isEqualToString:@"E001"]){
                                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                WebViewController *secondVC = (WebViewController *)[sb instantiateViewControllerWithIdentifier:@"WebView"];
                                [self presentViewController:secondVC animated:true completion:nil];
                            }
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:true completion:nil];
    
}



@end
