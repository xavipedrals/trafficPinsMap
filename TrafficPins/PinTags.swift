//
//  PinTags.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 19/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import UIKit

enum PinTags: String, Codable {
    case danger = "Danger"
    case known = "Known"
    case strange = "Strange"
    case lanes = "Lanes"
    
    init?(index: Int) {
        switch index {
        case 0: self = .danger
        case 1: self = .known
        case 2: self = .strange
        case 3: self = .lanes
        default:
            return nil
        }
    }
    
    var color: UIColor {
        switch self {
        case .danger: return UIColor.red
        case .known: return UIColor.systemGreen
        case .strange: return UIColor.systemOrange
        case .lanes: return UIColor.systemIndigo
        }
    }
}
