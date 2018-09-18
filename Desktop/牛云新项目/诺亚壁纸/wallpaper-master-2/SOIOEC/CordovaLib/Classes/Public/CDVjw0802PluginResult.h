/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import <Foundation/Foundation.h>
#import "CDVAvailability.h"

typedef enum {
    CDVCommandStatus_NO_RESULT = 0,
    CDVCommandStatus_OK,
    CDVCommandStatus_CLASS_NOT_FOUND_EXCEPTION,
    CDVCommandStatus_ILLEGAL_ACCESS_EXCEPTION,
    CDVCommandStatus_INSTANTIATION_EXCEPTION,
    CDVCommandStatus_MALFORMED_URL_EXCEPTION,
    CDVCommandStatus_IO_EXCEPTION,
    CDVCommandStatus_INVALID_ACTION,
    CDVCommandStatus_JSON_EXCEPTION,
    CDVCommandStatus_ERROR
} CDVCommandStatus;

@interface CDVjw0802PluginResult : NSObject {}

@property (nonatomic, strong, readonly) NSNumber* status;
@property (nonatomic, strong, readonly) id message;
@property (nonatomic, strong)           NSNumber* keepCallback;
// This property can be used to scope the lifetime of another object. For example,
// Use it to store the associated NSData when `message` is created using initWithBytesNoCopy.
@property (nonatomic, strong) id associatedObject;

- (CDVjw0802PluginResult*)init;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsString:(NSString*)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsArray:(NSArray*)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsInt:(int)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsNSInteger:(NSInteger)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsNSUInteger:(NSUInteger)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsDouble:(double)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsBool:(BOOL)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsDictionary:(NSDictionary*)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsArrayBuffer:(NSData*)theMessage;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsMultipart:(NSArray*)theMessages;
+ (CDVjw0802PluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageToErrorObject:(int)errorCode;

+ (void)setVerbose:(BOOL)verbose;
+ (BOOL)isVerbose;

- (void)setKeepCallbackAsBool:(BOOL)bKeepCallback;

- (NSString*)argumentsAsJSON;

@end
