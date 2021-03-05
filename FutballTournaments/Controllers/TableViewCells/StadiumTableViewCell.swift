//
//  StadiumTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 01/03/21.
//

import UIKit

class StadiumTableViewCell: UITableViewCell {

//    @IBOutlet weak var imageStadium: UIImageView!
    @IBOutlet weak var imageViewStadium: UIImageView!
    @IBOutlet weak var labelStrStadium: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
//        self.imageStadium.clipsToBounds = true
    }
    
    
    func loadInfo(_ teamDetails: TeamDetails?) {
        if let imageURL = URL(string: teamDetails?.strStadiumThumb ?? "") {
            self.imageViewStadium.loadRemote(url: imageURL)
        } else {
            self.imageViewStadium?.image = UIImage(named: "placeholderPicture")
        }

        self.labelStrStadium.text = teamDetails?.strStadium ?? "Uknown"
    }
}
