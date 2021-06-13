//
//  BaseNode.swift
//  myVK
//
//  Created by Вячеслав Поляков on 13.06.2021.
//

import AsyncDisplayKit

class BaseNode: ASDisplayNode {
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
    }
}
