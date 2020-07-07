//
//  WebViewController.m
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//

#import "WebViewController.h"
#import "DocumentBrowserViewController.h"

@interface WebViewController ()

@property UIBarButtonItem *doneBtnItem;
@property (nonatomic, strong) WKWebView *wkWebView;
@property IBOutlet UIView *webview;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView  *mainWebView = [[WKWebView alloc] initWithFrame:self.webview.frame];
    mainWebView.UIDelegate = self;
    mainWebView.navigationDelegate = self;
    mainWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.webview addSubview:mainWebView];

    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    [mainWebView loadRequest:mutableRequest];

    _doneBtnItem = [[UIBarButtonItem alloc] initWithTitle: @"Cancel"
     style: UIBarButtonItemStyleDone
    target: self
    action: @selector(cancelTapped:)];
}

- (void) cancelTapped: (UIButton*) sender {
    UINavigationController* nc = (UINavigationController*)[self presentedViewController];
    if (nc)
        [nc dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchBtnPush:(id)sender{
}

- (IBAction)touchBtnFile:(id)sender{
    [self doIt:@"RestoreOrImport" createDoc:NO];
}

- (IBAction)touchBtnDBEdit:(id)sender{
}


- (void) doIt: (NSString*) title createDoc: (BOOL) create {
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DocumentBrowserViewController* dbvc = [sb instantiateViewControllerWithIdentifier:@"DocumentBrowserViewController"];
    dbvc.allowsDocumentCreation = create;
    dbvc.navigationItem.leftBarButtonItem = _doneBtnItem;
    dbvc.title = title;

    UIViewController* dummyVC = [UIViewController new];
    id nc = [[UINavigationController alloc] initWithRootViewController:dummyVC];
    [self presentViewController:nc animated:NO completion:nil];
    [dummyVC.navigationController pushViewController:dbvc animated:NO];
}



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

    NSString *requestString = navigationAction.request.URL.absoluteString;

     if ([requestString hasPrefix:@"http://www.facebook.com"]){
        NSURL *rurl = [NSURL URLWithString:requestString];
        [[UIApplication sharedApplication] openURL:rurl];
        decisionHandler(WKNavigationActionPolicyCancel);    // cancel the navigation
        return;
     }
    decisionHandler(WKNavigationActionPolicyAllow);    // allow the navigation
}






@end
