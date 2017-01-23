#import "Simulator.h"
#import "KillSimulatorCommand.h"
#import "DeviceUtils.h"

@implementation KillSimulatorCommand
+ (NSString *)name {
    return @"kill_simulator";
}

+ (NSArray <CommandOption *> *)options {
    static NSMutableArray *options;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        options = [NSMutableArray array];
        [options addObject:[CommandOption withShortFlag:DEVICE_ID_FLAG
                                               longFlag:@"--device-id"
                                             optionName:@"device-identifier"
                                                   info:@"iOS Simulator GUIDs"
                                               required:NO
                                             defaultVal:nil]];
    });
    return options;
}

+ (iOSReturnStatusCode)execute:(NSDictionary *)args {
    
    Device *device = [self deviceFromArgs:args];
    if (!device) {
        return iOSReturnStatusCodeDeviceNotFound;
    } else if ([DeviceUtils isDeviceID:device.uuid]) {
        device = [Device withID:[Device defaultSimulatorID]];
    }
    
    return [device kill];
}
@end
