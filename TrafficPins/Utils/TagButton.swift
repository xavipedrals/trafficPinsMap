//
//  TagButton.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 19/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import UIKit

class TagButton: UIButton {
    
    private var cornerRadius: CGFloat = 9
    private var borderWidth: CGFloat = 1
    var pinTag: PinTags = .danger
    
    func setup() {
        layer.borderWidth = borderWidth
        layer.borderColor = mainColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        backgroundColor = isMarked ? mainColor : lightColor
        setTitleColor(isMarked ? .white : mainColor, for: .normal)
        setTitle(pinTag.rawValue, for: .normal)
    }
    
    var isMarked: Bool = false {
        didSet {
            backgroundColor = isMarked ? mainColor : lightColor
            setTitleColor(isMarked ? .white : mainColor, for: .normal)
        }
    }
    
    var mainColor: UIColor {
        return pinTag.color
    }
    
    private var lightColor: UIColor? {
        guard let cgColor = mainColor.cgColor.copy(alpha: 0.1) else {
            return nil
        }
        return UIColor(cgColor: cgColor)
    }
}
