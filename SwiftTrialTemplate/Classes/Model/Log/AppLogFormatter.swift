//
//  AppLogFormatter.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/18.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class AppLogFormatter: NSObject, DDLogFormatter {
    private(set) var threadUnsafeDateFormatter: NSDateFormatter
    
    internal override init() {
        threadUnsafeDateFormatter = NSDateFormatter()
        threadUnsafeDateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        threadUnsafeDateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
    }

    /**
     * MARK: DDLogFormatter
     */
    func formatLogMessage(logMessage: DDLogMessage!) -> String! {
        var logLevel: String
        
        switch (logMessage.flag) {
        case DDLogFlag.Error    : logLevel = "ERROR  "; break
        case DDLogFlag.Warning  : logLevel = "WARN   "; break
        case DDLogFlag.Info     : logLevel = "INFO   "; break
        case DDLogFlag.Debug    : logLevel = "DEBUG  "; break
        default                 : logLevel = "VERBOSE"; break
        }
        
        let dateAndTime = threadUnsafeDateFormatter.stringFromDate(logMessage.timestamp)
        
        return "\(dateAndTime) \(logLevel)(\(logMessage.threadID)) \(logMessage.fileName)[\(logMessage.line)] \(logMessage.message)"
    }
}
