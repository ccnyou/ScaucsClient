//
//  ScaucsSession.h
//  ScaucsClient
//
//  Created by ccnyou on 14-4-7.
//  Copyright (c) 2014年 ccnyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScaucsSession;


@interface ScaucsSession : NSObject

@property (nonatomic, strong) NSString* session;

+ (ScaucsSession *)sharedClient;

@end
