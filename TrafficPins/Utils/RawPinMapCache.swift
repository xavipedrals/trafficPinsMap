//
//  RawPinMapCache.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 18/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import Foundation

class RawPinMapCache: DefaultCache<[RawMapPin]> {
    let fileName = "rawMapPins.json"
    
    var pins: [RawMapPin] {
        get {
            return fetch(fileName: fileName) ?? []
        }
        set {
            save(obj: newValue, fileName: fileName)
        }
    }
    
    var nextId: Int {
        let max = pins.compactMap{ $0.id }.max{ $0 < $1 } ?? 0
        return max + 1
    }
    
    func getPinWith(id: Int) -> RawMapPin? {
        return pins.first{ $0.id == id }
    }
    
    func update(pin: RawMapPin) {
        pins.removeAll{ $0.id == pin.id }
        pins.append(pin)
    }
    
    func deletePin(id: Int) {
        pins.removeAll{ $0.id == id }
    }
}
