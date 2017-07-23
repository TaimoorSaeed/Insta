//
//  Post.swift
//  Insta
//
//  Created by Taimoor Saeed on 23/07/2017.
//  Copyright © 2017 Taimoor. All rights reserved.
//

import Foundation

class Post{
    var imageURL : String
    var text : String
    
    init(imageURL: String, text: String) {
        self.imageURL = imageURL
        self.text = text
    }
}
