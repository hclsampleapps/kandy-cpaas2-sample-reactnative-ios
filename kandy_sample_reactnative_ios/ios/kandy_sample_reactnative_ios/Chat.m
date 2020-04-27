
#import <Foundation/Foundation.h>
#import "React/RCTEventEmitter.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(Chat,RCTEventEmitter)

RCT_EXTERN_METHOD(sendChat:(NSString *)destinationId messageText:(NSString*)message callback:(RCTResponseSenderBlock)callback)

@end
