//
//  collectionsListTableViewCell.swift
//  Collections
//
//  Created by Samantha Maxey on 10/3/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit

class collectionsListTableViewCell: UITableViewCell {
    //MARK: Properties
    
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var pictureImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
