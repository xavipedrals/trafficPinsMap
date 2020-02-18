//
//  ViewController.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 18/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var mapView: MKMapView!
    
    var annotationPins: [MapPin] {
        return RawPinMapCache().pins.compactMap{ MapPin(rawMapPin: $0) }
    }
    var selectedPin: MapPin?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NOTE: If MKMapView is added from storyboard app crashes when not debugging
        mapView = MKMapView(frame: self.view.frame)
        self.view.addSubview(mapView)
        mapView.addAnnotations(annotationPins)
        mapView.delegate = self
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))

        gestureRecognizer.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToDetail",
            let pin = sender as? MapPin,
            let vc = segue.destination as? PinDetailViewController else {
                print("Something went wrong preparing the segue")
                return
        }
        vc.delegate = self
        vc.pin = RawPinMapCache().getPinWith(id: pin.id)
    }
    
    //MARK: - Actions
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        let pin = RawMapPin(latitude: coordinate.latitude, longitude: coordinate.longitude)
        RawPinMapCache().pins.append(pin)
        let annotation = MapPin(rawMapPin: pin)
        mapView.addAnnotation(annotation)
    }
    
    //MARK: - Private
    
    func deleteLastPin() {
        guard let pin = selectedPin else { return }
        mapView.removeAnnotations([pin])
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let pin = view.annotation as? MapPin else {
            print("Pin is not a MapPin type")
            return
        }
        selectedPin = pin
        performSegue(withIdentifier: "goToDetail", sender: pin)
    }
}

extension ViewController: PinDetailDelegate {
    func pinDeleted() {
        deleteLastPin()
    }
}


