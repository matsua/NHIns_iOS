//
//  SsmDelegate.h
//  SsmCallback
//
//  Created by park dong jun on 13. 10. 11..
//  Copyright (c) 2013 Raonsecure. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol InstallAppCallback<NSObject>
@required
- (void)installApp:(NSString *)plistInstallUrl;
@end
// didFinishResponseSuccessCodeWithResult 콜백에서 기능 구분
typedef enum {
    MG_JOB_PID_CHECK_AGENT                        = 0,
    MG_JOB_PID_DEVICE_USER_INFO                   = 1,
    MG_JOB_PID_OFFICE_LOGIN                       = 2,
    MG_JOB_PID_OFFICE_LOGOUT                      = 3,
    MG_JOB_PID_AUTO_LOGIN                         = 4,
    OG_JOB_PID_FIDO_AUTH_PATTERN                  = 5, // 패턴조회에 대한 콜백
    OG_JOB_PID_FIDO_AUTH                          = 6, //  간편인증에 대한 콜백
    MG_JOB_PID_CHECK_OFFICE_VERSION               = 7,
    MG_JOB_PID_DIRECT_LOGIN                       = 8,
} MG_JOB_THREAD_PID;

// didFinishResponseSuccessCodeWithResult 콜백에서 code값으로 구분
typedef enum {
    RESULT_CODE_SUCCESS                           = 0,
    RESULT_CODE_FAIL                              = 1,
    RESULT_CODE_EXIST_AGENT                       = 2,  // mGuard 설치 확인
    RESULT_CODE_NOT_EXIST_DELEGATE                = 3,  // 콜백 미설정
    RESULT_CODE_UNKNOWN_EXCEPTION                 = 4,  // 알수 없는 오류
    RESULT_CODE_TIME_OUT                          = 5,  // 통신 timeout 오류
    RESULT_CODE_NOT_SERVER_INFO                   = 6,  // 서버정보 미설정 오류
    RESULT_CODE_NOT_EXIST_AGENT                   = 7,  // mGuard 미설치 오류
    RESULT_CODE_NOT_EXIST_MDM_PROFILE             = 8,  // mGuard MDM프로파일 삭제
    RESULT_CODE_NOT_LOGIN                         = 9,  // mGuard 미 로그인 유저
    RESULT_CODE_DEVICE_LOST                       = 10, // 분실된 단말
    RESULT_CODE_DEVICE_JAILBREAK                  = 11, // 탈옥된 단말
    RESULT_CODE_INTERNAL_CONNECT_FAIL             = 12, // 엠가드와 연결이 안되는 현상
    RESULT_CODE_MDM_NOT_LAST_VERSION              = 13, // 최신버전이 아닌 MDM
    RESULT_CODE_ERR_URL_CANCELLED                 = 14, // 네트워크 에러: 비동기 로딩이 취소 됨
    RESULT_CODE_ERR_URL_BAD                       = 15, // 네트워크 에러: 잘못된 URL로 요청을 시작하지 못함
    RESULT_CODE_ERR_URL_TIMEOUT                   = 16, // 네트워크 에러: 비동기 작업 시간이 초과 됨
    RESULT_CODE_ERR_URL_UNSUPPORTED               = 17, // 네트워크 에러: 처리할 수 없는 URL
    RESULT_CODE_ERR_URL_NOTCONNECT_HOST           = 18, // 네트워크 에러: 호스트 연결 시도 실패
    RESULT_CODE_ERR_URL_DATA_LENGTH               = 19, // 네트워크 에러: 리소스 데이터의 길이가 초과
    RESULT_CODE_ERR_URL_CONNECTION_LOST           = 20, // 네트워크 에러: 서버 통신 진행중 연결 끊김
    RESULT_CODE_ERR_URL_DNS_LOOKUP_FAIL           = 21, // 네트워크 에러: DNS 조회를 통해 호스트 주소를 찾을 수 없음
    RESULT_CODE_ERR_URL_TOOMANY_REDIRECTS         = 22, // 네트워크 에러: 리다이렉션 임계 값 초과
    RESULT_CODE_ERR_URL_RESOURCE_UNAVAILABLE      = 23, // 네트워크 에러: 요청 리소스 검색 실패
    RESULT_CODE_ERR_URL_NOTCONNECT_INTERNET       = 24, // 네트워크 에러: 인터넷 연결이 설정되어 있지 않음
    RESULT_CODE_ERR_URL_BAD_SERVER_RESPONSE       = 25, // 네트워크 에러: 서버에서 잘못된 데이타를 받음
    RESULT_CODE_ERR_URL_CANCELED_AUTHEN           = 26, // 네트워크 에러: 인증 요청이 사용자에 의해 취소
    RESULT_CODE_ERR_URL_REQUIRED_AUTHEN           = 27, // 네트워크 에러: 리소스에 엑세스하려면 인증이 필요
    RESULT_CODE_ERR_URL_SECURE_CONNECTION_FAIL    = 28, // 네트워크 에러: 보안 연결 실패
} RESULT_CODE;

// controllHwType 메서드 타입
typedef enum {
    FLAG_POLICY_BLOCK_BROWSER                     = 0x00000020,    // 사파리
    FLAG_POLICY_BLOCK_CAMERA                      = 0x00000040,    // 카메라
    FLAG_POLICY_BLOCK_CAPTURE                     = 0x00000400,    // 화면캡쳐
    FLAG_POLICY_BLOCK_APPSTORE                    = 0x00000800,    // 앱스토어
} FLAG_BLOCK_POLICY;


typedef enum TIMEOUT_NETWORK_ERROR_TYPE {
    ConnectionFailureErrorType                    = 1,
    RequestTimedOutErrorType                      = 2,
    AuthenticationErrorType                       = 3,
    RequestCancelledErrorType                     = 4,
    UnableToCreateRequestErrorType                = 5,
    InternalErrorWhileBuildingRequestType         = 6,
    InternalErrorWhileApplyingCredentialsType     = 7,
	FileManagementError                           = 8,
	TooMuchRedirectionErrorType                   = 9,
	UnhandledExceptionError                       = 10,
	CompressionError                              = 11
} NETWORK_ERROR_TYPE;

typedef enum {
    OGStatusNotFoundAaid                           = 0,  // 0x0000
    OGStatusAuthenticateFido,                            // 0x0001
    OGStatusAuthenticateIdPw,                            // 0x0010
    OGStatusAuthenticateIdPwAndFido,                     // 0x0011
//    OGStatusDeniedNotActiveFidoPolicy4,                // 0x0100
//    OGStatusDeniedNotActiveFidoPolicy5,                // 0x0101
//    OGStatusDeniedNotActiveFidoPolicy6,                // 0x0110
//    OGStatusDeniedNotActiveFidoPolicy            = 7,  // 0x0111
    OGStatusSSOLetParsingError                     = 8,  // 0x1000
    OGStatusSSOAuthenticateFido                    = 9,  // 0x1001
//    OGStatusDenied,                                    // 0x1010
    OGStatusSSOAuthenticateIdPwAndFido             = 11, // 0x1011
    OGStatusSSOVerfifyJwt                          = 12, // 0x1100
//    OGStatusDenied1,                                   // 0x1101
    OGStatusSSOAuthenticateIdPwAndMapping          = 14, // 0x1110
//    OGStatusDenied2,                                   // 0x1111
} OGPatterStatus;

typedef enum {
    OGStatusError                                  = 0,
    OGStatusAuthFido                               = 1,
    OGStatusAuthJwt                                = 2,
} OGPatternStatus;

@protocol MGuardDelegate
@required
// 정상 처리
- (void) didFinishResponseSuccessCode:(MG_JOB_THREAD_PID)pidCode withResult:(NSDictionary*)result;
// 네트워크 오류 및 서버 오류로 인한 실패
- (void) didFailResponseErrorCode:(MG_JOB_THREAD_PID)pidCode withResult:(NSDictionary*)result;
@end
