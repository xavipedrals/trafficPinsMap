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
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pin: RawMapPin!
    let cache = RawPinMapCache()
    var delegate: PinDetailDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = pin.name ?? ""
    }
    
    //MARK: - Actions
    
    @IBAction func changeImagePressed(_ sender: Any) {
        pickerView.isHidden = false
    }
    
    @IBAction func saveChangesPressed(_ sender: Any) {
        pin.name = titleTextField.text
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

extension PinDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var num = 0
        do {
            num = try CustomFileManager().listImageFiles().count
        } catch {
            display(error: error)
        }
        return num
    }
}
