//
//  LogMessageTableViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/30.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class LogMessageTableViewController: UITableViewController {
    
    private static let CELL_REUSE_ID = "simpleTableViewCellId"
    let logFilePath: String
    var messages = [String]()

    init(style: UITableViewStyle, logFilePath: String) {
        self.logFilePath = logFilePath
        super.init(style: style)
    }
    
    override init(style: UITableViewStyle) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VLog("\(logFilePath)")
        self.tableView.registerClass(SimpleTableViewCell.self, forCellReuseIdentifier: LogMessageTableViewController.CELL_REUSE_ID)

        // ファイル読み込み
        do {
            let text = try NSString(contentsOfFile: logFilePath, encoding: NSUTF8StringEncoding) as String
            text.enumerateLines({ (line, stop) -> () in
                self.messages.append(line)
            })
        } catch let error as NSError {
            WLog("\(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        WLog("")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let label = UILabel()
        self.setupLabel(label, message: messages[indexPath.row], tableViewWidth: tableView.bounds.width)
        return label.frame.height + 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LogMessageTableViewController.CELL_REUSE_ID, forIndexPath: indexPath) as! SimpleTableViewCell
        self.setupLabel(cell.label, message: messages[indexPath.row], tableViewWidth: tableView.bounds.width)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        DLog("\(indexPath)")
        NSOperationQueue().addOperationWithBlock { () -> Void in
            NSThread.sleepForTimeInterval(0.1)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            })
        }
    }

    // MARK: - private method

    private func setupLabel(label: UILabel, message: String?, tableViewWidth: CGFloat) {
        label.frame = CGRectMake(10, 1, tableViewWidth - SimpleTableViewCell.HORIZON_MERGIN, 0)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.text = message
        label.font = UIFont.systemFontOfSize(10)
        label.sizeToFit()
    }
}
