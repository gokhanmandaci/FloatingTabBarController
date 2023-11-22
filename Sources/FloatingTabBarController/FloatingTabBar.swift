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
    /// Tab bar height default 49
    @IBInspectable var height: CGFloat = 49
    @IBInspectable var iPadHeight: CGFloat = 49
    
    /// https://stackoverflow.com/a/48198123
    /// Solution for hidesBottomBarWhenPushed delay.
    /// Step 2 applied.
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if iPadHeight != Config.shared.tabBarHeight {
                Config.shared.tabBarHeight = iPadHeight
            }
        } else {
            if height != Config.shared.tabBarHeight {
                Config.shared.tabBarHeight = height
            }
        }
        
        return CGSize(width: superSize.width, height: Config.shared.tabBarHeight)
    }
}

#endif
