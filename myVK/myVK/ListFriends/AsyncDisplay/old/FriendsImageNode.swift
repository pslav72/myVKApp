//
//  FriendsImageNode.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.06.2021.
//

import Foundation
import AsyncDisplayKit

class FriendsImageNode: ASCellNode {

    private let resource: UserPhotos
    private let photoImageNode = ASNetworkImageNode()
    
    private var imageURL: String
    private var height: Int
    private var width: Int
    private var aspectRation: CGFloat = 0
    
    init(resource: UserPhotos, imageURL: String, height: Int, width: Int) {
        self.resource = resource
        self.imageURL = imageURL
        self.height = height
        self.width = width
        super.init()
        
        setup()
    }
    
    override func didLoad() {
        self.neverShowPlaceholders = true
    }
    
    
    private func setup() {
        
        height = height == 0 ? 200 : height
        width = width == 0 ? 200 : width
        
        if width != 0 {
            self.aspectRation = CGFloat(height)/CGFloat(width)
        }

        photoImageNode.url = URL(string: imageURL)
        
        photoImageNode.contentMode = .scaleAspectFill
        photoImageNode.shouldRenderProgressImages = true
        
        addSubnode(photoImageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        photoImageNode.style.preferredSize = CGSize(width: width, height: width*aspectRation)
        return ASWrapperLayoutSpec(layoutElement: photoImageNode)
    }


}
