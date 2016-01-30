//
//  AppLogFileManager.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/27.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class AppLogFileManager: DDLogFileManagerDefault {

    let APP_NAME = NSBundle.mainBundle().bundleIdentifier!
    let LOG_FILE_NAME_DATE_FORMAT = "yyyy-MM-dd_HH-mm-ss"
    let LOG_FILE_NAME_SUFFIX = ".log"

    override var newLogFileName: String {
        get {
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
            dateFormatter.dateFormat = LOG_FILE_NAME_DATE_FORMAT

            return "\(APP_NAME)_\(dateFormatter.stringFromDate(NSDate()))\(LOG_FILE_NAME_SUFFIX)"
        }
    }

    override func isLogFile(fileName: String!) -> Bool {
        return fileName.hasPrefix(APP_NAME) && fileName.hasSuffix(LOG_FILE_NAME_SUFFIX)
    }

    override func didArchiveLogFile(logFilePath: String!) {
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        ILog("[CFBundleIdentifier]\(infoDictionary?["CFBundleIdentifier"] as! String) [CFBundleVersion]\(infoDictionary?["CFBundleVersion"] as! String) [CFBundleShortVersionString]\(infoDictionary?["CFBundleShortVersionString"] as! String)")
    }

    override func didRollAndArchiveLogFile(logFilePath: String!) {
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        ILog("[CFBundleIdentifier]\(infoDictionary?["CFBundleIdentifier"] as! String) [CFBundleVersion]\(infoDictionary?["CFBundleVersion"] as! String) [CFBundleShortVersionString]\(infoDictionary?["CFBundleShortVersionString"] as! String)")    }
}
