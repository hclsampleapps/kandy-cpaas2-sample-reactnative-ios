
#import <Foundation/Foundation.h>
#import "React/RCTEventEmitter.h"
#import "React/RCTBridgeModule.h"
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(Call,RCTViewManager)

RCT_EXTERN_METHOD(initCallModule:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(endCall:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(muteCall:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(unmuteCall:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(holdCall:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(unholdCall:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(setOutGoingCall:(NSString *)destinationNumber  callback:(RCTResponseSenderBlock)callback)

@end

