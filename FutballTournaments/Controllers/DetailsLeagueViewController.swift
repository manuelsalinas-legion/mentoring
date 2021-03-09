//
//  DetailsLeagueViewController.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import UIKit

class DetailsLeagueViewController: UIViewController {
    
    // MARK:- Global variables
    public var leagueSelected: Competition? {
        didSet {
            if let idLeague = leagueSelected?.idLeague {
                GetTeamByCompetitonAPI(urlString: "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=" + idLeague)
            }
        }
    }
    private var teamsByCompetition: [TeamsByCompetition]? {
        didSet {
            DispatchQueue.main.async {
                self.tableViewTeam.reloadData()
                
                self.labelNumberOfTeams?.text = String(self.teamsByCompetition?.count ?? 0)
            }
        }
    }
    
    // MARK:- Outlets
    @IBOutlet private weak var imageViewLeague: UIImageView!
    @IBOutlet private weak var labelTitleLeague: UILabel!
    @IBOutlet private weak var labelParticipantsTeams: UILabel!
    @IBOutlet private weak var tableViewTeam: UITableView!
    @IBOutlet private weak var labelNumberOfTeams: UILabel!
    
    // MARK:- Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        self.imageViewLeague.applyAll()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(popToPrevious))
        self.view.backgroundColor = UIColor.brown
        self.labelTitleLeague?.text = leagueSelected?.strLeague
        // set image from url
        if let strLogo = leagueSelected?.logo, let urlImage = URL(string: strLogo) {
            self.imageViewLeague?.loadRemote(url: urlImage)
        } else {
            self.imageViewLeague?.image = UIImage(named: "placeholderPicture")
        }
        
        self.tableViewTeam.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
    }
    
    // MARK: - Selectors
    // close UIController selector
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Functions
    private func GetTeamByCompetitonAPI(urlString: String) {
        let url = URL(string: urlString)
        guard let requestURL = url else { fatalError("URL not valid") }
        var request: URLRequest = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (DataResponse, URLResponse, Error) in
            // verify error
            if let err = Error {
                print(err.localizedDescription)
                AlertView.showAlert(view: self,title: "Error", message: "The data could not be obtained")
                return
            }
            
            if let dataR = DataResponse, let dataString = String(data: dataR, encoding: .utf8) {
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(TeamsResponse.self, from: dataString.data(using: .utf8)!)
                    self.teamsByCompetition = result.teams
                } catch {
                    print(error.localizedDescription)
                    AlertView.showAlert(view: self, title: "Error", message: "The data could not be parsed")
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
    
    // Custom Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell: TeamTableViewCell = tableViewTeam.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell
        customCell.loadTeam(self.teamsByCompetition?[indexPath.row])
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vcTeamSelected = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TeamSelectedViewController") as? TeamSelectedViewController {
            let navController = UINavigationController(rootViewController: vcTeamSelected)
            navController.navigationBar.isTranslucent = false
            navController.modalPresentationStyle = .fullScreen
            navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            vcTeamSelected.teamSelected = teamsByCompetition?[indexPath.row]
            self.present(navController, animated: true, completion: nil)
        }
    }
}
