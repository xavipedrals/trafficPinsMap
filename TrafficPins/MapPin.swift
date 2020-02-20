//
//  MapPin.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 18/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
    let id: Int
    let coordinate: CLLocationCoordinate2D
    
    init(rawMapPin: RawMapPin) {
        self.id = rawMapPin.id
        self.coordinate = CLLocationCoordinate2D(latitude: rawMapPin.latitude, longitude: rawMapPin.longitude)
        super.init()
    }
}

struct RawMapPin: Codable {
    var id: Int
    var name: String?
    var latitude: Double
    var longitude: Double
    var imageFileName: String {
        return "\(id).png"
    }
    var tags: [PinTags]?
    
    init(latitude: Double, longitude: Double) {
        id = RawPinMapCache().nextId
        self.latitude = latitude
        self.longitude = longitude
    }
}
