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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func layout() {
        self.layoutSubviews()
        cellHeight = idLabel.frame.height + typeLabel.frame.height + setupLabel.frame.height  + punchlineLabel.frame.height + 50.0
       // print(cellHeight)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.clipsToBounds = true
        
        // 2) Layout the contentView's controls
       self.layout()
        
        // 3) Returns a size that contains all controls
       // let cellHeight = idLabel.frame.height + typeLabel.frame.height + setupLabel.frame.height  + punchlineLabel.frame.height
        
        return CGSize(width: contentView.frame.width, height: cellHeight)
    }

}
