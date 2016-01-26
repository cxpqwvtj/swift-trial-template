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

    override var newLogFileName: String {
        get {
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
            dateFormatter.dateFormat = "yyyy-MM-dd_HHmmss"

            return "\(NSBundle.mainBundle().bundleIdentifier)\(dateFormatter.stringFromDate(NSDate())).log"
        }
    }

    override func isLogFile(fileName: String!) -> Bool {
        return super.isLogFile(fileName)
    }
}
