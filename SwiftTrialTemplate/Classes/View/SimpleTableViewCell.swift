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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
        self.addSubview(selectedMarker)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        fatalError("awakeFromNib() has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
