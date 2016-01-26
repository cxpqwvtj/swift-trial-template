//
//  ViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/17.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import SSZipArchive

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VLog("")
        let movieSelectButton = UIButton(frame: CGRectMake(100.0, 100.0, 100.0, 29.0))
        movieSelectButton.backgroundColor = UIColor.grayColor()
        movieSelectButton.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(movieSelectButton)

        let button2 = UIButton(frame: CGRectMake(100.0, 130.0, 100.0, 29.0))
        button2.backgroundColor = UIColor.grayColor()
        button2.addTarget(self, action: "tapButton2:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tapButton(sender: UIButton) {
        DLog("\(sender)")
        self.navigationController?.pushViewController(LogFileTableViewController(style: UITableViewStyle.Plain), animated: true)
    }

    func tapButton2(sender: UIButton) {
        DLog("\(sender)")
        DLog("[ROLL BEFORE]\(AppLogger.sharedInstance.fileLogger.currentLogFileInfo().fileName)")
        AppLogger.sharedInstance.fileLogger.rollLogFileWithCompletionBlock {
            DLog("[ROLL AFTER]\(AppLogger.sharedInstance.fileLogger.currentLogFileInfo().fileName)")
        }
    }
}

