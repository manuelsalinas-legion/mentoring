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
    
    // MARK:- Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        self.imageViewLeague.layer.cornerRadius = self.imageViewLeague.frame.width / 2
        self.imageViewLeague.clipsToBounds = true
        if let strLogo = leagueSelected?.logo, let urlImage = URL(string: strLogo) {
            self.imageViewLeague?.loadRemote(url: urlImage)
        }
        
        if let strLeague = leagueSelected?.strLeague {
            self.labelTitleLeague?.text = strLeague
        }
        
        self.tableViewTeam.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
    }
    
    // MARK:- Functions
    func URLSessions(urlString: String) {
        let url = URL(string: urlString)
        guard let requestURL = url else { fatalError("URL not valid") }
        var request: URLRequest = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (DataResponse, URLResponse, Error) in
            // verify error
            if let err = Error {
                print(err.localizedDescription)
                return
            }
            
            if let response = URLResponse as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let dataR = DataResponse, let dataString = String(data: dataR, encoding: .utf8) {
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(TeamsResponse.self, from: dataString.data(using: .utf8)!)
                    self.teamsByCompetition = result.teams
                } catch {
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
        if let team = self.teamsByCompetition?[indexPath.row] {
            
            let customCell: TeamTableViewCell = tableViewTeam.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell
            
            customCell.loadTeam(team)
            
            return customCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let teamSelected = teamsByCompetition?[indexPath.row]
        
        if let vcTeamSelected = storyboard.instantiateViewController(identifier: "TeamSelectedViewController") as? TeamSelectedViewController {
            
            vcTeamSelected.modalPresentationStyle = .fullScreen
            
            vcTeamSelected.teamSelected = teamSelected
            
            self.present(vcTeamSelected, animated: true, completion: nil)
        }
    }
}
