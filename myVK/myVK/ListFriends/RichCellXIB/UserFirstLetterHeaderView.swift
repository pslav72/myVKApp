//
//  UserFirstLetterHeaderView.swift
//  myVK
//
//  Created by Вячеслав Поляков on 05.03.2021.
//

import UIKit

class UserFirstLetterHeaderView: UITableViewHeaderFooterView {

   static let reuseIdentifier = "UserFirstLetterHeaderView"
    
    let headerTitle = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSibviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSibviews()
        setupConstraints()
    }
    
    private func setupSibviews() {
        self.addSubview(headerTitle)
        headerTitle.textColor = .black
        headerTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        headerTitle.textAlignment = .left
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let xOffset: CGFloat = 20
        let yOffset: CGFloat = 12
        
        headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xOffset).isActive = true
        headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xOffset).isActive = true
        headerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: -yOffset).isActive = true
        headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: yOffset).isActive = true
    }
}
