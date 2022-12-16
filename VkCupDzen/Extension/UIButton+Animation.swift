//
//  UIButton+Animation.swift
//  SomeVKCupProject
//
//  Created by Павел Кай on 15.12.2022.
//

import UIKit

extension UIButton {
    
    func animateTapOnButton() {

        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, animations: {
            
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
                self.transform = .identity
            }
        }
        
    }
    
}
