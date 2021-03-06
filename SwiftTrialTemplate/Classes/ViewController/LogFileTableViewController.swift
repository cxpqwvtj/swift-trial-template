//
//  LogFileTableViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/19.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class LogFileTableViewController: BaseTableViewController {

    private static let CELL_REUSE_ID = "simpleTableViewCellId"
    var viewModel = LogFileViewModel()

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

        for logFileInfo in AppLogger.sharedInstance.devFileLogger.logFileManager.sortedLogFileInfos() as! [DDLogFileInfo] {
            let model = LogFileRowModel(logFileInfo: logFileInfo)
            viewModel.rows.append(model)
        }
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
        self.tableView.registerClass(LogFileTableViewCell.self, forCellReuseIdentifier: LogFileTableViewController.CELL_REUSE_ID)

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "rightBarButtonTapped")
        self.navigationItem.setRightBarButtonItems([rightBarButtonItem], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        WLog("")
    }

    func rightBarButtonTapped() {
        DLog("\(__FUNCTION__)")
        var message: String
        var alertAction: UIAlertAction
        if viewModel.existsSelectedItem() {
            message = "選択したログを送信するよ？"
            alertAction = UIAlertAction(title: "送信", handler: { [unowned self](action) -> Void in
                for rowModel in self.viewModel.rows.reverse() where rowModel.selected {
                    if rowModel.logFileInfo.isArchived {
                        // logFileInfoを送信
                        AppLogger.sharedInstance.devFileLogManager.postLogFile(rowModel.logFileInfo)
                    } else {
                        // archiveしてから送信
                        rowModel.logFileInfo.isArchived = true
                        DLog("[Archive]\(AppLogger.sharedInstance.devFileLogger.currentLogFileInfo().fileName)")
                        AppLogger.sharedInstance.devFileLogger.rollLogFileWithCompletionBlock {
                            DLog("[NewFile]\(AppLogger.sharedInstance.devFileLogger.currentLogFileInfo().fileName)")
                        }
                    }
                }
            })
        } else {
            message = "すべてのログを送信するよ？"
            alertAction = UIAlertAction(title: "送信", handler: { (action) -> Void in
                for rowModel in self.viewModel.rows.reverse() {
                    AppLogger.sharedInstance.devFileLogManager.postLogFile(rowModel.logFileInfo)
                }
            })
        }
        let alert = BaseAlertController(title: "", message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "キャンセル", handler: nil))
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.rows.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let label = UILabel()
        setupLabel(label, message: viewModel.rows[indexPath.row].logFileInfo.fileName, tableViewWidth: tableView.bounds.width)
        let height = label.frame.height + 2
        return (height < 30) ? 30 : height
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = viewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(LogFileTableViewController.CELL_REUSE_ID, forIndexPath: indexPath) as! LogFileTableViewCell
        setupLabel(cell.label, message: row.logFileInfo.fileName, tableViewWidth: tableView.bounds.width)
        cell.selectedMarker.hidden = !row.selected
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            NSThread.sleepForTimeInterval(0.1)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            })
        }
        if indexPath.section == 0 {
            viewModel.rows[indexPath.row].selected = !viewModel.rows[indexPath.row].selected
        }
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        DLog("tap accessoryButton\(indexPath)")
        if let filePath = viewModel.rows[indexPath.row].logFileInfo.filePath {
            self.navigationController?.pushViewController(LogMessageTableViewController(style: UITableViewStyle.Plain, logFilePath: filePath), animated: true)
        }
    }

    // MARK: - private method

    private func setupLabel(label: UILabel, message: String?, tableViewWidth: CGFloat) {
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, tableViewWidth - LogFileTableViewCell.HORIZON_MERGIN, 0)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = message
        label.font = UIFont.systemFontOfSize(12)
        label.sizeToFit()
    }
}
