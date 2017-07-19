//
//  NoticiasCamaraTableViewCell.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class NoticiasCamaraTableViewCell: UITableViewCell {

    @IBOutlet weak var lbData: UILabel!
    @IBOutlet weak var lbNoticia: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
