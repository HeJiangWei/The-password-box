//
//  NetWorkRequest.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NetWorkRequest.h"
#import "RequestAPI.h"

#define TIMEOUTINTERVAL 30   //超时时间
static NetWorkRequest *instace = nil;

@interface NetWorkRequest()

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation NetWorkRequest

+ (instancetype)sharedNetWork{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self alloc] init];
    });
    
    return instace;
    
}

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //返回数据的序列化器
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        // 设置超时时间 放到请求格式后设置时间  否则不生效
        _manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : TIMEOUTINTERVAL);

        //添加状态栏请求网络
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    }
    return self;
    
}

/*
 *  返回签名
 */
-(NSString*)signString:(NSMutableDictionary*)dic{
    
    if (dic.count) {
        NSArray *allKeyArray = [dic allKeys];
        NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSComparisonResult resuest = [obj2 compare:obj1];
            return resuest;
        }];
        
        //通过排列的key值获取value
        NSMutableArray *valueArray = [NSMutableArray array];
        for (NSString *sortsing in afterSortKeyArray) {
            NSString *valueString = [dic objectForKey:sortsing];
            [valueArray addObject:valueString];
        }
        
        NSMutableString *mutString=[[NSMutableString alloc]init];
        for (int i = afterSortKeyArray.count-1 ; i > 0 ; i--) {
            [mutString appendFormat:@"%@=%@&",afterSortKeyArray[i],valueArray[i]];
        }
        [mutString deleteCharactersInRange:NSMakeRange(mutString.length-1, 1)];
        NSString *upstring = [Tools stringToMD5:mutString].uppercaseString;
        NSString *lastString = [upstring substringFromIndex:(upstring.length-16)];
        return lastString;
    }
    return @"";
    
}

/*
 *  返回字符串
 */
-(NSString*)returnSting:(NSMutableDictionary*)dic{
    
    NSArray *allKeyArray = [dic allKeys];

    NSMutableString *string = @"".mutableCopy;
    for (NSString *key in allKeyArray) {
        [string appendFormat:@"%@=%@&",key,dic[key]];
    }
    
    [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];
    
    return string;
    
}


-(void)GET:(NSString *)URLString delegate:(id)delegate parameters:(NSMutableDictionary *)parameters success:(Success)success failure:(Failure)failure{
    
    
    NSString *signString = [self signString:parameters];
    
    [parameters setObject:signString forKey:@"sign"];
    
    URLString = [NSString stringWithFormat:@"%@%@",kBaseUrl,URLString];
    
    [_manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

        if (success)
        {
            //转换成json
            success(dic);
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];

}

-(void)POST:(NSString *)URLString delegate:(id)delegate parameters:(NSMutableDictionary *)parameters success:(Success)success failure:(Failure)failure{
    
    NSString *signString = [self signString:parameters];
    
    [parameters setObject:signString forKey:@"sign"];
    
//    NSString *url = [self resignString    __NSCFString *    @"C8E9DE0EDF5AB1418F93E671826088A2"    0x00000001c0a61f40turnSting:parameters];
    URLString = [NSString stringWithFormat:@"%@%@",kBaseUrl,URLString];

    [_manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (success) {
            success(responseObject);
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSData *data = (NSData*)error;
//
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        if (failure) {
            failure(error);
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画

    }];
    
    
}



@end
