//
//  TextFieldTableViewCell.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var txtCellField: UITextField!
    @IBOutlet weak var txtPlaceHolder: UILabel!
    @IBOutlet weak var txtDataValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if self.txtCellField != nil {
             self.txtCellField.prepareBorderField()
        }
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
