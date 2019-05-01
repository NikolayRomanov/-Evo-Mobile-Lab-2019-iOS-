//
//  NoteCellVC.swift
//  Тестовое для Evo Mobile Lab 2019 (iOS)
//
//  Created by Macbook on 26.04.2019.
//  Copyright © 2019 Nikolay_Romanov. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelUnicode: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
