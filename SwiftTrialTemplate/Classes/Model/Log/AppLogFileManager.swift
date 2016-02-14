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
            let zipFileName = "\(logFile.fileName).zip"
            let zipFilePath = "\(logsDirectory())/archive/\(zipFileName)"
            if fileManager.fileExistsAtPath(zipFilePath) {
                DLog("zip file exists.")
            } else {
                SSZipArchive.createZipFileAtPath(zipFilePath, withFilesAtPaths: [logFile.filePath])
            }
            let fileUrl = NSURL(fileURLWithPath: zipFilePath)
            Alamofire.upload(.POST, "http://localhost:8080/api/upload"
                , multipartFormData: { (multipartData) -> Void in
                    multipartData.appendBodyPart(fileURL: fileUrl, name: "zipLogFile", fileName: zipFileName, mimeType: "application/zip")
                    do {
                        let device = UIDevice.currentDevice()
                        let obj = ["name":"\(device.name)", "model":"\(device.model)", "localizeModel":"\(device.localizedModel)", "systemName":"\(device.systemName)", "systemVersion":"\(device.systemVersion)"]
                        let json = try NSJSONSerialization.dataWithJSONObject(obj, options: NSJSONWritingOptions.PrettyPrinted)
                        multipartData.appendBodyPart(data: json, name: "fileInfo", mimeType: "application/json")
                    } catch let error as NSError {
                        WLog("\(error)")
                    }
                }, encodingCompletion: { (encodingResult) -> Void in
                    switch encodingResult {
                    case .Success(let request, _, _):
                        ExtLog("\(request)")
                        request.progress({ (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                            DLog("[bytesWritten]\(bytesWritten) [totalBytesWritten]\(totalBytesWritten) [totalBytesExpectedToWrite]\(totalBytesExpectedToWrite)")
                        }).responseJSON { response in
                            ExtLog("\(response)")
                        }
                    case .Failure(let encodingError):
                        ExtLog("\(encodingError)")
                    }
            })
        }
    }

    private func appInfo() -> String {
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        return "[CFBundleIdentifier]\(infoDictionary?["CFBundleIdentifier"] as! String) [CFBundleVersion]\(infoDictionary?["CFBundleVersion"] as! String) [CFBundleShortVersionString]\(infoDictionary?["CFBundleShortVersionString"] as! String)"
    }
}
