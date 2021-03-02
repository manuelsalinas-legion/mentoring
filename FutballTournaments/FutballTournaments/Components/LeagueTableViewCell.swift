//
//  LeagueTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet var imageLeague: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    // MARK:- Life cicles
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // design
        self.imageLeague.applyAll()
    }
    
    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    // set outlet values of the data from TableViewController
    func loadInfo(_ competition: Competition) {
        self.labelTitle?.text = competition.strLeague
        self.labelSubTitle?.text = competition.strLeagueAlternate
        if let urlImage = URL(string: competition.logo ?? "") {
            self.imageLeague?.loadRemote(url: urlImage)
        } else {
            self.imageLeague?.image = UIImage(named: "placeholderPicture")
        }
    }
}
