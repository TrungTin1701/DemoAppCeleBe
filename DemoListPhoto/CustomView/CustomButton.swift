//
//  CustomButton.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 30/10/2023.
//

import Foundation
import UIKit


final class CustomButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    func setupButton(){
        setupShadow()
        setTitleColor(.white, for: .normal)
        backgroundColor = Colors.coolBlue
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius = 25
        layer.borderWidth  = 3.0
        layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func setupShadow(){
        layer.shadowColor = UIColor(.black).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.opacity = 0.9
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    func styleButton(){
        setupShadow()
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius = 25
        layer.borderWidth  = 3.0
        layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func shakeButton(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x+8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}
