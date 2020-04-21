//
//  SMS.m
//  AwesomeProject
//
//  Created by Viviksha on 24/03/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(SMS, NSObject)

RCT_EXTERN_METHOD(sendMessage:(NSString *)destinationNumber sourceNumber:(NSString *)sourceNumber messageText:(NSString*)message callback:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(reciveMessage:callback:(RCTResponseSenderBlock)callback)


@end

