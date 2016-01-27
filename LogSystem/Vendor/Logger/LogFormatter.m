//
//  LogFormatter.m
//  LogSystem
//
//  Created by Thomson on 16/1/27.
//  Copyright © 2016年 Thomson. All rights reserved.
//

#import "LogFormatter.h"

@implementation LogFormatter

- (instancetype)init
{
    if (self = [super init])
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    }

    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *strLevel = nil;

    if (logMessage.flag <= DDLogLevelError)
    {
        strLevel = @"[ERROR]";
    }
    else if (logMessage.flag <= DDLogLevelInfo)
    {
        strLevel = @"[INFO]";
    }
    else
    {
        strLevel = @"[DEBUG]";
    }

    NSString *strTime = [_dateFormatter stringFromDate:logMessage.timestamp];

    return [NSString stringWithFormat:@"%@ %@ %@ %@", strTime, strLevel, logMessage.function, logMessage.message];
}

- (void)didAddToLogger:(id<DDLogger>)logger
{
    _loggerCount++;
}

- (void)willRemoveFromLogger:(id<DDLogger>)logger
{
    _loggerCount--;
}

@end
