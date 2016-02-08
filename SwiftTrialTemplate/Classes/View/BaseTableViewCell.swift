//
//  BaseTableViewCell.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/07.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.phase == .Ended {
            DLog("")
        }
        DLog("\(touch.phase) [frame]\(self.frame)")
        return true
    }
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        DLog("\(gestureRecognizer.state)")
        return true
    }
}
