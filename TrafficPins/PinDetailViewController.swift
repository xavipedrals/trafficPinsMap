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
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var changeImageButton: CustomButton!
    @IBOutlet weak var selectedImageLabel: UILabel!
    @IBOutlet var tagButtons: [TagButton]!
    
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
        selectedImageLabel.text = pin.imageFileName ?? "No selected image"
        guard let imageFile = pin.imageFileName else { return }
        imageView.image = CustomFileManager().loadImageFromDiskWith(fileName: imageFile)
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
    
    @IBAction func changeImagePressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
        if isChangeImageMode {
            pickerView.isHidden = true
            changeImageButton.setTitle("Change image", for: .normal)
            let selectedImageIndex = pickerView.selectedRow(inComponent: 0)
            let fileName = imageNames[selectedImageIndex]
            selectedImageLabel.text = fileName
            imageView.image = CustomFileManager().loadImageFromDiskWith(fileName: fileName)
            pin.imageFileName = fileName
        } else {
            pickerView.isHidden = false
            changeImageButton.setTitle("Save image", for: .normal)
        }
        isChangeImageMode = !isChangeImageMode
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

extension PinDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageNames.count
    }
}

extension PinDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageNames[row]
    }
}
