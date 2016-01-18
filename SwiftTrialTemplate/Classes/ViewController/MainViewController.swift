//
//  ViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/17.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DDLogVerbose("")
        let movieSelectButton = UIButton(frame: CGRectMake(100.0, 100.0, 100.0, 29.0))
        movieSelectButton.backgroundColor = UIColor.grayColor()
        movieSelectButton.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(movieSelectButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapButton(sender: UIButton) {
        DDLogDebug("\(sender)")
    }
}

