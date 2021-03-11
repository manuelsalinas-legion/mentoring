//
//  ViewController.swift
//  Segmented
//
//  Created by bts on 10/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var container1: UIView!
    @IBOutlet private var container2: UIView!
    @IBOutlet private var container3: UIView!
    
    private var vcPurple: PurpleController!
    private var vcGray: GrayController!
    private var vcRed: RedController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container2.isHidden = true
        container3.isHidden = true
    }

    @IBAction private func switcTab(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            container1.isHidden = false
            container2.isHidden = true
            container3.isHidden = true
        case 1:
            container1.isHidden = true
            container2.isHidden = false
            container3.isHidden = true
        case 2:
            container1.isHidden = true
            container2.isHidden = true
            container3.isHidden = false
        default:
            break
        }
    }
    
    // antes de que entre al ciclo de vida prepara la informacion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "PurpleController", let purple = segue.destination as? PurpleController {
            vcPurple = purple
        }
        if let id = segue.identifier, id == "GrayController", let gray = segue.destination as? GrayController {
            vcGray = gray
        }
        if let id = segue.identifier, id == "RedController", let red = segue.destination as? RedController {
            vcRed = red
            vcRed.loadInfo()
        }
    }
}
