
#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(SMS, RCTEventEmitter)

RCT_EXTERN_METHOD(sendMessage:(NSString *)destinationNumber sourceNumber:(NSString *)sourceNumber messageText:(NSString*)message callback:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(initSMSModule:(RCTResponseSenderBlock)callback)

@end

