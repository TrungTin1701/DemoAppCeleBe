//
//  NotificationCenterViewController.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 01/11/2023.
//

import UIKit

class NotificationCenterViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    private let newButton = CustomButton()
    let light = Notification.Name(rawValue: NotificationHehe.light.rawValue)
    let dark = Notification.Name(rawValue: NotificationHehe.dark.rawValue)
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomButton()
        newButton.setTitle(" UWU ", for: .normal)
        addActionforButton()
        createObservers()
    }
    
    private func setupCustomButton(){
        view.addSubview(newButton)
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        newButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 300).isActive = true
        
    }
    
    func addActionforButton(){
        newButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }
    
    @objc func clickButton(){
        newButton.shakeButton()
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectedScreenViewController") as! SelectedScreenViewController
        present(selectionVC,animated: true,completion: nil)
        
    }
    
    func createObservers(){
        // Light
        NotificationCenter.default.addObserver(self, selector: #selector( NotificationCenterViewController.updateLabel(notification:)), name: light, object: nil)
        // Dark
        NotificationCenter.default.addObserver(self, selector: #selector( NotificationCenterViewController.updateLabel(notification:)), name: dark, object: nil)
    }
    
    @objc func updateLabel(notification: NSNotification){
        let isLight = notification.name == light
        myLabel.text = isLight ? "Light" : "Dark"
    }
}
