//
//  TableViewCell.swift
//  
//
//  Created by Taimoor Saeed on 23/07/2017.
//
//

import UIKit

class TableViewCell: UITableViewCell {

   
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
