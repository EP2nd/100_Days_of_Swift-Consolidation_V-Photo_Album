//
//  ViewController.swift
//  Consolidation_5-Photo_Album
//
//  Created by Edwin Przeźwiecki Jr. on 16/08/2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photos = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Album"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takeAPhoto))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        //let photo = photos[indexPath.row]
        cell.textLabel?.text = "Unknown"
        cell.detailTextLabel?.text = "Unknown"
        return cell
    }
    
    @objc func takeAPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}

