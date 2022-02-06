//
//  TableCell.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }


        override func layoutSubviews() {
            super.layoutSubviews()
            self.imageView?.frame = CGRect(x: 16,y: 16,width: 98,height: 98)
        }
}
