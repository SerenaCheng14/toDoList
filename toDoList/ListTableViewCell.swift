//
//  ListTableViewCell.swift
//  toDoList
//
//  Created by Serena on 2021/1/18.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var priorityView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var completeView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
