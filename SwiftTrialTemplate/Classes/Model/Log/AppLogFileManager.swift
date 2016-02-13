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
import Alamofire

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
            let zipFilePath = "\(logsDirectory())/archive/\(logFile.fileName).zip"
            SSZipArchive.createZipFileAtPath(zipFilePath, withFilesAtPaths: [logFile.filePath])
            let fileUrl = NSURL(fileURLWithPath: zipFilePath)
            Alamofire.upload(.POST, "http://localhost:8080/api/upload"
                , multipartFormData: { (multipartFormData) -> Void in
                    multipartFormData.appendBodyPart(fileURL: fileUrl, name: "zipLogFile")
                    do {
                        let json = try NSJSONSerialization.dataWithJSONObject(["jsonkey":"value"], options: NSJSONWritingOptions.PrettyPrinted)
                        multipartFormData.appendBodyPart(data: json, name: "json")
                    } catch let error as NSError {
                        WLog("\(error)")
                    }
                }, encodingCompletion: { (encodingResult) -> Void in
                    switch encodingResult {
                    case .Success(let upload, _, _):
                        upload.responseJSON { response in
                            ExtLog("\(response)")
                        }
                    case .Failure(let encodingError):
                        ExtLog("\(encodingError)")
                    }
            })
            Alamofire.upload(.POST, "http://localhost:8080/api/upload", file: fileUrl)
                .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                    DLog("[bytesWritten]\(bytesWritten) [totalBytesWritten]\(totalBytesWritten) [totalBytesExpectedToWrite]\(totalBytesExpectedToWrite)")
            }
            ExtLog("[POST]http://localhost:8080/api/upload [data]\(zipFilePath)")
        }
    }

    private func appInfo() -> String {
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        return "[CFBundleIdentifier]\(infoDictionary?["CFBundleIdentifier"] as! String) [CFBundleVersion]\(infoDictionary?["CFBundleVersion"] as! String) [CFBundleShortVersionString]\(infoDictionary?["CFBundleShortVersionString"] as! String)"
    }
}
