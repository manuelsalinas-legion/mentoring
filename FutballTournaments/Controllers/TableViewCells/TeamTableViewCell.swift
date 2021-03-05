//
//  TeamTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 26/02/21.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet private weak var imageViewTeam: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelSubtitle: UILabel!
    
    // MARK:- Life cicles
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageViewTeam?.applyAll()
    }
    
    //MARK:- Functions
    func loadTeam(_ team: TeamsByCompetition?) {
        self.labelTitle?.text = team?.strTeam ?? ""
        self.labelSubtitle?.text = team?.strAlternate ?? ""
        if let teamBadge = URL(string: team?.strTeamBadge ?? "") {
            self.imageViewTeam.loadRemote(url: teamBadge)
        } else {
            self.imageViewTeam?.image = UIImage(named: "placeholderPicture")
        }
    }
    
}
