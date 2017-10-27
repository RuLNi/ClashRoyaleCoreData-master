//
//  customTableViewCell.swift
//  ClashRoyale
//
//  Created by macbookUser on 25/10/17.
//  Copyright © 2017 none. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet var imagen: UIImageView!
    @IBOutlet var nombre: UILabel!
    @IBOutlet var descripcion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
