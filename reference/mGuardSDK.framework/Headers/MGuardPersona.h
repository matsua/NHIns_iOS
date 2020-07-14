//
//  MGuardPersona.h
//  MGuard
//
//  Created by dong jun park on 2016. 5. 25..
//
//

#import <Foundation/Foundation.h>
#import "MGuardDelegate.h"
@class MGuardManager;
typedef void (^completeBlock)(NSString *result);

@interface MGuardPersona : NSObject


+ (MGuardPersona *) instance;

-(NSString *)RS_MDM_GetVersion;
// 2. mGuard 서버 도메인 정보 설정
-(void)RS_MDM_SetMGuardServerInfo:(NSString *)serverUrl;
-(NSString *)RS_MDM_GetMGuardServerInfo;
// 3. 연동라이브러리 초기화, url, delegate 설정유무 ,에이전트 설치유무 - 키체인연동
-(int)RS_MDM_Init:(NSString *)sharedData;
// 11. Fido 시작 - 서버통
- (void)RS_MDM_GetFidoPattern:(NSString *)urlScheme withSuccessBlock:(void (^)(int pid, NSDictionary* result))aSuccessEvent
          errorBlock:(void (^)(int pid, NSDictionary* result))aFailEvent;

// 12. 고객사 로그인 비즈니스 로직 종료 후 호출
-(void)RS_MDM_FidoAuth:(NSString *)urlScheme withLoginId:(NSString *)loginId withSuccessBlock:(void (^)(int pid, NSDictionary* result))aSuccessEvent
            errorBlock:(void (^)(int pid, NSDictionary* result))aFailEvent;

// 13. 로그인 페이지 유도
-(void)RS_MDM_FidoGoRegister;

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 에 적용
- (void) RS_MDM_NotifyPersona;

//- (void)applicationDidBecomeActive:(UIApplication *)application 에 적용
- (void) RS_MDM_CheckPersona:(NSString*)urlscheme;

//- (void)applicationWillResignActive:(UIApplication *)application 에 적용
- (void) RS_MDM_ResignActivePersona;

// 사용자/단말 정보 요청(키체인)
- (void) RS_MDM_LoadKeychainSharedDataWithSuccessBlock:(void (^)(int pid, NSDictionary* result))aSuccessEvent
                                         errorBlock:(void (^)(int pid, NSDictionary* result))aFailEvent;
@end
