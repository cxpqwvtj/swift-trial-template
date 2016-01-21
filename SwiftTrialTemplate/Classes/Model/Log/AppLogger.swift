//
//  AppLogger.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/18.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class AppLogger: NSObject {
    static var logsDirectory: String?

    static func setup() {
        setenv("XcodeColors", "YES", 0);
        DDTTYLogger.sharedInstance().logFormatter = AppLogFormatter()
        DDTTYLogger.sharedInstance().colorsEnabled = true
        DDTTYLogger.sharedInstance().setForegroundColor(UIColor.blueColor(), backgroundColor: nil, forFlag: DDLogFlag.Info)
        DDTTYLogger.sharedInstance().setForegroundColor(UIColor.blackColor(), backgroundColor: nil, forFlag: DDLogFlag.Debug)
        DDTTYLogger.sharedInstance().setForegroundColor(UIColor.darkGrayColor(), backgroundColor: nil, forFlag: DDLogFlag.Verbose)
        DDLog.addLogger(DDTTYLogger.sharedInstance()) // TTY = Xcode console

        DDASLLogger.sharedInstance().logFormatter = AppLogFormatter()
        DDLog.addLogger(DDASLLogger.sharedInstance()) // ASL = Apple System Logs

        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.logFormatter = AppLogFormatter()
        fileLogger.maximumFileSize = 1 * 1024 * 1024  // 1MB
        fileLogger.logFileManager.maximumNumberOfLogFiles = 10
        logsDirectory = fileLogger.logFileManager.logsDirectory()
        DDLog.addLogger(fileLogger)
    }
}

public func DDLogDebug(@autoclosure logText: () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = __FILE__, function: StaticString = __FUNCTION__, line: UInt = __LINE__, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    CocoaLumberjack.DDLogDebug(logText, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async)
}

public func DDLogInfo(@autoclosure logText: () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = __FILE__, function: StaticString = __FUNCTION__, line: UInt = __LINE__, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    CocoaLumberjack.DDLogInfo(logText, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async)
}

public func DDLogWarn(@autoclosure logText: () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = __FILE__, function: StaticString = __FUNCTION__, line: UInt = __LINE__, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    CocoaLumberjack.DDLogWarn(logText, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async)
}

public func DDLogVerbose(@autoclosure logText: () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = __FILE__, function: StaticString = __FUNCTION__, line: UInt = __LINE__, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    CocoaLumberjack.DDLogVerbose(logText, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async)
}

public func DDLogError(@autoclosure logText: () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = __FILE__, function: StaticString = __FUNCTION__, line: UInt = __LINE__, tag: AnyObject? = nil, asynchronous async: Bool = false) {
    CocoaLumberjack.DDLogError(logText, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async)
}
