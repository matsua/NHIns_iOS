//
//  libIos.h
//  libIos
//
//  Created by Leo An on 8/4/16.
//  Copyright © 2016 INNOAUS INC. All rights reserved.
//

#ifndef __libIos_h__
#define __libIos_h__

#import <Foundation/Foundation.h>

@interface ObjcRainpass : NSObject {
}
- (bool)isInitialized;
- (void)initialize:(NSString*)str;
- (void)finalize;
- (int)getNumberOfItems;
- (int)add:(NSString*)pin encryptedData:(NSString*)data;
- (bool)add2:(NSString*)data;
- (NSString*)add3:(NSString *)pin encryptedData:(NSString *)data;
- (NSString*)genRandomID:(NSString *)data;
- (void)del:(int)idx;
- (NSString*)getData:(int)idx;
- (void)setInfo:(int)idx name:(NSString*)name desc:(NSString*)desc;
- (NSMutableArray*)getInfo:(int)idx;
- (void)clearSeq;
- (NSString*)genRid:(int)idx;
- (NSString*)genRid2:(int)idx number:(NSString*)number;
- (NSString*)genRidForMobileLogin:(int)idx;
- (NSString*)genRidForMobileNfcLogin:(int)idx;
- (long)fromUTC;

- (NSString*)getCustomProp:(int)idx;
- (void)setCustomProp:(int)idx value:(NSString*)value;
- (NSString*)getCustomProps; // returned encrypted values
- (void)setCustomProps:(NSString*)data;

- (NSString*)toString1:(NSString*)str; // obfuscating
- (NSString*)toString2:(NSString*)str; // deobfuscating

- (NSString*)getOTID:(NSString *)pin encryptedData:(NSString *)data;
@end

#endif // __libIos_h__
