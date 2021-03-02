//
//  InfoTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 01/03/21.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var labelInfo: UILabel!
    
    // MARK:- Life cicles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:- Functions
    func loadInfo(_ info: String) {
        self.labelInfo?.text = info
    }
    
}
