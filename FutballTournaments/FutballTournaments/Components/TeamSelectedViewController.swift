//
//  TeamSelectedViewController.swift
//  FutballTournaments
//
//  Created by bts on 28/02/21.
//

import UIKit

class TeamSelectedViewController: UIViewController {

    var teamSelected: TeamsByCompetition? {
        didSet {
            if let idTeam = teamSelected?.idTeam {
                URLSessions(urlString: "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=" + idTeam)
            }
        }
    }
    
    // FIXME: (Delete fixme if done) IS THIS PROPERTY PUBLIC?
    var teamDetails: [TeamDetails]? {
        didSet {
            print(teamDetails)
        }
    }
    
    // FIXME: (Delete fixme if done) MISSING ACCESS LEVELS
    let listHeader: [String] = ["INFO", "EQUIPAMENTS", "STADIUM"]
    
    // MARK:- Outlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageStrTeamBadge: UIImageView!
    @IBOutlet weak var labelstrTeam: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let strTeam = teamSelected?.strTeam {
            self.labelTitle?.text = strTeam
            self.labelstrTeam?.text = strTeam
        }
        
        if let imageTeamBadge = URL(string: teamSelected?.strTeamBadge ?? "") {
            self.imageStrTeamBadge.loadRemote(url: imageTeamBadge)
        }
        
        self.tableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        
//        let returnBtn = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.cloce))
//        self.navigationItem.leftBarButtonItem = returnBtn
    }
    
//    @objc func cloce() {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    // FIXME: (Delete fixme if done) MAKE YOUR METHOD NAMES DEV FRIENLY, A METHOD NAME STARTS WITH A VERB
    // MARK:- IBActions
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // FIXME: (Delete fixme if done) METHOD NAME CAN PROVOKE CONFLICTS INDEXING PROYECT BECAUSE YOU ARE USING A RESERVED CLASS NAME, USE DEV FRIENDLY METHOD NAMES STARTING WITH A VERB
    // MARK:- Functions
    func URLSessions(urlString: String) {
        let url = URL(string: urlString)
        guard let requestURL = url else { fatalError("URL not valid") }
        var request: URLRequest = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (DataResponse, URLResponse, Error) in
            // verify error
            // FIXME: (Delete fixme if done) MISSING ERROR HANDLED
            if let err = Error {
                print(err.localizedDescription)
                return
            }
            
            // FIXME: (Delete fixme if done) IS THIS NECESSARY ?
            if let response = URLResponse as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let dataR = DataResponse, let dataString = String(data: dataR, encoding: .utf8) {
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(TeamDetailsResponse.self, from: dataString.data(using: .utf8)!)
                    self.teamDetails = result.teams
                } catch {
                    // FIXME: (Delete fixme if done) WHAT IS PARSING FAILS?
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }

}

// MARK:- Table view data source
extension TeamSelectedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listHeader.count
    }
    
    // Titles in header sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listHeader[section]
    }
    
    // FIXME: (Delete fixme if done) UNNECESSARY TABLE VIEW METHOD, ZERO IS BY DEFAULT
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // FIXME: (Delete fixme if done) USE ENUMS TO DEFINE DEV FRIENDLY SECTION COMPARISON
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let customCell: InfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as! InfoTableViewCell
            customCell.loadInfo(teamDetails?[0].strDescriptionEN ?? "Uknown")
            return customCell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
