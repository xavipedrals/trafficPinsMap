//
//  PinDetailViewController.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 18/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import UIKit

protocol PinDetailDelegate {
    func pinDeleted()
}

class PinDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet var tagButtons: [TagButton]!
    @IBOutlet weak var idLabel: UILabel!
    
    var pin: RawMapPin!
    let cache = RawPinMapCache()
    var delegate: PinDetailDelegate?
    var imageNames: [String] {
        let images = try? CustomFileManager().listImageFiles()
        return images ?? []
    }
    var isChangeImageMode = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = pin.name ?? ""
        idLabel.text = "ID: \(pin.id)"
        imageView.image = CustomFileManager().loadImageFromDiskWith(fileName: pin.imageFileName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (i, button) in tagButtons.enumerated() {
            let tag = PinTags(index: i)!
            button.pinTag = tag
            button.isMarked = pin.tags?.contains(tag) ?? false
            button.setup()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func tagPressed(_ sender: TagButton) {
        sender.isMarked.toggle()
    }
    
    @IBAction func saveChangesPressed(_ sender: Any) {
        pin.name = titleTextField.text
        let tags = tagButtons
            .filter{ $0.isMarked }
            .compactMap{ $0.pinTag }
        pin.tags = tags
        cache.update(pin: pin)
        self.dismiss(animated: true)
    }
    
    @IBAction func exitWithoutSavingPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func deletePinPressed(_ sender: Any) {
        displayTwoOptions(title: "Sure?", message: "Press Delete if you really want to delete this pin", okOption: "Delete") { _ in
            self.cache.deletePin(id: self.pin.id)
            self.delegate?.pinDeleted()
            self.dismiss(animated: true)
        }
    }
}
