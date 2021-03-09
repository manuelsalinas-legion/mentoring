//
//  TeamSelectedViewController.swift
//  FutballTournaments
//
//  Created by bts on 28/02/21.
//

import UIKit

private enum TeamSections: String, CaseIterable {
    case info = "INFO"
    case jerseys = "JERSEY"
    case stadium = "STADIUM"
}

class TeamSelectedViewController: UIViewController {

    public var teamSelected: TeamsByCompetition? {
        didSet {
            if let idTeam = teamSelected?.idTeam {
                URLSessionsGetTeam(urlString: "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=" + idTeam)
                URLSessionsGetJersey(urlString: "https://www.thesportsdb.com/api/v1/json/1/lookupequipment.php?id=" + idTeam)
            }
        }
    }
    
    private var teamDetails: TeamDetails? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var jerseyByTeam: [JerseyByTeam]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK:- Outlets
    @IBOutlet private weak var imageStrTeamBadge: UIImageView!
    @IBOutlet private weak var labelstrTeam: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var imageBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        title = teamSelected?.strTeam ?? ""
        // set label text
        self.labelstrTeam?.text = teamSelected?.strTeam ?? ""
        // set image from team selectet
        self.setBadgeImage()
        
        // Register table cells
//        self.tableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        self.tableView.register(UINib(nibName: "JerseyTableViewCell", bundle: nil), forCellReuseIdentifier: "JerseyTableViewCell")
        self.tableView.register(UINib(nibName: "StadiumTableViewCell", bundle: nil), forCellReuseIdentifier: "StadiumTableViewCell")
        
        // add close button
        let returnBtn = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.cloceModalView))
        self.navigationItem.leftBarButtonItem = returnBtn
    }
    
    // MARK:- Selectors
    // selector cloce function
    @objc func cloceModalView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Functions
    
     private func setBadgeImage() {
        if let imageTeamBadge = URL(string: self.teamSelected?.strTeamBadge ?? "") {
            self.imageStrTeamBadge.loadRemote(url: imageTeamBadge)
        } else {
            self.imageStrTeamBadge.image = UIImage(named: "placeholderPicture")
        }
    }
    
    private func setBannerImage() {
        DispatchQueue.main.async {
            if let imageBanner = URL(string: self.teamDetails?.strTeamBanner ?? "") {
                self.imageBanner.loadRemote(url: imageBanner)
            } else {
                self.imageBanner.image = UIImage(named: "placeholderPicture")
            }
        }
    }
    
    /// Get team info from API, parse data and call to set image.
    func URLSessionsGetTeam(urlString: String) {
        let url = URL(string: urlString)
        guard let requestURL = url else { fatalError("URL not valid") }
        var request: URLRequest = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (DataResponse, URLResponse, Error) in
            // verify error
            if let err = Error {
                AlertView.showAlert(view: self, title: "Error", message: "Data not downloaded")
                print(err.localizedDescription)
                return
            }
            // parse data
            if let dataR = DataResponse, let dataString = String(data: dataR, encoding: .utf8) {
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(TeamDetailsResponse.self, from: dataString.data(using: .utf8)!)
                    self.teamDetails = result.teams?[0]
                    self.setBannerImage()
                } catch {
                    AlertView.showAlert(view: self, title: "Error", message: "The data can't be show")
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    /// Get Jersey from API and parse data
    func URLSessionsGetJersey(urlString: String) {
        let url = URL(string: urlString)
        guard let requestURL = url else { fatalError("URL not valid") }
        var request: URLRequest = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (DataResponse, URLResponse, Error) in
            // verify error
            if let err = Error {
                AlertView.showAlert(view: self, title: "Error", message: "Data not downloaded")
                print(err.localizedDescription)
                return
            }
            // json parse
            if let dataR = DataResponse, let dataString = String(data: dataR, encoding: .utf8) {
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(JerseyByTeamResponse.self, from: dataString.data(using: .utf8)!)
                    self.jerseyByTeam = result.equipment
                } catch {
                    AlertView.showAlert(view: self, title: "Error", message: "The data can't be show")
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
        return TeamSections.allCases.count
    }
    
    // Titles in header sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TeamSections.allCases[section].rawValue
    }
    
    // three diferent number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TeamSections.allCases[section].rawValue {
        case "INFO":
            return 1
            
        case "JERSEY":
            return jerseyByTeam?.count ?? 0
            
        case "STADIUM":
            return 1
            
        default:
            return 1
        }
    }
    
    // three diferents cell for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TeamSections.allCases[indexPath.section].rawValue {
        case "INFO":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
            cell.textLabel?.text = teamDetails?.strDescriptionEN
            cell.textLabel?.numberOfLines = 0
            cell.setSelected(false, animated: false)
            cell.isUserInteractionEnabled = false
            return cell
            
        case "JERSEY":
            let cellJersey = UITableViewCell(style: .default, reuseIdentifier: "Q")
            // set values and properties in the cell
            let strType = jerseyByTeam?[indexPath.row].strType ?? "Type uknown"
            let strSeason = jerseyByTeam?[indexPath.row].strSeason ?? "Season uknown"
            if let imageURL = URL(string: jerseyByTeam?[indexPath.row].strEquipment ?? "") {
                cellJersey.imageView?.loadRemote(url: imageURL)
            } else {
                cellJersey.imageView?.image = UIImage(named: "placeholderPicture")
            }
            cellJersey.imageView?.applyAll()
            cellJersey.textLabel?.text = strType + ", " + strSeason
            cellJersey.textLabel?.numberOfLines = 0
            cellJersey.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
            let jerseyCustomCell = tableView.dequeueReusableCell(withIdentifier: "JerseyTableViewCell") as! JerseyTableViewCell
            jerseyCustomCell.loadInfo(jerseyByTeam: jerseyByTeam?[indexPath.row])
            
            return jerseyCustomCell
            
        case "STADIUM":
            let customCell: StadiumTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StadiumTableViewCell") as! StadiumTableViewCell
            customCell.loadInfo(teamDetails)
            customCell.isUserInteractionEnabled = false
            return customCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if TeamSections.allCases[indexPath.section].rawValue == "JERSEY" {
            if let vcStadiumImage = storyboard.instantiateViewController(identifier: "JerseyImageViewController") as? JerseyImageViewController {
                vcStadiumImage.loadImage(jerseyByTeam?[indexPath.row].strEquipment ?? "")
                self.navigationController?.pushViewController(vcStadiumImage, animated: true)
            }
        }
    }
    
    // Edit header section
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .brown
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = UIFont.init(name: "Marker Felt", size: 19)
        }
    }
    
    // Edit row heigh
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if TeamSections.allCases[indexPath.section].rawValue == "STADIUM" {
            return 150
        } else {
            return tableView.rowHeight
        }
    }
}
