//
//  DetailsLeagueViewController.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import UIKit

class DetailsLeagueViewController: UIViewController {
    
    // MARK:- Global variables
    var leagueSelected: Competition? {
        didSet {
            if let idLeague = leagueSelected?.idLeague {
                URLSessions(urlString: "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=" + idLeague)
            }
        }
    }
    
    // FIXME: (Delete fixme if done) THIS PROPERTY NEEDS TO BE PUBLIC?
    var teamsByCompetition: [TeamsByCompetition]? {
        didSet {
            DispatchQueue.main.async {
                self.tableViewTeam.reloadData()
                
                self.labelNumberOfTeams?.text = String(self.teamsByCompetition?.count ?? 0)
            }
        }
    }
    
    // MARK:- Outlets
    @IBOutlet weak var imageViewLeague: UIImageView!
    @IBOutlet weak var labelTitleLeague: UILabel!
    @IBOutlet weak var labelParticipantsTeams: UILabel!
    @IBOutlet weak var tableViewTeam: UITableView!
    @IBOutlet weak var labelNumberOfTeams: UILabel!
    // FIXME: (Delete fixme if done) LEAGUE TITLE LOOKS INCOMPLETE IN SMALL DEVICES, NUMBER OF TEAMS DOES NOT APPEAR ON SMALL DEVICES
    
    // FIXME: (Delete fixme if done)
    
    // MARK:- Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        // FIXME: (Delete fixme if done) USE AN EXTENSION TO APPLY SAME STYLE IN ONE SINGLE LINE OF CODE
        self.imageViewLeague.layer.cornerRadius = self.imageViewLeague.frame.width / 2
        self.imageViewLeague.clipsToBounds = true
        
        // FIXME: (Delete fixme if done) MISSING NULL IMAGE HANDLED
        if let strLogo = leagueSelected?.logo, let urlImage = URL(string: strLogo) {
            self.imageViewLeague?.loadRemote(url: urlImage)
        }
        
        if let strLeague = leagueSelected?.strLeague {
            self.labelTitleLeague?.text = strLeague
        }
        
        self.tableViewTeam.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
    }
    
    // MARK:- Functions
    // FIXME: (Delete fixme if done) Private Access level missing in function
    // FIXME: (Delete fixme if done) method names should start with a verb, Dont't use language reserverd words or classes like URLSessions
    func URLSessions(urlString: String) {
        let url = URL(string: urlString)
        guard let requestURL = url else { fatalError("URL not valid") }
        var request: URLRequest = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (DataResponse, URLResponse, Error) in
            // verify error
            if let err = Error {
                // FIXME: (Delete fixme if done) WHAT IF ENDPOINT FAILS?
                print(err.localizedDescription)
                return
            }
            
            // FIXME: (Delete fixme if done) REMOVE UNNECESSARY CODE
            if let response = URLResponse as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let dataR = DataResponse, let dataString = String(data: dataR, encoding: .utf8) {
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(TeamsResponse.self, from: dataString.data(using: .utf8)!)
                    self.teamsByCompetition = result.teams
                } catch {
                    // FIXME: (Delete fixme if done) WHAT IF PARSING FAILS?
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}

// MARK:- Table Delegate
extension DetailsLeagueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamsByCompetition?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Custom Cell
        // FIXME: (Delete fixme if done) OPTIONAL TEAMS SHOULD BE HANDLED BY THE CELL NOT THE ENTIRE CONTROLLER
        if let team = self.teamsByCompetition?[indexPath.row] {
            
            let customCell: TeamTableViewCell = tableViewTeam.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell
            
            customCell.loadTeam(team)
            // FIXME: (Delete fixme if done) INFO INDICATOR LOOKS WEIRD WITH DEFAULT BLUE COLOR
            
            return customCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // FIXME: (Delete fixme if done) REMOVE EXCESSIVE BREAKE LINES SPACES
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let teamSelected = teamsByCompetition?[indexPath.row]
        
        // FIXME: (Delete fixme if done) DO INSTANCE IN ONE SINGLE LINE, CONSTANT STORYBOARD IS REDUNDANT
        if let vcTeamSelected = storyboard.instantiateViewController(identifier: "TeamSelectedViewController") as? TeamSelectedViewController {
            
            vcTeamSelected.modalPresentationStyle = .fullScreen
            
            vcTeamSelected.teamSelected = teamSelected
            
            self.present(vcTeamSelected, animated: true, completion: nil)
        }
    }
}
