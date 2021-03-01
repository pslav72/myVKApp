//
//  FriendsCellImageViewSubView.swift
//  myVK
//
//  Created by Вячеслав Поляков on 23.02.2021.
//

import UIKit

//@IBInspectable
class FriendsCellImageViewSubView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var masksToBounds: Bool = true

    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = masksToBounds
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    }
    

}
