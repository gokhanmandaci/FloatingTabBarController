//
//  FloatingTabBar.swift
//  
//
//  Created by Gökhan Mandacı on 20.11.2023.
//

#if canImport(UIKit)
import UIKit

class FloatingTabBar: UITabBar {
    // MARK: - Parameters
    /// Bottom spacing of custom tab bar
    private let bottomSpacing: CGFloat = 15
    /// Custom tab bar height
    private let tabBarHeight: CGFloat = 64
    /// Without bottom safe area, this value is custom
    /// tab bar height (64) + bottom spacing
    private var tabBarAndBottomSpacingHeight: CGFloat = 79
    /// Is superSize height is greater than tabBarHeight
    var isDefaultGreater: Bool = false
    
    /// https://stackoverflow.com/a/48198123
    /// Solution for hidesBottomBarWhenPushed delay.
    /// Step 2 applied.
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        
        /// If this value is greater than custom tab bar height
        /// use supersize height. Ex: Adding safe area bottom
        if superSize.height > tabBarHeight {
            isDefaultGreater = true
            tabBarAndBottomSpacingHeight = superSize.height + bottomSpacing
        }
        
        return CGSize(width: superSize.width, height: tabBarAndBottomSpacingHeight)
    }
}

#endif
