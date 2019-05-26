//
//  SettingsViewController.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    @IBOutlet weak var settingsUserLabel: UILabel!
    @IBOutlet weak var settingsUserImage: UIImageView!
    @IBOutlet weak var artistsSlider: UISlider!
    @IBOutlet weak var artistsSliderLabel: UILabel!
    
    
    let settings = "information"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let hash = UserDefaults.standard.value(forKey: Constants.Keys.hash.rawValue) as? String,
            let url = Utility.loadWithFileManager(hash),
            let image = UIImage(contentsOfFile: url.path) {
                settingsUserImage.image = image
        }

        if let userName = UserDefaults.standard.value(forKey: Constants.Keys.userName.rawValue) as? String {
            settingsUserLabel.text = userName
        }
        
        if let artistsCount = UserDefaults.standard.value(forKey: Constants.Keys.artistsCount.rawValue) as? Int {
            artistsSliderLabel.text = "Max Return Artists: \(artistsCount)"
            artistsSlider.value = Float(artistsCount)
        }
        
    }
    
    //MARK: Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if touch?.view == view.viewWithTag(3) {
            
            let imageController = UIImagePickerController()
            imageController.sourceType = .photoLibrary
            imageController.delegate = self
            present(imageController, animated: true, completion: nil)
        } else if touch?.view == view.viewWithTag(2) {
            changeUserName()
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        UserDefaults.standard.set(value, forKey: Constants.Keys.artistsCount.rawValue)
        artistsSliderLabel.text = "Max Return Artists: \(value)"
    }
    

    func setupSettings() {
        settingsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func changeUserName() {
        
        let alert = UIAlertController(title: "Change User Name", message: nil, preferredStyle: .alert)
        let changeNameAction = UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
            
            guard let nameField = alert.textFields?.first else {
                return
            }
            
            if let newName = nameField.text, newName.count > 0, newName != "" && newName != self.settingsUserLabel.text {
                UserDefaults.standard.set(newName, forKey: Constants.Keys.userName.rawValue)
                self.settingsUserLabel.text = newName
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addTextField() { [unowned self] nameField in
            nameField.text = self.settingsUserLabel.text
        }
        alert.addAction(changeNameAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

}

//MARK: TableView
extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier, for: indexPath) as! SettingsTableCell
        
        cell.config(with: settings)
        
        return cell
        
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: UIPickerControllerDelegate
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let data = image.pngData() else {
            return
        }
        
        Utility.saveWithFileManager(data)
        
        let hash = String(data.hashValue)
        UserDefaults.standard.set(hash, forKey: Constants.Keys.hash.rawValue)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
