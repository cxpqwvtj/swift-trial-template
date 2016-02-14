//
//  BaseAlertController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/06.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

extension UIAlertAction {
    convenience init(title: String?, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: title, style: .Default, handler: { (action: UIAlertAction) -> Void in
            OpeLog("[OPE][TAP]\((action.title ?? "")!)")
            if let h = handler {
                h(action)
            }
        })
    }
}

class BaseAlertController: UIAlertController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ILog("[ALART][title]\((self.title ?? "")!) [message]\((self.message ?? "")!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        WLog("\(NSStringFromClass(self.dynamicType))#\(__FUNCTION__)")
    }
}
