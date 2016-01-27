//
//  Log.h
//  LogSystem
//
//  Created by Thomson on 16/1/27.
//  Copyright © 2016年 Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

// The main key of Miban log config
// Set it to 0, then only errors will be logged
#define TH_DEBUG_LOG    1

typedef NS_ENUM(NSUInteger, THLogLevel) {
    THLogLevelError     = (1 << 0),
    THLogLevelInfo      = (1 << 1),
    THLogLevelDebug     = (1 << 2)
};

#define TH_LOG_LEVEL_DEF    thLogLevel

#define TH_LOG_MACRO(lvl, flg, frmt, ...)                           \
[[Log sharedInstance] logWithFunction:@(__PRETTY_FUNCTION__)  \
level:lvl                     \
flag:flg                     \
format:frmt, ##__VA_ARGS__]

//
// Public macros
//

/**
 *  Log in error level.
 *
 *  @param frmt Log message format string.
 *  @param ...  Parameter list in log message.
 */

/** @constant THLogError to log in error level */
#define THLogError(frmt, ...)           TH_LOG_MACRO(TH_LOG_LEVEL_DEF, THLogLevelError, frmt, ##__VA_ARGS__)

#if TH_DEBUG_LOG
#define THLogInfo(frmt, ...)        TH_LOG_MACRO(TH_LOG_LEVEL_DEF, THLogLevelInfo, frmt, ##__VA_ARGS__)
#define THLogDebug(frmt, ...)       TH_LOG_MACRO(TH_LOG_LEVEL_DEF, THLogLevelDebug, frmt, ##__VA_ARGS__)
#else
#define THLogInfo(frmt, ...)
#define THLogDebug(frmt, ...)
#endif

static THLogLevel thLogLevel = THLogLevelDebug;

/**
 *  `THLog` class is used to print log in file, ASL and TTY.
 *
 *  Note:
 *  Please prefer to use the macros above, instead of touch the class directly, unless you want to write your looger.
 */
@interface Log : NSObject

/**
 *  The singleton object.
 *
 *  @return The shared instance.
 */
+ (instancetype)sharedInstance;

/**
 *  Print log according to the parameters.
 *
 *  @param function The function name to log.
 *  @param level    The current log level.
 *  @param flag     The defined log flag. The log will be print only when `flag` >= `level`.
 *  @param format   The log message format.
 *  @param ...      The parameter list of message in the format.
 */
- (void)logWithFunction:(NSString *)function level:(int)level flag:(int)flag format:(NSString *)format, ...;

@end
