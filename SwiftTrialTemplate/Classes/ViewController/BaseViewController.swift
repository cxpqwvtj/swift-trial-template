//
//  BaseViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/06.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ILog("\(NSStringFromClass(self.dynamicType))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        WLog("\(NSStringFromClass(self.dynamicType))")
    }
}
