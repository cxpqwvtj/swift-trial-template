//
//  LogMessageTableViewCell.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/02/02.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

class LogMessageTableViewCell: UITableViewCell {
    let label = UILabel()
    static let HORIZON_MERGIN = CGFloat(20)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        fatalError("awakeFromNib() has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRectMake(10, 1, self.frame.width - LogMessageTableViewCell.HORIZON_MERGIN, 0)
        label.sizeToFit()
    }
}
