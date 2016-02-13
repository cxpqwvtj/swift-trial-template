//
//  BaseButton.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/06.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: "touchUpInside:event:", forControlEvents: .TouchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func touchUpInside(sender: UIButton, event: UIEvent) {
        OpeLog("[ACTION][TAP]\((sender.titleLabel?.text ?? "")!) [frame]\(sender.frame)")
    }
}
