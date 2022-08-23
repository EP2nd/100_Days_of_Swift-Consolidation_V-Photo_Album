//
//  DetailViewController.swift
//  Consolidation_5-Photo_Album
//
//  Created by Edwin Przeźwiecki Jr. on 16/08/2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var photoView: UIImageView!
    
    var selectedPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoToLoad = selectedPhoto?.photo {
            photoView.image = UIImage(named: photoToLoad)
            print(photoToLoad)
        } else {
            print("Could not load the photo.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
