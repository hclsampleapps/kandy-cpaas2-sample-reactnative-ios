
#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(login, NSObject)

RCT_EXTERN_METHOD(loginInApp:(NSString *)name password:(NSString *)password
                  email:(NSString *)email url:(NSString *)url callback:(RCTResponseSenderBlock)callback)
@end
