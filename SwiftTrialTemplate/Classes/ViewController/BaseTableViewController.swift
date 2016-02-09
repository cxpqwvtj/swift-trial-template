//
//  BaseTableViewController.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/07.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DLog("\(__FUNCTION__)")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ILog("\(NSStringFromClass(self.dynamicType))#\(__FUNCTION__)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        fatalError("numberOfSectionsInTableView() has not been implemented")
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("tableView(numberOfRowsInSection:) has not been implemented")
    }
}
