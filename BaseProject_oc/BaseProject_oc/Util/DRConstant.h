//
//  DRConstant.h
//  loop
//
//  Created by doom on 16/8/1.
//  Copyright © 2016年 DOOM. All rights reserved.
//

#ifndef DRConstant_h
#define DRConstant_h

static NSInteger const kDefaultTenPerPageNumber = 10;

/**
 *  Color
 */

#define kGrayBackColor  UIColorHex(f8f8f8)
#define kLineColor  UIColorHex(dfdfdf)
#define kBlackFontColor  UIColorHex(333333)
#define kGreenFontColor  UIColorHex(76bf33)
#define kRedFontColor  UIColorHex(ff3b30)

/**
 *  Notificaton
 */

#define kNotificationRefreshMineInfo @"kNotificationRefreshMineInfo"
#define kNotificationStopPlayVoice @"kNotificationStopPlayVoice"
#define kNotificationReceiveGroupMessage @"kNotificationReceiveGroupMessage"
#define kNotificationReceiveMessage @"kNotificationReceiveMessage"
#define kNotificationPostNeed @"kNotificationPostNeed"
#define kNotificationRefreshOrderList @"kNotificationRefreshOrderList"

/**
 *  Block
 */

typedef void (^VoidBlock)(void);

typedef BOOL (^BoolBlock)(void);

typedef int  (^IntBlock)(void);

typedef id   (^IDBlock)(void);

typedef void (^VoidBlock_int)(NSInteger);

typedef void (^VoidBlock_bool)(BOOL);

typedef BOOL (^BoolBlock_int)(NSInteger);

typedef int  (^IntBlock_int)(NSInteger);

typedef id   (^IDBlock_int)(NSInteger);

typedef void (^VoidBlock_string)(NSString *);

typedef BOOL (^BoolBlock_string)(NSString *);

typedef int  (^IntBlock_string)(NSString *);

typedef id   (^IDBlock_string)(NSString *);

typedef void (^VoidBlock_id)(id);

typedef BOOL (^BoolBlock_id)(id);

typedef int  (^IntBlock_id)(id);

typedef id   (^IDBlock_id)(id);


//A better version of NSLog
#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#ifdef DEBUG
#define DLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DLog(format, ...)
#endif

#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#define TrueAssign_EXEC(dic, value) if (value) { dic = value; };

#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kSafeArea_Top (kDevice_Is_iPhoneX? 44: 20)
#define kSafeArea_Bottom (kDevice_Is_iPhoneX? 34: 0)

#endif /* DRConstant_h */
