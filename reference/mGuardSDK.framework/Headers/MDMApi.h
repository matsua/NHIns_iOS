//
//  MDMApi.h
//  MDMApi
//
//  Created by park dong jun on 13. 08. 02..
//  Copyright (c) 2016 Raonsecure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGuardDelegate.h"


@class MGuardManager;
@interface MDMApi :NSObject

+(MDMApi *)instance;

-(NSString *)RS_MDM_GetVersion;
// 1. sdk 콜백
// mGuard 델리게이트 사용시 Delegate, blockAPI 사용시 RS_MDM_BlockAPI 설정(같이 사용 가능)
-(void)RS_MDM_Delegate:(id<MGuardDelegate>)delegate;
-(void)RS_MDM_BlockAPI:(BOOL)use;

// 2. mGuard 서버 도메인 정보 설정
-(void)RS_MDM_SetMGuardServerInfo:(NSString *)serverUrl;
-(NSString *)RS_MDM_GetMGuardServerInfo;

// 계열사 Key 설정
-(void)RS_MDM_SetCompanyKey:(NSString *)companyKey;


// 3. 연동라이브러리 초기화, url, delegate 설정유무 ,에이전트 설치유무 - 키체인연동
-(int)RS_MDM_Init:(NSString *)sharedData;

// 업무앱, 원가드 다른 인증서 사용시 키체인 공유 test 버전
-(BOOL)RS_MDM_Init_Test:(NSString *)urlScheme;

// 4. Agent 버전 위변조 설치/업데이트 체크 - 서버통신
-(void)RS_MDM_CheckAgent;
-(void)RS_MDM_CheckAgent:(void (^)(int pid, NSDictionary* result))success
              errorBlock:(void (^)(int pid, NSDictionary* result))fail;

// 4. Agent 버전 위변조 설치/업데이트 체크 - 서버통신(원가드 V1.0.2.3.24 버전부터 사용가능)
-(void)RS_MDM_CheckAgent:(NSString *)urlScheme;
-(void)RS_MDM_CheckAgent:(NSString *)urlScheme
        withSuccessBlock:(void (^)(int pid, NSDictionary* result))success
              errorBlock:(void (^)(int pid, NSDictionary* result))fail;

/* 5. 사용자정보: 이름, 아이디, 부서명, 직급 - 서버통신
    단말 정보: DEVICE_ID, 전화번호, IMEI, 시리얼 NO 등
*/
-(void)RS_MDM_GetDeviceUserInfo;
-(void)RS_MDM_GetDeviceUserInfo:(void (^)(int pid, NSDictionary* result))success
              errorBlock:(void (^)(int pid, NSDictionary* result))fail;

// 6. MDM 프로파일 설치
-(void)RS_MDM_InstallMDMProfile;

// 7. mGuard설치
-(void)RS_MDM_InstallAgent;

// 8. 로그인 페이지 유도
-(void)RS_MDM_GoMDMLogin;

// 9. 업무 진입 - 서버통신
-(void)RS_MDM_LoginOffice;
-(void)RS_MDM_LoginOffice:(void (^)(int pid, NSDictionary* result))success
              errorBlock:(void (^)(int pid, NSDictionary* result))fail;

// 10. 업무 종료 - 서버통신
-(void)RS_MDM_LogoutOffice;
-(void)RS_MDM_LogoutOffice:(void (^)(int pid, NSDictionary* result))success
              errorBlock:(void (^)(int pid, NSDictionary* result))fail;

// fido2차 officeCode 파라미터 추가
// 11. FIDO 패턴조회 리펙토링 전 버전
-(void)RS_MDM_GetFidoPattern:(NSString *)urlScheme
              withOfficeCode:(NSString *)officeCode
              withSuccessBlock:(void (^)(int pid, NSDictionary* result))aSuccessEvent
              errorBlock:(void (^)(int pid, NSDictionary* result))aFailEvent;

// FIDO 패턴조회 리펙토링 버전
-(void)RS_MDM_GetFidoPattern:(NSString *)urlScheme
              officeCode:(NSString *)officeCode
              serviceChallenge:(NSString *)serviceChallenge
              authFido:(void (^)(int pid, NSString *msg, NSDictionary* result))authFidoEvent
              verifyJwt:(void (^)(int pid, NSString* jwt, NSDictionary* result))verifyJwtEvent
              onError:(void (^)(int pid, NSDictionary* result))errorEvent;


// 12. 고객사 로그인 비즈니스 로직 종료 후 호출 (fido2차 업무코드 파라미터 추가)
-(void)RS_MDM_FidoAuth:(NSString *)urlScheme
              withLoginId:(NSString *)loginId
              withOfficeCode:(NSString *)officeCode
              withSuccessBlock:(void (^)(int pid, NSDictionary* result))aSuccessEvent
              errorBlock:(void (^)(int pid, NSDictionary* result))aFailEvent;

// 13. 로그인 페이지 유도
-(void)RS_MDM_FidoGoRegister;

//14. 원패스 인증(원패스 모듈 연동시)
-(void) RS_MDM_AuthOffice:(NSString*)callFrom serviceTrId:(NSString *)serviceTrId trId:(NSString*)trId serviceId:(NSString*)serviceId loginId:(NSString*)loginId;

//15.업무앱 버전체크 (서버버전 1.0.2.24이상 지원)
-(void) RS_CheckOfficeUpdate:(NSString*)packageName
                  doProccess:(void (^)(int pid, NSDictionary* result, id<InstallAppCallback>callback))doProccess
            withSuccessEvent:(void (^)(int pid, NSDictionary* result))aSuccessEvent
              withErrorBlock:(void (^)(int pid, NSDictionary* result))aFailEvent;

//16. 다이렉트 로그인
-(void) RS_MDM_LoginDirectly:(NSString *)urlScheme
                withUserId:(NSString *)userId
                withUserPw:(NSString *)pw
                withSuccessBlock:(void (^)(int pid, NSDictionary* result))aSuccessEvent
                errorBlock:(void (^)(int pid, NSDictionary* result))aFailEvent;

@end

