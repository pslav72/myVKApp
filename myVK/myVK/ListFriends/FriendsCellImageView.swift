//
//  FriendsCellImageView.swift
//  myVK
//
//  Created by Вячеслав Поляков on 23.02.2021.
//

import UIKit

class FriendsCellImageView: UIView {
    
    @IBInspectable var shadowRadius: CGFloat = 3
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var shadowColor: UIColor = .systemBlue

    override func awakeFromNib() {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
    }
    

    override func draw(_ rect: CGRect) {

    }
    
    
}
