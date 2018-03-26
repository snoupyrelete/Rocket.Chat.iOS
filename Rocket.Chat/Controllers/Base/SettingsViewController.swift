//
//  SettingsViewController.swift
//  Rocket.Chat
//
//  Created by Dylan Robson on 3/24/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import Foundation

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var getColorsButton: UIButton!
    @IBOutlet weak var updateColorsButton: UIButton!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var updateIdTextField: UITextField!
    @IBOutlet weak var updateValueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let client = API.current()?.client(SettingsClient.self) else { return Alert.defaultError.present() }
        guard let setting = client.fetchSettings()?.filter("id == 'theme-color-content-background-color'").first else { return }
        self.colorLabel.text = "theme-color-content-background-color: " + setting.value
        if let rgb = UInt(setting.value, radix: 16) {
            self.view.backgroundColor = UIColor(rgb: rgb, alphaVal: 1.0)
        }
    }
    
    @IBAction func getColorsButtonDidPressed(_ sender: UIButton) {
        guard let client = API.current()?.client(SettingsClient.self) else { return Alert.defaultError.present() }
        print(client.fetchSettings())
    }
    
    @IBAction func updateColorsButtonDidPressed(_ sender: UIButton) {
        guard
            let client = API.current()?.client(SettingsClient.self),
            let updateId = updateIdTextField.text,
            let updateValue = updateValueTextField.text
        else {
            return Alert.defaultError.present()
        }
        let setting = Setting()
        setting.id = updateId
        setting.value = updateValue
        client.updateSetting(setting)
        
        self.colorLabel.text = updateId + ": " + setting.value
        if let rgb = UInt(setting.value, radix: 16) {
            self.view.backgroundColor = UIColor(rgb: rgb, alphaVal: 1.0)
        }
    }
}
