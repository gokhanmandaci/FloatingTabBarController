//
//  File.swift
//  
//
//  Created by Gökhan Mandacı on 20.11.2023.
//

#if canImport(UIKit)
import UIKit

final class Config {
    static let shared: Config = Config()
    
    private init() {}
    
    // MARK: - Configuration Parameters
    var tabBarHeight: CGFloat = 49
    var bottomSpacing: CGFloat = 15
    var horizontalSpacing: CGFloat = 15
    var innerHorizontalSpacing: CGFloat = 18
    var itemSpacing: CGFloat = 1
    var positioning: Int = 0
    var minimumItemWidth: CGFloat = 78
    var cornerRadius: CGFloat = -1
    var borderWidth: CGFloat = -1
    var borderColor: UIColor = .white
    var backgroundColor: UIColor = .clear
    var hasBlurBackground: Bool = true
    var shadowColor: UIColor = .black
    var shadowOpacity: CGFloat = 0.15
    var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    var shadowRadius: CGFloat = 15
    var hasGradientBackground: Bool = false
    var gradientType: Int = 0
    var gradientStartPoint: CGPoint = CGPoint(x: 0, y: 0)
    var gradientEndPoint: CGPoint = CGPoint(x: 1, y: 1)
    var gradientStartLocation: CGFloat = -1.0
    var gradientEndLocation: CGFloat = -1.0
    var gradientStartColor: UIColor = .black
    var gradientEndColor: UIColor = .white
    
    func setConfig(model: ConfigModel) {
        tabBarHeight = model.tabBarHeight
        bottomSpacing = model.bottomSpacing
        horizontalSpacing = model.horizontalSpacing
        innerHorizontalSpacing = model.innerHorizontalSpacing
        itemSpacing = model.itemSpacing
        positioning = model.positioning
        minimumItemWidth = model.minimumItemWidth
        cornerRadius = model.cornerRadius
        borderWidth = model.borderWidth
        borderColor = model.borderColor
        backgroundColor = model.backgroundColor
        hasBlurBackground = model.hasBlurBackground
        shadowColor = model.shadowColor
        shadowOpacity = model.shadowOpacity
        shadowOffset = model.shadowOffset
        shadowRadius = model.shadowRadius
        hasGradientBackground = model.hasGradientBackground
        gradientType = model.gradientType
        gradientStartPoint = model.gradientStartPoint
        gradientEndPoint = model.gradientEndPoint
        gradientStartLocation = model.gradientStartLocation
        gradientEndLocation = model.gradientEndLocation
        gradientStartColor = model.gradientStartColor
        gradientEndColor = model.gradientEndColor
    }
}

#endif
