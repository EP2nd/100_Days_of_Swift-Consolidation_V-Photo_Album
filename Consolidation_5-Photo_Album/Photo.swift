//
//  Photo.swift
//  Consolidation_5-Photo_Album
//
//  Created by Edwin Przeźwiecki Jr. on 17/08/2022.
//

import UIKit

class Photo: Codable {
    var photo: String
    var title: String
    var caption: String
    
    init(photo: String, title: String, caption: String) {
        self.photo = photo
        self.title = title
        self.caption = caption
    }
}
