//
//  DocumentBrowserViewController.m
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//



#import "DocumentBrowserViewController.h"
#import "Document.h"

@interface DocumentBrowserViewController() <UIDocumentBrowserViewControllerDelegate>

@end

@implementation DocumentBrowserViewController
    
- (void) viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
}

#pragma mark UIDocumentBrowserViewControllerDelegate

- (void) documentBrowser: (UIDocumentBrowserViewController*) controller didRequestDocumentCreationWithHandler: (void (^)(NSURL * _Nullable, UIDocumentBrowserImportMode)) importHandler {

    // set the URL for the new document
    // always call the importHandler, even if the user cancels the creation request
    __block NSURL* newDocumentURL = nil;

    @try {
        [Document createDocumentWithCompletionBlock: ^(Document* doc) {

            if (doc != nil) {
                newDocumentURL = doc.fileURL;
                importHandler(newDocumentURL, UIDocumentBrowserImportModeMove);
            }
            else {
                // show error
                importHandler(newDocumentURL, UIDocumentBrowserImportModeNone);
            }
        }];
    }
    @catch (NSException* exception) {
        // show error
        importHandler(newDocumentURL, UIDocumentBrowserImportModeNone);
    }
}

- (void) documentBrowser: (UIDocumentBrowserViewController*) controller didPickDocumentURLs: (NSArray<NSURL*>*) documentURLs {

    // callback after user picks a file
    NSURL* sourceURL = documentURLs.firstObject;
    if (!sourceURL)
        return;

    // present the Document View Controller for the first document that was picked
    [self presentDocumentAtURL:sourceURL title:@"RestoreOrImport"];
}

- (void) documentBrowser: (UIDocumentBrowserViewController*) controller didImportDocumentAtURL: (NSURL*) sourceURL toDestinationURL: (NSURL*) destinationURL {

    // callback after user clicks on (+) Create Document

    // present the Document View Controller for the new newly created document
    [self presentDocumentAtURL:destinationURL title:@"BackupOrExport"];
}

- (void) documentBrowser: (UIDocumentBrowserViewController*) controller failedToImportDocumentAtURL: (NSURL*) documentURL error: (NSError* _Nullable) error {

    // handle the failed import
    [self showError];
}

// MARK: Document Presentation
- (void) doneTapped: (UIButton*) sender {

    //print("returnToDocumentBrowser")
    UINavigationController* nc = (UINavigationController*)[self presentedViewController];
    if (nc)
        [nc dismissViewControllerAnimated:NO completion:^{
            // dismiss view
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
}

- (void) presentDocumentAtURL: (NSURL*) documentURL
                        title: (NSString*) title {

    // access the document
    Document* doc = [[Document alloc] initWithFileURL:documentURL];
    [doc openWithCompletionHandler:^(BOOL success) {

        if (success) {
            // display the contents of the document, e.g.
            // self.documentNameLabel.text = self.document.fileURL.lastPathComponent;

            UIAlertController* alert = [UIAlertController alertControllerWithTitle: title
                                                                           message: doc.fileURL.lastPathComponent
                                                                    preferredStyle: UIAlertControllerStyleAlert];
            UIAlertAction* okButton = [UIAlertAction actionWithTitle: @"OK"
                                                               style: UIAlertActionStyleDefault
                                                             handler: ^(UIAlertAction* action) {
                // dismiss view
                [self dismissViewControllerAnimated:NO completion:^ {
                    [doc closeWithCompletionHandler:nil];
                }];
            }];

            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            // handle the failed access
            [self showError];
        }
    }];
}

- (void) showError {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Error"
                                                                   message: @"open failed"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle: @"OK"
                                                       style: UIAlertActionStyleDefault
                                                     handler: nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
