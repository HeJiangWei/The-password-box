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

#import "CDVjw0802Timer.h"

#pragma mark CDVjw0802TimerItem

@interface CDVjw0802TimerItem : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSDate* started;
@property (nonatomic, strong) NSDate* ended;

- (void)log;

@end

@implementation CDVjw0802TimerItem

- (void)log
{
    NSLog(@"[CDVjw0802Timer][%@] %fms", self.name, [self.ended timeIntervalSinceDate:self.started] * 1000.0);
}

@end

#pragma mark CDVjw0802Timer

@interface CDVjw0802Timer ()

@property (nonatomic, strong) NSMutableDictionary* items;

@end

@implementation CDVjw0802Timer

#pragma mark object methods

- (id)init
{
    if (self = [super init]) {
        self.items = [NSMutableDictionary dictionaryWithCapacity:6];
    }

    return self;
}

- (void)add:(NSString*)name
{
    if ([self.items objectForKey:[name lowercaseString]] == nil) {
        CDVjw0802TimerItem* item = [CDVjw0802TimerItem new];
        item.name = name;
        item.started = [NSDate new];
        [self.items setObject:item forKey:[name lowercaseString]];
    } else {
        NSLog(@"Timer called '%@' already exists.", name);
    }
}

- (void)remove:(NSString*)name
{
    CDVjw0802TimerItem* item = [self.items objectForKey:[name lowercaseString]];

    if (item != nil) {
        item.ended = [NSDate new];
        [item log];
        [self.items removeObjectForKey:[name lowercaseString]];
    } else {
        NSLog(@"Timer called '%@' does not exist.", name);
    }
}

- (void)removeAll
{
    [self.items removeAllObjects];
}

#pragma mark class methods

+ (void)start:(NSString*)name
{
    [[CDVjw0802Timer sharedInstance] add:name];
}

+ (void)stop:(NSString*)name
{
    [[CDVjw0802Timer sharedInstance] remove:name];
}

+ (void)clearAll
{
    [[CDVjw0802Timer sharedInstance] removeAll];
}

+ (CDVjw0802Timer*)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static CDVjw0802Timer* _sharedObject = nil;

    dispatch_once(&pred, ^{
            _sharedObject = [[self alloc] init];
        });

    return _sharedObject;
}

@end
