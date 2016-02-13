//
//  BaseTableViewCell.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/07.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override var description: String {
        get {
            fatalError("description has not been implemented")
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let gesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        gesture.cancelsTouchesInView = false
        self.addGestureRecognizer(gesture)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tapGesture(sender: UITapGestureRecognizer) {
        OpeLog("[ACTION][TAP]\(self)")
    }
}
