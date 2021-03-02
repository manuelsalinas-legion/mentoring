//
//  UIImageViewExtension.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import Foundation
import UIKit

// FIXME: rename swift file with template  Class+Extension
extension UIImageView {
    
    // set image from url asynchronously
    func loadRemote(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
