//
//  LogFileTableViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/19.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class LogFileTableViewController: UITableViewController {

    private static let CELL_REUSE_ID = "simpleTableViewCellId"
    let logs: [String]
    var labelWidth = UIScreen.mainScreen().bounds.width

    override init(style: UITableViewStyle) {
//        let fileManager = NSFileManager()
//        do {
//            let logsDir = "\(AppLogger.sharedInstance.fileLogger.logFileManager.logsDirectory())"
//            DLog("[logsDir]\(logsDir)")
//            logs = try fileManager.contentsOfDirectoryAtPath(logsDir)
//        } catch let error as NSError {
//            WLog("\(error)")
//            logs = []
//        }
        
        logs = AppLogger.sharedInstance.fileLogger.logFileManager.sortedLogFileNames() as! [String]
        super.init(style: style)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        fatalError("init(coder:) has not been implemented")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        VLog("")
        self.tableView.registerClass(SimpleTableViewCell.self, forCellReuseIdentifier: LogFileTableViewController.CELL_REUSE_ID)
        labelWidth = self.tableView.bounds.width - 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        VLog("")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return logs.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let label = UILabel(frame: CGRectMake(0, 0, labelWidth, 0))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.text = logs[indexPath.row]
        label.sizeToFit()
        return label.frame.height + 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LogFileTableViewController.CELL_REUSE_ID, forIndexPath: indexPath) as! SimpleTableViewCell
        cell.label.frame = CGRectMake(20, 1, labelWidth, 0)
        cell.label.numberOfLines = 0
        cell.label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        cell.label.text = logs[indexPath.row]
        cell.label.sizeToFit()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
