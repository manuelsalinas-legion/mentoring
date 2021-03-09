//
//  JerseyTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 09/03/21.
//

import UIKit

class JerseyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageJersey: UIImageView!
    @IBOutlet weak var labelJersey: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadInfo(jerseyByTeam: JerseyByTeam?) {
        if let strType = jerseyByTeam?.strType, let strSeason = jerseyByTeam?.strSeason {
            self.labelJersey.text = strType + ", " + strSeason
        } else {
            self.labelJersey.text = "Uknown"
        }
        
        if let URLjersey = URL(string: jerseyByTeam?.strEquipment ?? "") {
            self.imageJersey.loadRemote(url: URLjersey)
        } else {
            self.imageJersey.image = UIImage(named: "placeholderPicture")
        }
    }
    
}
