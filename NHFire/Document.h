//
//  Document.h
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Document : UIDocument

+ (void) createDocumentWithCompletionBlock: (void(^)(Document*)) completionBlock;

@end
