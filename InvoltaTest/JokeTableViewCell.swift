//
//  JokeTableViewCell.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var punchlineLabel: UILabel!
    
    var cellHeight : CGFloat = 0
    
    func layout() {
        self.layoutSubviews()
        self.cellHeight = idLabel.frame.height + typeLabel.frame.height + setupLabel.frame.height  + punchlineLabel.frame.height + 50.0
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.clipsToBounds = true
        self.layout()
        return CGSize(width: contentView.frame.width, height: self.cellHeight)
    }
    
}
