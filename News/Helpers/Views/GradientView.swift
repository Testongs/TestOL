//
//  GradientView.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import UIKit

class GradientView: UIView {
    var gradient: CAGradientLayer?;
    
    override func layoutSubviews() {
        if gradient != nil {
            gradient!.removeFromSuperlayer()
        }
        
        gradient = CAGradientLayer()
        gradient!.frame = self.bounds;
        gradient!.colors = [UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)];
        self.layer.insertSublayer(gradient!, at: 0)
    }
}
