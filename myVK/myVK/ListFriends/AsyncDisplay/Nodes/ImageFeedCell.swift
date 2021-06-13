//
//  ImageFeedCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 13.06.2021.
//

import AsyncDisplayKit

class ImageFeedCell: BaseCellNode {
    
    private let photoImage = ASNetworkImageNode()
    
    private var imageURL: String
    private var height: Int
    private var width: Int
    private var aspectRation: CGFloat = 1
    
    init(imageURL: String, height: Int, width: Int) {
        self.imageURL = imageURL
        self.height = height
        self.width = width
        super.init()
        
        setup()
    }
    
    private func setup() {
        
        height = height == 0 ? 200 : height
        width = width == 0 ? 200 : width
        
        if width != 0 {
            self.aspectRation = CGFloat(height)/CGFloat(width)
        }
        
        photoImage.backgroundColor = .white
        photoImage.url = URL(string: imageURL)
        photoImage.contentMode = .scaleAspectFill
        photoImage.shouldRenderProgressImages = true
        
        addSubnode(photoImage)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        photoImage.style.preferredSize = CGSize(width: width, height: width*aspectRation)
        return ASWrapperLayoutSpec(layoutElement: photoImage)
    }
}
