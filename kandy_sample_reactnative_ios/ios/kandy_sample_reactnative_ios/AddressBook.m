
#import <Foundation/Foundation.h>
#import "React/RCTEventEmitter.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(AddressBook,RCTEventEmitter)

RCT_EXTERN_METHOD(initAddressBookModule:(RCTResponseSenderBlock)callback)

@end

