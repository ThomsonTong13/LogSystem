//
//  Log.m
//  LogSystem
//
//  Created by Thomson on 16/1/27.
//  Copyright © 2016年 Thomson. All rights reserved.
//

#import "Log.h"
#import "LogFormatter.h"

// Log levels: off, error, warn, info, verbose
#if TH_DEBUG_LOG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif

@implementation Log

+ (instancetype)sharedInstance
{
    static Log *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Log alloc] init];
    });

    return _sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self addLoggers];
    }

    return self;
}

- (void)addLoggers
{
    LogFormatter *formater = [[LogFormatter alloc] init];

#if TH_DEBUG_LOG
    [[DDASLLogger sharedInstance] setLogFormatter:formater];
    [[DDTTYLogger sharedInstance] setLogFormatter:formater];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
#endif

    NSString *path = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    DDLogFileManagerDefault *logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:path];

    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hours rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    fileLogger.logFormatter = formater;

    [DDLog addLogger:fileLogger];
}

- (void)logWithFunction:(NSString *)function level:(int)level flag:(int)flag format:(NSString *)format, ...
{
    if (level < flag) return;

    DDLogFlag ddflag = DDLogFlagError;

    if (flag == THLogLevelError)        ddflag = DDLogFlagError;
    else if (flag == THLogLevelInfo)    ddflag = DDLogFlagInfo;
    else if (flag == THLogLevelDebug)   ddflag = DDLogFlagVerbose;

    if ((ddflag & LOG_LEVEL_DEF) == 0) return;

    va_list args;
    va_start(args, format);

    [DDLog log:LOG_ASYNC_ENABLED
         level:LOG_LEVEL_DEF
          flag:ddflag
       context:0
          file:nil
      function:[function UTF8String]
          line:0
           tag:nil
        format:format
          args:args];

    va_end(args);
}

@end
