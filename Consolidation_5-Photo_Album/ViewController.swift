//
//  ViewController.swift
//  Consolidation_5-Photo_Album
//
//  Created by Edwin Przeźwiecki Jr. on 16/08/2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Album"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takeAPhoto))
        
        let defaults = UserDefaults.standard
        
        if let savedPhotos = defaults.object(forKey: "photos") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
            } catch {
                print("Failed to load photos.")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        let photo = photos[indexPath.row]
        
        cell.textLabel?.text = photo.title
        cell.detailTextLabel?.text = photo.caption
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.selectedPhoto = photos[indexPath.row]
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            photos.remove(at: indexPath.row)
            save()
        }
        
        tableView.reloadData()
        
        save()
    }
    
    @objc func takeAPhoto() {
        
        let picker = UIImagePickerController()
        
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true)
        
        let setTitleAndCaptionAC = UIAlertController(title: "Set title and caption", message: "Please type in title and caption.", preferredStyle: .alert)
        setTitleAndCaptionAC.addTextField()
        setTitleAndCaptionAC.addTextField()
        setTitleAndCaptionAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        setTitleAndCaptionAC.addAction(UIAlertAction(title: "Save", style: .default) { [weak self, weak setTitleAndCaptionAC] _ in
            
            let newTitle = setTitleAndCaptionAC?.textFields?[0].text ?? "Unknown"
            let newCaption = setTitleAndCaptionAC?.textFields?[1].text ?? "Unknown"
            
            self?.saveAPhoto(path: imagePath.path, title: newTitle, caption: newCaption)
        })
        present(setTitleAndCaptionAC, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func saveAPhoto(path imagePath: String, title: String, caption: String) {
        let photo = Photo(photo: imagePath, title: title, caption: caption)
        
        photos.append(photo)
        
        tableView.reloadData()
        
        save()
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
        } else {
            print("Failed to save photos.")
        }
    }
}

