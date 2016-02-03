//
//  LogFileTableViewCell.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/28.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class LogFileTableViewCell: UITableViewCell {
    let label = UILabel()
    let selectedMarker = UIView()
    static let HORIZON_MERGIN = CGFloat(53)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
        self.addSubview(selectedMarker)
        selectedMarker.backgroundColor = UIColor.orangeColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        fatalError("awakeFromNib() has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRectMake(15, 1, self.frame.width - LogFileTableViewCell.HORIZON_MERGIN, 0)
        label.sizeToFit()
        selectedMarker.frame = CGRectMake(0, 1, 10, self.bounds.height - 2)
    }
}
