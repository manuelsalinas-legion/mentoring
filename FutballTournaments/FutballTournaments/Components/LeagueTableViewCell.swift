//
//  LeagueTableViewCell.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import UIKit

// FIXME: (Delete fixme if done) THERE IS NO PROYECT ORGANIZATION, CELLS SWIFT FILE AND ITS XIB FILE SHOULD BE INSIDE  CELLS FOLDER SEPARATED FROM MAIN CONTROLLES
class LeagueTableViewCell: UITableViewCell {
    
    // FIXME: (Delete fixme if done) MISSING ACCESS LEVEL FOR OUTLETS
    // MARK:- Outlets
    @IBOutlet var imageLeague: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    // FIXME: (Delete fixme if done) TITLE AND SUBTITLE ARE TOO SEPARATED BETWEEN THEM IN UI
    
    // MARK:- Life cicles
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // design
        self.imageLeague.applyAll()
    }
    
    // FIXME: (Delete fixme if done) REMOVE IS YOU DONT USE THIS METHOD
    // MARK: - Override functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    // set outlet values of the data from TableViewController
    // FIXME: (Delete fixme if done) OPTIONAL COMETITION SHOULD BE HANDLED HERE 
    func loadInfo(_ competition: Competition) {
        self.labelTitle?.text = competition.strLeague
        self.labelSubTitle?.text = competition.strLeagueAlternate // FIXME: (Delete fixme if done) If league altername is empty, hide subtitle label
        
        if let urlImage = URL(string: competition.logo ?? "") {
            self.imageLeague?.loadRemote(url: urlImage)
        } else {
            self.imageLeague?.image = UIImage(named: "placeholderPicture")
        }
    }
}
