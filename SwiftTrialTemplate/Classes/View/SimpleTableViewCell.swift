//
//  SimpleTableViewCell.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/28.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    let label = UILabel()
    let selectedMarker = UIView()
    static let HORIZON_MERGIN = CGFloat(50)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
        //self.addSubview(selectedMarker)
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
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, self.frame.width - SimpleTableViewCell.HORIZON_MERGIN, 0)
        label.sizeToFit()
        selectedMarker.frame = CGRectMake(0, 1, 10, self.bounds.height - 2)
    }
}
