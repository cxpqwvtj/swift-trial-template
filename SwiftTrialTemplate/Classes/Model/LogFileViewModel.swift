//
//  LogFileViewModel.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/21.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class LogFileViewModel: NSObject {
    var rows = [LogFileRowModel]()

    func existsSelectedItem() -> Bool {
        for row in rows {
            if row.selected {
                return true
            }
        }
        return false
    }
}
