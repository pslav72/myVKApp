//
//  ImageControllerPresentation.swift
//  myVK
//
//  Created by Вячеслав Поляков on 13.06.2021.
//

import AsyncDisplayKit
import RealmSwift

class ImageControllerPresentation: ASDKViewController<BaseNode> {
    
 
    
    
    var imageFeed: ImagePresentation!
    
    override init() {
        super.init(node: BaseNode())
        imageFeed = ImagePresentation()
        self.node.addSubnode( imageFeed )
        self.node.backgroundColor = .white
        
        self.node.layoutSpecBlock = { (node, contraindedSize) in
            return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: self.imageFeed)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
