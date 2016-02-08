//
//  ViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/17.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import SSZipArchive

class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VLog("\(__FUNCTION__)")
        let button1 = BaseButton(frame: CGRectMake(50.0, 100.0, 200.0, 29.0))
        button1.backgroundColor = UIColor.grayColor()
        button1.setTitle("ログファイル一覧", forState: UIControlState.Normal)
        button1.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button1)

        let button2 = BaseButton(frame: CGRectMake(50.0, 130.0, 200.0, 29.0))
        button2.backgroundColor = UIColor.grayColor()
        button2.setTitle("ログファイル切り替え", forState: UIControlState.Normal)
        button2.addTarget(self, action: "tapButton2:event:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tapButton(sender: UIButton) {
        self.navigationController?.pushViewController(LogFileTableViewController(style: UITableViewStyle.Plain), animated: true)
    }

    func tapButton2(sender: UIButton, event: UIEvent) {
        DLog("[ROLL BEFORE]\(AppLogger.sharedInstance.devFileLogger.currentLogFileInfo().fileName)")
        AppLogger.sharedInstance.devFileLogger.rollLogFileWithCompletionBlock {
            DLog("[ROLL AFTER]\(AppLogger.sharedInstance.devFileLogger.currentLogFileInfo().fileName)")
        }
    }
}

