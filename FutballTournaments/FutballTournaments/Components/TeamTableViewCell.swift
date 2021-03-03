//
//  TeamTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 26/02/21.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    // FIXME: (Delete fixme if done) MISSING ACCESS LEVELS
    //MARK:- Outlets
    @IBOutlet weak var imageViewTeam: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    // FIXME: (Delete fixme if done) TITLE AND SUBTITLE LOOKS TOO SEPARATED BETWEEN THEM, MISSING BORDER IN LOGO CONTAINERS, TITLE AND SUBTITLE LOOKS TOO BIGGER IN SCREEN
    
    // MARK:- Life cicles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // FIXME: (Delete fixme if done) IF YOU DON'T USE THIS METHOD, REMOVE IT
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Functions
    func loadTeam(_ team: TeamsByCompetition) {
        // FIXME: (Delete fixme if done) OPTIONAL TEAMS SHOULD BE HANDLED HERE
        if let strTeam = team.strTeam {
            self.labelTitle?.text = strTeam
        }
        
        // FIXME: (Delete fixme if done) WHAT IF ALTERNATE TITLE IS NULL?
        if let strAlternate = team.strAlternate {
            self.labelSubtitle?.text = strAlternate
        }
        
        // FIXME: (Delete fixme if done) MISSING NULL LOGO HANDLED
        if let teamBadge = URL(string: team.strTeamBadge ?? "") {
            self.imageViewTeam.loadRemote(url: teamBadge)
        }
    }
    
}
