#import <UIKit/UIKit.h>

// 定义开关的key
#define kHideHeadImageKey @"HideHeadImageSwitch"

%hook CommonMessageViewModel
- (BOOL)isShowHeadImage {
    // 检查开关状态，如果开启则返回NO（不显示头像）
    BOOL hideHeadImage = [[NSUserDefaults standardUserDefaults] boolForKey:kHideHeadImageKey];
    if (hideHeadImage) {
        return NO;
    }
    return %orig; // 如果开关关闭，则执行原始逻辑
}
%end

// 插件初始化
%ctor {
    // 注册到插件管理
    if (NSClassFromString(@"WCPluginsMgr")) {
        [[objc_getClass("WCPluginsMgr") sharedInstance] registerSwitchWithTitle:@"隐藏聊天头像" key:kHideHeadImageKey];
    }
}