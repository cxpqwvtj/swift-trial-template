//
//  LogFileTableViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/19.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit
import CocoaLumberjack

class LogFileTableViewController: UITableViewController {

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
            let model = LogFileRowModel()
            model.logFileInfo = logFileInfo
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
        VLog("")
    }

    func rightBarButtonTapped() {
        DLog("")
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
        setupLabel(label, message: viewModel.rows[indexPath.row].logFileInfo?.fileName, tableViewWidth: tableView.bounds.width)
        let height = label.frame.height + 2
        return (height < 30) ? 30 : height
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LogFileTableViewController.CELL_REUSE_ID, forIndexPath: indexPath) as! LogFileTableViewCell
        setupLabel(cell.label, message: viewModel.rows[indexPath.row].logFileInfo?.fileName, tableViewWidth: tableView.bounds.width)
        cell.selectedMarker.hidden = !viewModel.rows[indexPath.row].selected
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        DLog("\(indexPath)")
        NSOperationQueue().addOperationWithBlock { () -> Void in
            NSThread.sleepForTimeInterval(0.1)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            })
        }
        viewModel.rows[indexPath.row].selected = !viewModel.rows[indexPath.row].selected
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        ILog("tap accessoryButton\(indexPath)")
        if let filePath = viewModel.rows[indexPath.row].logFileInfo?.filePath {
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
