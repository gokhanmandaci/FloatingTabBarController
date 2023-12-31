//
//  File.swift
//  
//
//  Created by Gökhan Mandacı on 21.11.2023.
//

#if canImport(UIKit)
import UIKit

struct ConfigModel {
    let tabBarHeight: CGFloat
    let bottomSpacing: CGFloat
    let iPadBottomSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let iPadHorizontalSpacing: CGFloat
    let innerHorizontalSpacing: CGFloat
    let iPadInnerHorizontalSpacing: CGFloat
    let itemSpacing: CGFloat
    let positioning: Int
    let minimumItemWidth: CGFloat
    let cornerRadius: CGFloat
    let iPadCornerRadius: CGFloat
    let borderWidth: CGFloat
    let borderColor: UIColor
    let backgroundColor: UIColor
    let hasBlurBackground: Bool
    let shadowColor: UIColor
    let shadowOpacity: CGFloat
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let hasGradientBackground: Bool
    let gradientType: Int
    let gradientStartPoint: CGPoint
    let gradientEndPoint: CGPoint
    let gradientStartLocation: CGFloat
    let gradientEndLocation: CGFloat
    let gradientStartColor: UIColor
    let gradientEndColor: UIColor
    let ignoresSafeAreaBottom: Bool
    let itemColor: UIColor
    let selectedItemColor: UIColor

    init(
        tabBarHeight: CGFloat = 64,
        bottomSpacing: CGFloat = 15,
        ipadBottomSpacing: CGFloat = 15,
        horizontalSpacing: CGFloat = 15,
        ipadHorizontalSpacing: CGFloat = 15,
        innerHorizontalSpacing: CGFloat = 18,
        iPadInnerHorizontalSpacing: CGFloat = 18,
        itemSpacing: CGFloat = 1,
        positioning: Int = 0,
        minimumItemWidth: CGFloat = 78,
        cornerRadius: CGFloat = -1,
        iPadCornerRadius: CGFloat = -1,
        borderWidth: CGFloat = -1,
        borderColor: UIColor = .white,
        backgroundColor: UIColor = .clear,
        hasBlurBackground: Bool = true,
        shadowColor: UIColor = .black,
        shadowOpacity: CGFloat = 0.15,
        shadowOffset: CGSize = CGSize(width: 0, height: 0),
        shadowRadius: CGFloat = 15,
        hasGradientBackground: Bool = false,
        gradientType: Int = 0,
        gradientStartPoint: CGPoint = CGPoint(x: 0, y: 0),
        gradientEndPoint: CGPoint = CGPoint(x: 1, y: 1),
        gradientStartLocation: CGFloat = -1.0,
        gradientEndLocation: CGFloat = -1.0,
        gradientStartColor: UIColor = .black,
        gradientEndColor: UIColor = .white,
        ignoresSafeAreaBottom: Bool = false,
        itemColor: UIColor = .blue,
        selectedItemColor: UIColor = .blue
    ) {
        self.tabBarHeight = tabBarHeight
        self.bottomSpacing = bottomSpacing
        self.iPadBottomSpacing = ipadBottomSpacing
        self.horizontalSpacing = horizontalSpacing
        self.iPadHorizontalSpacing = ipadHorizontalSpacing
        self.innerHorizontalSpacing = innerHorizontalSpacing
        self.iPadInnerHorizontalSpacing = iPadInnerHorizontalSpacing
        self.itemSpacing = itemSpacing
        self.positioning = positioning
        self.minimumItemWidth = minimumItemWidth
        self.cornerRadius = cornerRadius
        self.iPadCornerRadius = iPadCornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.hasBlurBackground = hasBlurBackground
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.hasGradientBackground = hasGradientBackground
        self.gradientType = gradientType
        self.gradientStartPoint = gradientStartPoint
        self.gradientEndPoint = gradientEndPoint
        self.gradientStartLocation = gradientStartLocation
        self.gradientEndLocation = gradientEndLocation
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        self.ignoresSafeAreaBottom = ignoresSafeAreaBottom
        self.itemColor = itemColor
        self.selectedItemColor = selectedItemColor
    }
}


#endif
