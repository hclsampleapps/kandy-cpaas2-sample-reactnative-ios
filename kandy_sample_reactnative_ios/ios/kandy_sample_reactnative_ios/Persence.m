
#import <Foundation/Foundation.h>
#import "React/RCTEventEmitter.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(Persence,RCTEventEmitter)

RCT_EXTERN_METHOD(setPersence:(NSString *)currentStatus callback:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(getPersence:(NSString *)subscriberId callback:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(initPresenceModule:(RCTResponseSenderBlock)callback)

@end
