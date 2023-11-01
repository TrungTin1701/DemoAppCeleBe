//
//  SelectedScreenViewController.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 01/11/2023.
//

import Foundation
import UIKit
class SelectedScreenViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.setupButton()
        button1.setTitle("A", for: .normal)
        button2.setTitle("B", for: .normal)
        addFuncButton1()
        addFuncButton2()
    }
    private var button1 = CustomButton()
    private var button2 = CustomButton()
    func setupButton(){
        view.addSubview(button1)
        view.addSubview(button2)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button1.widthAnchor.constraint(equalToConstant: 280).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button1.topAnchor.constraint(equalTo: view.topAnchor,constant: 100).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 280).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.topAnchor.constraint(equalTo: button1.bottomAnchor,constant: 100).isActive = true
    }
    func addFuncButton1(){
        button1.addTarget(self, action: #selector(clickButton1), for: .touchUpInside)
        
    }
    func addFuncButton2(){
        button2.addTarget(self, action: #selector(clickButton2), for: .touchUpInside)
    }
    @objc func clickButton1(){
        button1.shakeButton()
        let name = Notification.Name(rawValue: NotificationHehe.light.rawValue)
        NotificationCenter.default.post(name: name, object: nil)
        dismiss(animated: true,completion: nil)
    }
    @objc func clickButton2(){
        button2.shakeButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            [weak self] in
            guard let self = self else { return}
            let name = Notification.Name(rawValue: NotificationHehe.dark.rawValue)
            NotificationCenter.default.post(name: name, object: nil)
            self.dismiss(animated: true,completion: nil)
        }
    }
}
