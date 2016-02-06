//
//  AppFileLogFormatter.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/06.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class AppFileLogFormatter: AppLogFormatter {
    static private let bundleVersion = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as! String
    static private let bundleShortVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
    
    /**
     * MARK: DDLogFormatter
     */
    override func formatLogMessage(logMessage: DDLogMessage!) -> String! {
        var logLevel: String
        
        switch (logMessage.flag) {
        case DDLogFlag.Error    : logLevel = "ERROR  "; break
        case DDLogFlag.Warning  : logLevel = "WARN   "; break
        case DDLogFlag.Info     : logLevel = "INFO   "; break
        case DDLogFlag.Debug    : logLevel = "DEBUG  "; break
        default                 : logLevel = "VERBOSE"; break
        }
        
        let dateAndTime = threadUnsafeDateFormatter.stringFromDate(logMessage.timestamp)
        
        return "\(dateAndTime) \(logLevel)[\(AppFileLogFormatter.bundleShortVersion)(\(AppFileLogFormatter.bundleVersion))](\(logMessage.threadID)) \(logMessage.fileName)#\(logMessage.function)[\(logMessage.line)] \(logMessage.message)"
    }
}
