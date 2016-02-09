//
//  ExternalLogFormatter.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/31.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ExternalLogFormatter: NSObject, DDLogFormatter {

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
        case DDLogFlag.Debug    : logLevel = "DEBUG  "; return nil
        default                 : logLevel = "VERBOSE"; return nil
        }

        if logMessage.flag == DDLogFlag.Info {
            if let tag = logMessage.tag {
                if tag as! String != AppLogFormatter.EXT_LOG_TAG {
                    return nil
                }
            } else {
                return nil
            }
        }

        let dateAndTime = threadUnsafeDateFormatter.stringFromDate(logMessage.timestamp)

        return "\(dateAndTime) \(logLevel)(\(logMessage.threadID)) \(logMessage.fileName)#\(logMessage.function)[\(logMessage.line)] \(logMessage.message)"
    }
}
