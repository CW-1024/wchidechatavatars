#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 声明外部类和方法
@interface WCPluginsMgr : NSObject
+ (instancetype)sharedInstance;
- (void)registerSwitchWithTitle:(NSString *)title key:(NSString *)key;
@end

%hook CommonMessageViewModel

- (BOOL)isShowHeadImage {
    // 检查开关状态，默认返回 NO（不显示头像）
    BOOL isEnabled = NO;
    
    // 如果有插件管理器，读取开关状态
    Class pluginsMgrClass = objc_getClass("WCPluginsMgr");
    if (pluginsMgrClass) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        isEnabled = [defaults boolForKey:@"HideMessageHeadImage_Enabled"];
    }
    
    // 如果开关开启，返回 NO（隐藏头像）；如果开关关闭，返回原值
    if (isEnabled) {
        return NO;
    } else {
        return %orig;
    }
}

%end

// 插件初始化
__attribute__((constructor)) static void constructor() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (NSClassFromString(@"WCPluginsMgr")) {
            // 注册一个开关，用于控制是否隐藏消息头像
            [[objc_getClass("WCPluginsMgr") sharedInstance] registerSwitchWithTitle:@"隐藏消息头像" key:@"HideMessageHeadImage_Enabled"];
        }
    });
}