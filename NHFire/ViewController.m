//
//  ViewController.m
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//

#import "ViewController.h"
#import "DocumentBrowserViewController.h"
#import "AlertListViewController.h"
#import "iRukey/libIos.h"
#import "mVaccine/ffc8943a.h"

#define DEIVCE_UNIQUE_PIN @"DEIVCE_UNIQUE_PIN1"  //transkey pin kSecAttrService

@interface ViewController ()

@property (nonatomic, retain) ObjcRainpass* theIrukeyLib;
@property (nonatomic, strong) WKWebView *wkWebView;
@property IBOutlet UIView *webview;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tabBar.delegate = self;
    
    self.theIrukeyLib = [[ObjcRainpass alloc] init];
    
    [self wkWebviewSet];
}

- (void)viewDidAppear:(BOOL)animated{
    [self mVaccineCheck];
}

#pragma func
- (void)wkWebviewSet{
    WKWebView  *mainWebView = [[WKWebView alloc] initWithFrame:self.webview.frame];
    mainWebView.UIDelegate = self;
    mainWebView.navigationDelegate = self;
    mainWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.webview addSubview:mainWebView];

    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    [mainWebView loadRequest:mutableRequest];
}

- (void)mVaccineCheck{
    B8b18943_aa0tB();
    if(tk_a0etB8aace8det) { // 해당 변수에 탐지 결과 자동 기입
        // Self JailBreak Check – 탈옥체크 후 앱자동 종료
        [e8db18ftfc0etB8a setJbt:@"탈옥체크결과"];
        [e8db18ftfc0etB8a setJbmg:@"탈옥된 폰입니다."];
        f9aabep843a([e8db18ftfc0etB8a setDisplayReplay]);
    }else{
//        [self showMessage:@"어플리케이션 사용가능" withTitle:@"탈옥체크"];
    }
}

- (void)iRukeyCheck{
    NSString* pin = @"111111";
    NSString* data = @"KE4WQV4FJB4HU4MEHFCY6W4ENE5EKTVGQB5W8XUIIXDGQQKDII6ZESMYKBAYS53SMB5WQ7C2IXBDUYVHPB4GEYCXIT5FWNVHGN6G44VVKPBHNYCRPFAY6UVFFPFFETKYIFVGU8BVPBEYQVCGKJZGYNUWNTUFE4VBIXWXEPKTJW3E8NB3IFNCY8VZGBYG2NMGNX3E87V4GTAVS45NJTZFI2JZKB7GNYCPFP6XEUUFK7MVKXKPGBNEY45KGPKGQTUUKBEHA24RRJYE8VVPI7IWKW4CJXTHE5D2MFEGUVBTGI5XAN3YNX5VEVDBGJTVEX5XKS2EISTMPFSYUPTXGJHHW6VTJ7YGKXCRHBJXCQKTJXJYNVUWPXJHKM4NPIXWQV5QGFNFQ6VWQXMHEP4CIW2EKTMCPPMFG5USF74HW6M4GJGWW6TYP3YVA2UGHF4VAWVDIXEE4M4SHFZVQPJVQ6XXGWDXIW5GUNCCQ64ZWTUBIJDGN7J2KW3YI7UIHF5U8S3RKPGYK44WJFKHEWDCIFGEUYDXGT6DEV32MBWYE45JPBEHW74BJS4VE8VGQB5HK4VIGTDYU3JVNP4EIN5TJ7YGITVEQPVHNXKBNJ7GIQBVGB5GQ8CXQW2DS8JTP7DZUM5DJ7KC8PUXP62EENU2JJYEY3MEPXZVU5DZGPWZUP4SGFBEGWVRGBEDNV5MN36HI8KMITDXKNKCNF4FG";
        
    NSString *iRukeyValue = [self.theIrukeyLib add3:pin encryptedData:data];
    
    if(![iRukeyValue isEqualToString:@"E001"]){
//        [self showMessage:@"iRukey인증번호" withTitle:iRukeyValue];
    }else{
        [self showMessage:@"iRukey인증번호" withTitle:@"E001 :: iRukey인증번호 이상감지"];
    }
    
}

#pragma - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(item.tag == 0){ //get OTP
        [self iRukeyCheck];
    }else if (item.tag == 1){ //alert List
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AlertListViewController* alertListView = [sb instantiateViewControllerWithIdentifier:@"AlertListViewController"];
        [self presentViewController:alertListView animated:YES completion:nil];
        
    }else{ //file Search
        
        UIDocumentPickerViewController *fileView = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:[self allowedUTIs] inMode:UIDocumentPickerModeImport];
        fileView.delegate = self;
        
//        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        DocumentBrowserViewController* fileView = [sb instantiateViewControllerWithIdentifier:@"DocumentBrowserViewController"];
        
        [self presentViewController:fileView animated:YES completion:nil];
    }
}

-(NSArray*)allowedUTIs{
    return @[@"public.data",@"public.content",@"public.audiovisual-content",@"public.movie",@"public.audiovisual-content",@"public.video",@"public.audio",@"public.text",@"public.data",@"public.zip-archive",@"com.pkware.zip-archive",@"public.composite-content",@"public.text"];
};



#pragma mark - WKWebView UIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:message preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler();
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:message preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completionHandler(YES);
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler(NO);
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = defaultText;
    }];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *input = ((UITextField *)alertController.textFields.firstObject).text;
        completionHandler(input);
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler(nil);
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - WKWebView WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"start");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"finish Navigation");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"fail Navigation");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"decidePolicyForNavigationAction");
    
    decisionHandler(WKNavigationActionPolicyAllow);    // allow the navigation
}

#pragma mark - UIDocumentPicker UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    NSLog(@"didPickDocumentsAtURLs : %@", urls);
    
}



- (void)showMessage:(NSString*)message withTitle:(NSString *)title{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([action.title isEqualToString:@"확인"]) {
            
        }
    }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
