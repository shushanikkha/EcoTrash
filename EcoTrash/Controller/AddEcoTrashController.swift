//
//  AddEcoTrashController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/7/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class AddEcoTrashController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    @IBOutlet weak var trashScrollView: UIScrollView!
    @IBOutlet weak var trashContentView: UIView!
    @IBOutlet weak var trashTypeLabel: UILabel!
    @IBOutlet weak var trashTypePicker: UIPickerView!
    
//    @IBOutlet weak var addressLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var datePicker: UIDatePicker!
//    @IBOutlet weak var trashImage: UIImageView!
    
    
    var pickerData = [String]()
     let trashTypeCellIndexPath = IndexPath(row: 1, section: 1)
    var isTrashTypePickerShown: Bool = false {
        didSet {
            trashTypePicker.isHidden = !isTrashTypePickerShown
        }
    }
  
    var trash: Marker?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trashTypePicker.delegate = self
        self.trashTypePicker.dataSource = self
     
        self.pickerData = ["Plastic", "Paper", "Glass", "Other"]
    
    }
    
//    func updateTrashType() {
//        if isTrashTypePickerShown {
//            self.trashContentView.frame.height = 100.0
//            trashTypeLabel.text = trashTypePicker
//        }
//        
//    }

    
    
    // MARK: - IBActions -
    
    @IBAction func chooseImageButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion:  nil)
        
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let pickedImage = info[.originalImage] as? UIImage else { return }
//        self.trashImage.image = pickedImage
//        picker.dismiss(animated: true, completion: nil)
//    }
//
    @IBAction func saveButton(_ sender: UIButton) {
        
    }
    
    @IBAction func trashTypeButton(_ sender: UIButton) {
      
    }
    
    
    
    // MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.trashTypeLabel.text = trashTypePicker.selectedRow(inComponent: 0).description
    }
    
    // MARK: - Table View Method -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row){
        case (trashTypeCellIndexPath.section, trashTypeCellIndexPath.row): if isTrashTypePickerShown {
            return 216.0
        } else {
            return 0.0
            }
        default:
            return 44.0
        }
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (trashTypeCellIndexPath.section, trashTypeCellIndexPath.row - 1):
            if isTrashTypePickerShown {
                isTrashTypePickerShown = false
            } else if isTrashTypePickerShown {
                isTrashTypePickerShown = false
                isTrashTypePickerShown = true
            } else {
                isTrashTypePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
}
