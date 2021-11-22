//
//  ViewController.swift
//  MapProject
//
//  Created by John Sørensen on 30/09/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textField: UITextField!
    
    var pinService = PinService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinService.viewController = self
        
        /*
        let location = CLLocationCoordinate2D(latitude: 55.699489, longitude: 12.578642)
        setPinUsingMKPlacemark(location: location, title: "Pizza")
        
        let location2 = CLLocationCoordinate2D(latitude: 55.673614, longitude: 12.567934)
        setPinUsingMKPlacemark(location: location2, title: "Tivoli")
        */
 
        mapView.delegate = self
        let onLongTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongTapGesture(gestureRecognizer:)))
        self.mapView.addGestureRecognizer(onLongTapGesture)
    }
    
    @objc func handleLongTapGesture(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UILongPressGestureRecognizer.State.ended {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            
            pinService.newPin(title: textField.text ?? "Not named", latitude: String(locationCoordinate.latitude), longitude: String(locationCoordinate.longitude))
        }
        
        if gestureRecognizer.state != UIGestureRecognizer.State.began {
            return
        }
    }

    func setPinUsingMKPlacemark(location: CLLocationCoordinate2D, title: String) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    func loadPins(pins: [Pin]) {
        mapView.removeAnnotations(mapView.annotations)
        
        //print(pins.count)
        for pin in pins {
            //print(pin.title)
            //print(pin.latitude)
            //print(pin.longitude)
            let location = CLLocationCoordinate2D(latitude: Double(pin.latitude)!, longitude: Double(pin.longitude)!)
            setPinUsingMKPlacemark(location: location, title: pin.title)
        }
        
    }
}

