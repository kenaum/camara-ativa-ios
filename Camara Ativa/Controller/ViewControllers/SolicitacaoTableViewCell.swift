//
//  SolicitacaoTableViewCell.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class SolicitacaoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSolicitacao: UIImageView!
    @IBOutlet weak var lbSolicitacao: UILabel!
    @IBOutlet weak var lbDescricao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = SwiftUtil.blueBackgroundColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
