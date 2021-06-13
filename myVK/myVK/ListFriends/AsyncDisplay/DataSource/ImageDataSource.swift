//
//  ImageDataSource.swift
//  myVK
//
//  Created by Вячеслав Поляков on 13.06.2021.
//

import AsyncDisplayKit

class ImageDataSource: NSObject, ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        
        if indexPath.section == 0 {
            let cell = ASCellNode()
            return cell
        } else {
            let cell = ASCellNode()
            return cell
        }
        
    }
    
    
}
