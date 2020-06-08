
#import <Foundation/Foundation.h>
#import "React/RCTEventEmitter.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(Directory,RCTEventEmitter)

RCT_EXTERN_METHOD(initDirectoryModule:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(searchContactKeyWord:(NSString *)jsonObject callback:(RCTResponseSenderBlock)callback)

@end
