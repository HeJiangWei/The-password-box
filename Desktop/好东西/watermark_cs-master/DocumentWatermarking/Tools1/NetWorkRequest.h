//
//  NetWorkRequest.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^Success)(id responseObject);     // 成功Block
typedef void (^Failure)(NSError *error);        // 失败Block

@interface NetWorkRequest : NSObject
/**
 超时时间 默认20秒
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

+(instancetype)sharedNetWork;


/**
 GET 请求封装
 
 @param URLString  请求链接
 @param parameters 请求参数
 @param success    请求成功回调
 @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString
   delegate:(id )delegate
 parameters:(NSMutableDictionary *)parameters
    success:(Success)success
    failure:(Failure)failure;


/**
 POST 请求回调
 
 @param URLString  请求链接
 @param parameters 请求参数
 @param success    请求成功回调
 @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString
    delegate:(id )delegate
  parameters:(NSMutableDictionary *)parameters
     success:(Success)success
     failure:(Failure)failure;

@end
