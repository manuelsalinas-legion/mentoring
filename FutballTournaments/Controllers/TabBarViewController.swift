//
//  TabBarViewController.swift
//  FutballTournaments
//
//  Created by bts on 12/03/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vcTournament = getTournamentsTableController()
        self.viewControllers = [vcTournament]
    }
    
    func getTournamentsTableController() -> TournamentsTableViewController {
        let vcNavigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TournamentsTableViewController") as! TournamentsTableViewController
        return vcNavigation
    }

}
