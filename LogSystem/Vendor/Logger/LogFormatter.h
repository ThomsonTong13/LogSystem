//
//  LogFormatter.h
//  LogSystem
//
//  Created by Thomson on 16/1/27.
//  Copyright © 2016年 Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

@interface LogFormatter : NSObject <DDLogFormatter>
{
    int                     _loggerCount;
    NSDateFormatter         *_dateFormatter;
}

@end
