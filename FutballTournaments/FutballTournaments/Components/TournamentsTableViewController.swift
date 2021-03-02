//
//  TournamentsTableViewController.swift
//  FutballTournaments
//
//  Created by bts on 24/02/21.
//

import UIKit

class TournamentsTableViewController: UITableViewController {
    
    // MARK: - Variables
    var tournaments = [Tournament]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK:- Life cicles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title of navigation view
        title = "Futball Tournaments"
        getJson()
        
        self.tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueTableViewCell")
    }
    
    // MARK: - Functions
    /// Obtain Json data
    func getJson() {
        guard let jsonUrl = Bundle(for: type(of: self)).path(forResource: "soccer_info", ofType: "json") else { return }
        guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: jsonUrl), encoding: String.Encoding.utf8) else {
            return
        }
        do {
            let jsonData = try JSONDecoder().decode(TournamentsResponse.self, from: jsonString.data(using: .utf8)!)
            for item in jsonData.tournaments {
                var array = item
                array.competitions = array.competitions?.sorted(by: { $0.strLeague ?? "" < $1.strLeague ?? "" })
                self.tournaments.append(array)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source
    // number of rows
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tournaments.count
    }
    
    // Titles in header sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tournaments[section].displayName
    }

    // number off sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments[section].competitions?.count ?? 0
    }

    // use a League cuastom cell and send data of each competition
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // league custom cell
        if let competition = self.tournaments[indexPath.section].competitions?[indexPath.row] {
            
            let customCell: LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell") as! LeagueTableViewCell
            
            customCell.loadInfo(competition)
                
            return customCell
        } else {
            return UITableViewCell()
        }
    }
    
    // Show DetailsLeague view controller and sende the competition data selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // obtain the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //obtain details view controller
        
        let leagueSelect = self.tournaments[indexPath.section].competitions?[indexPath.row]
        
        if let vcDetailsLeague: DetailsLeagueViewController = storyboard.instantiateViewController(identifier: "DetailsLeagueViewController") as? DetailsLeagueViewController {
            //modal presentation
            vcDetailsLeague.modalPresentationStyle = .fullScreen
            
            vcDetailsLeague.leagueSelected = leagueSelect
            
            self.navigationController?.pushViewController(vcDetailsLeague, animated: true)
        }
    }
    
    // Etit header section
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .black
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        }
    }
}
