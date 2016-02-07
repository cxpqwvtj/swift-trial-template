//
//  AppLogFileManager.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/27.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack
import SSZipArchive

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
        DLog(self.appInfo())
    }

    override func didRollAndArchiveLogFile(logFilePath: String!) {
        DLog(self.appInfo())
    }

    func postLogFile(logFile: DDLogFileInfo) {
        let archivedDir = "\(logsDirectory())/archive"
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(archivedDir) {
            do {
                try fileManager.createDirectoryAtPath(archivedDir, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                WLog("\(error)")
            }
        }
        if logFile == AppLogger.sharedInstance.devFileLogger.currentLogFileInfo() {
            VLog("\(logFile.fileName) is current log file")
            AppLogger.sharedInstance.devFileLogger.rollLogFileWithCompletionBlock({[unowned self] () -> Void in
                let latestArchiveFile = AppLogger.sharedInstance.devFileLogManager.sortedLogFileInfos()[1] as! DDLogFileInfo // アーカイブされたファイル
                VLog("to zip file.\(latestArchiveFile.filePath)")
                SSZipArchive.createZipFileAtPath("\(self.logsDirectory())/archive/\(latestArchiveFile.filePath).zip", withFilesAtPaths: [latestArchiveFile.filePath])
            })
        } else {
            VLog("to zip file.\(logFile.filePath)")
            SSZipArchive.createZipFileAtPath("\(logsDirectory())/archive/\(logFile.fileName).zip", withFilesAtPaths: [logFile.filePath])
        }
    }

    private func appInfo() -> String {
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        return "[CFBundleIdentifier]\(infoDictionary?["CFBundleIdentifier"] as! String) [CFBundleVersion]\(infoDictionary?["CFBundleVersion"] as! String) [CFBundleShortVersionString]\(infoDictionary?["CFBundleShortVersionString"] as! String)"
    }
}
