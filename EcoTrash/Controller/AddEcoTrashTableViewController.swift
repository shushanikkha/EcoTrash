//
//  AddEcoTrashTableViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/21/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import MapKit

enum WasteType: String, CaseIterable {
    case Plastic
    case Papaer
    case Glass
    case Metal
    case Other
}

class AddEcoTrashTableViewController:  UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var trashTypeLabel: UILabel!
    @IBOutlet weak var trashTypePickerView: UIPickerView!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var creationDatePicker: UIDatePicker!
    @IBOutlet weak var availableDateLabel: UILabel!
    @IBOutlet weak var availableDatePicker: UIDatePicker!
    @IBOutlet weak var availableAmount: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addImageCollectionView: UICollectionView!
    
    var images = [UIImage]()
    var trash: Trash?

    let trashTypePickerCellIndexPath = IndexPath(row: 1, section: 0)
    var isTrashTypePickerShown: Bool = false {
        didSet {
            trashTypePickerView.isHidden = !isTrashTypePickerShown
        }
    }
    
    let creationDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    var isCreationDatePickerShown: Bool = false {
        didSet {
            creationDatePicker.isHidden = !isCreationDatePickerShown
        }
    }
    
    let availableDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    var isAvailableDatePickerShown: Bool = false {
        didSet {
            availableDatePicker.isHidden = !isAvailableDatePickerShown
        }
    }
    
    
//    var latitude = Double()
//    var longitude = Double()
//    var user: User?
//    var image = UIImage()
//
//    var trash: Trash {
//        var latitude = self.latitude
//        var longitude = self.longitude
//        var creationDate = creationDateLabel.text
//        var availableDate = availableDateLabel.text
//        var user = self.user
//        var type = trashTypeLabel.text
//        var image = self.image
//        var amount = availableAmount.text
//
//        return Trash(latitude: latitude, longitude: longitude, creationDate: creationDate, availableDate: availableDate, user: user, type: <#T##String#>, image: <#T##UIImage#>, amount: <#T##Int#>)
//    }
//
    let addTrashImageIndexPath = IndexPath(row: 0, section: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trashTypePickerView.delegate = self
        self.trashTypePickerView.dataSource = self
        
        let midnightTodey = Calendar.current.startOfDay(for: Date())
        creationDatePicker.minimumDate = midnightTodey
        creationDatePicker.maximumDate = midnightTodey
        creationDatePicker.date = midnightTodey
        
        updateDateViews()
    }
    
    // MARK: - Update Date Method -
    
    func updateDateViews() {
        availableDatePicker.minimumDate = creationDatePicker.date
        availableDatePicker.maximumDate = creationDatePicker.date.addingTimeInterval(864000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        creationDateLabel.text = dateFormatter.string(from: creationDatePicker.date)
        availableDateLabel.text = dateFormatter.string(from: availableDatePicker.date)

    }
    
    // MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WasteType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return WasteType.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        trashTypeLabel.text = WasteType.allCases[trashTypePickerView.selectedRow(inComponent: 0)].rawValue
    }
    

    // MARK: - Table view data source

   override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row){
        case(trashTypePickerCellIndexPath.section, trashTypePickerCellIndexPath.row):
                return isTrashTypePickerShown ? 150.0 : 0.0
        case (creationDatePickerCellIndexPath.section, creationDatePickerCellIndexPath.row):
                return isCreationDatePickerShown ? 216.0 : 0.0
        case (availableDatePickerCellIndexPath.section, availableDatePickerCellIndexPath.row):
            return isAvailableDatePickerShown ? 216.0 : 0.0
        case (addTrashImageIndexPath.section, addTrashImageIndexPath.row):
            return 100
        case(trashTypePickerCellIndexPath.section, trashTypePickerCellIndexPath.row): if isTrashTypePickerShown {
            return 150.0
        } else {
            return 0.0
            }
        case (creationDatePickerCellIndexPath.section, creationDatePickerCellIndexPath.row): if isCreationDatePickerShown  {
            return 216.0
        } else {
            return 0.0
            }
        case (availableDatePickerCellIndexPath.section, availableDatePickerCellIndexPath.row): if isAvailableDatePickerShown {
            return 216.0
        } else {
            return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case(trashTypePickerCellIndexPath.section, trashTypePickerCellIndexPath.row - 1):
            if isTrashTypePickerShown {
                isTrashTypePickerShown = false
            } else {
               isTrashTypePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (creationDatePickerCellIndexPath.section, creationDatePickerCellIndexPath.row - 1):
            if isCreationDatePickerShown {
                isCreationDatePickerShown = false
            } else if isAvailableDatePickerShown {
                isAvailableDatePickerShown = false
                isCreationDatePickerShown = true
            } else {
                isCreationDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (availableDatePickerCellIndexPath.section, availableDatePickerCellIndexPath.row - 1):
            if isAvailableDatePickerShown {
                isAvailableDatePickerShown = false
            } else if isCreationDatePickerShown {
                isCreationDatePickerShown = false
                isAvailableDatePickerShown = true
            } else {
                isAvailableDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    // MARK: - IBActions -
    
    @IBAction func saveButtonTapeed(_ sender: UIButton) {
//        guard let creationDate =
    }

    
    @IBAction func mapButtonTapeed(_ sender: UIButton) {
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        
        mapVC.setAddres = { (dict) -> () in
            self.addressLabel.text = (dict["addres"] as! String)
            self.trash?.latitude = (dict["latitude"] as! Double)
            self.trash?.longitude = (dict["longitude"] as! Double)
        }
        
        let navVC = UINavigationController(rootViewController: mapVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
}

extension AddEcoTrashTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
 
  
    // Mark: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
          setupPickerImage()
        } else {
            removeImage(at: indexPath.row - 1)
        }
    }
    
    private func removeImage(at index: Int) {
        let alert = UIAlertController(title: "Delete Image", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (deleteAction) in
            self.images.remove(at: index)
            self.addImageCollectionView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion:  nil)
    }
    
    private func setupPickerImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
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
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddTrashImageCell", for: indexPath) as? AddTrashImageCell {
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrashImageCollectionViewCell", for: indexPath) as? TrashImageCollectionViewCell
        cell?.setUp(with: images[indexPath.row - 1])
        return cell ?? UICollectionViewCell()
    }
    
    // MARK: - UIImagePickerControllerDelegate -
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        self.images.append(pickedImage)
        picker.dismiss(animated: true, completion: nil)
        addImageCollectionView.reloadData()
    }
}
