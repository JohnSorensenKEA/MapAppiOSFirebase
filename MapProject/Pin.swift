//
//  Pin.swift
//  MapProject
//
//  Created by John Sørensen on 30/09/2021.
//

import Foundation

class Pin {
    
    var title: String
    var latitude: String
    var longitude: String
    
    init(title: String, latitude: String, longitude: String) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
}
