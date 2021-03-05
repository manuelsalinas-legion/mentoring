//
//  LeagueTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet private var imageLeague: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelSubTitle: UILabel!
    
    // MARK:- Life cicles
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // design
        self.imageLeague.applyAll()
        self.layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - Functions
    // set outlet values of the data from TableViewController
    func loadInfo(_ competition: Competition?) {
        self.labelTitle?.text = competition?.strLeague ?? ""
        if let leagueAlternative = competition?.strLeagueAlternate {
            self.labelSubTitle?.text = leagueAlternative
        } else {
            self.labelSubTitle?.isHidden = true
        }
        if let urlImage = URL(string: competition?.logo ?? "") {
            self.imageLeague?.loadRemote(url: urlImage)
        } else {
            self.imageLeague?.image = UIImage(named: "placeholderPicture")
        }
    }
}
