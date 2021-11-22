//
//  PinService.swift
//  MapProject
//
//  Created by John Sørensen on 30/09/2021.
//

import Foundation
import Firebase

class PinService {
    let db = Firestore.firestore()
    let pinKey = "pinsX"
    
    var viewController: ViewController?
    
    init() {
        startListener()
    }
    
    func startListener() {
        var pins: [Pin] = []
        db.collection(pinKey).addSnapshotListener { snapshot, error in
            if let e = error {
            print("error fetching pins: \(e)")
            } else {
                pins = []
                if let s = snapshot {
                    for doc in s.documents {
                        let title = doc.data()["title"] as? String
                        let latitude = doc.data()["latitude"] as? String
                        let longitude = doc.data()["longitude"] as? String
                        
                        let pin = Pin(title: title ?? "", latitude: latitude ?? "", longitude: longitude ?? "")
                        pins.append(pin)
                    }
                }
                self.viewController?.loadPins(pins: pins)
            }
        }
    }
    
    func newPin(title: String, latitude: String, longitude: String) {
        let document = db.collection(pinKey).document()
        var data = [String: String]()
        data["title"] = title
        data["latitude"] = latitude
        data["longitude"] = longitude
        
        document.setData(data)
    }
}
