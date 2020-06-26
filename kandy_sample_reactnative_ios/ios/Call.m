
#import <Foundation/Foundation.h>
#import "React/RCTEventEmitter.h"
#import "React/RCTBridgeModule.h"
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(Call,RCTViewManager)

RCT_EXTERN_METHOD(initCallModule:(RCTResponseSenderBlock)callback)

@end

