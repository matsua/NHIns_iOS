//
//  Document.m
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//

#import "Document.h"

@implementation Document

- (id) contentsForType: (NSString*) typeName error: (NSError**) errorPtr {
    // Encode your document with an instance of NSData or NSFileWrapper
    return [NSData new];
}

- (BOOL) loadFromContents: (id) contents ofType: (NSString*) typeName error: (NSError**) errorPtr {
    // Load your document from contents
    return YES;
}

+ (NSDateFormatter*) yyyyMMddHHmmssFormatter {
    
    static NSDateFormatter* _formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatter = [NSDateFormatter new];
        _formatter.dateFormat = @"yyyyMMdd-HHmmss";
        _formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    });
    return _formatter;
}

+ (void) createDocumentWithCompletionBlock: (void(^)(Document*)) completionBlock {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {

        // unique filename
        NSDate* today = [NSDate date];
        __block NSString* datePrefix = [[self yyyyMMddHHmmssFormatter] stringFromDate:today];
        id fileName = [NSString stringWithFormat:@"%@%@", datePrefix, @"-cl.zip"];

        // get a temp URL
        NSString* tempPath = NSTemporaryDirectory();
        NSString* tempFile = [tempPath stringByAppendingPathComponent:fileName];
        NSURL* docURL = [NSURL fileURLWithPath:tempFile];

        // create the file
        NSString* content = @"Put this in a file please.";
        NSData* fileContents = [content dataUsingEncoding:NSUTF8StringEncoding];
        [[NSFileManager defaultManager] createFileAtPath: docURL.path
                                                contents: fileContents
                                              attributes: nil];

        // allocate a Document with the created file
        Document* doc = [[Document alloc] initWithFileURL:docURL];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock)
                completionBlock(doc);
        });
    });
}

@end

