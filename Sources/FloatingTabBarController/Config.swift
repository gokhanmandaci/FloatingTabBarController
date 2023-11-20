//
//  File.swift
//  
//
//  Created by Gökhan Mandacı on 20.11.2023.
//

import Foundation

final class Config {
    static let shared: Config = Config()
    
    private init() {}
    
    // MARK: - Configuration Parameters
    /// Custom tab bar height
    var height: CGFloat = 64
    /// Bottom spacing of custom tab bar
    var bottomSpacing: CGFloat = 15
    /// Minimum tab bar item width
    var minimumItemWidth: CGFloat = 78
    /// Total horizontal spacing15 left and 15 right
    var horizontalSpacing: CGFloat = 30
    /// Total inner horizontal spacing 18 left and 18 right (Minimum also)
    var innerHorizontalSpacing: CGFloat = 36
}
