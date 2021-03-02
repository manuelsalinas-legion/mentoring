//
//  TeamTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 26/02/21.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imageViewTeam: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    
    // MARK:- Life cicles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Functions
    func loadTeam(_ team: TeamsByCompetition) {
        if let strTeam = team.strTeam {
            self.labelTitle?.text = strTeam
        }
        
        if let strAlternate = team.strAlternate {
            self.labelSubtitle?.text = strAlternate
        }
        
        if let teamBadge = URL(string: team.strTeamBadge ?? "") {
            self.imageViewTeam.loadRemote(url: teamBadge)
        }
    }
    
}
