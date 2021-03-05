//
//  JerseyImageViewController.swift
//  FutballTournaments
//
//  Created by bts on 02/03/21.
//

import UIKit

class JerseyImageViewController: UIViewController {

    @IBOutlet weak var imageJersey: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadImage(_ image: String) {
        if let imageJersey = URL(string: image) {
            DispatchQueue.main.async {
                self.imageJersey.loadRemote(url: imageJersey)
            }
        } else {
            self.imageJersey.image = UIImage(named: "placeholderPicture")
        }
    }
}
