//
//  LogFileRowModel.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/28.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class LogFileRowModel: NSObject {

    var logFileInfo: DDLogFileInfo
    var selected = false

    init(logFileInfo: DDLogFileInfo) {
        self.logFileInfo = logFileInfo
    }
}
