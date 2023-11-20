//
//  FloatingTabBarController.swift
//
//
//  Created by Gökhan Mandacı on 20.11.2023.
//

#if canImport(UIKit)
import UIKit

class FloatingTabBarController: UITabBarController {
    // MARK: - Parameters
    /// Custom tab bar height
    @IBInspectable var tabBarHeight: CGFloat = 64
    /// Minimum tab bar item width
    @IBInspectable var minimumItemWidth: CGFloat = 78
    /// Total horizontal spacing15 left and 15 right
    @IBInspectable var horizontalSpacing: CGFloat = 30
    /// Bottom spacing of floating tab bar
    @IBInspectable var bottomSpace: CGFloat = 15
    /// Total inner horizontal spacing 18 left and 18 right (Minimum also)
    @IBInspectable var customTabBarInnerHorizontalSpacing: CGFloat = 36
    /// Custom tab bar width
    @IBInspectable var customTabBarWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTabBarController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setImageInsets()
    }
}

// MARK: - Methods
extension FloatingTabBarController {
    /// Initialize tab bar controller
    private func initTabBarController() {
        delegate = self
        
        customTabBarWidth = Utils.getWidth() - horizontalSpacing
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundImage = UIImage()
            appearance.backgroundEffect = nil
            
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            
            appearance.stackedItemPositioning = .centered
            appearance.stackedItemWidth = min(
                minimumItemWidth,
                (customTabBarWidth - customTabBarInnerHorizontalSpacing) / 4
            )
            appearance.stackedItemSpacing = 1
            appearance.stackedLayoutAppearance.normal.iconColor = .blue
            appearance.stackedLayoutAppearance.selected.iconColor = .blue
            
            // iPad
            appearance.inlineLayoutAppearance.normal.iconColor = .blue
            appearance.inlineLayoutAppearance.selected.iconColor = .blue
            appearance.compactInlineLayoutAppearance.normal.iconColor = .blue
            appearance.compactInlineLayoutAppearance.selected.iconColor = .blue
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            tabBar.backgroundColor = .clear
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
            tabBar.itemPositioning = .centered
            tabBar.itemSpacing = 1
            tabBar.itemWidth = min(
                minimumItemWidth,
                (customTabBarWidth - customTabBarInnerHorizontalSpacing) / 4
            )
        }
        
        setTabBar()
    }
    
    /// Check and set tab bar item image insets
    private func setImageInsets() {
        // Check if device has greater default tab bar height.
        // If not, it means tab bar height increased to custom tab bar
        // height and with no bottom space, item positions have to be adjusted.
        // Divide custom tab bar height(64) - default tab bar height(49)
        // (equals bottomSpacing for our case) to 2
        //
        // In other case, the default is greater and will have
        // bottom spacing. Items also will move up with tab bar so
        // no need for any image inset adjustments.
        guard let customTabBar = tabBar as? FloatingTabBar else { return }
        if !customTabBar.isDefaultGreater {
            tabBar.items?.forEach({ item in
                item.imageInsets = UIEdgeInsets(
                    top: -(bottomSpace / 2),
                    left: 0,
                    bottom: (bottomSpace / 2),
                    right: 0
                )
            })
        }
    }
    
    /// Set custom tab bar
    private func setTabBar() {
        tabBar.insertSubview(getTabBarView(), at: 0)
    }
    
    /// Creates a custom view for tab bar
    /// - Returns: UIView
    private func getTabBarView() -> UIView {
        let blurView = getBlurView()
        let tabBarView = UIView(frame: blurView.bounds)
        tabBarView.layer.shadowPath = UIBezierPath(
            roundedRect: getCustomTabBarFrame(),
            cornerRadius: tabBarHeight / 2
        ).cgPath
        tabBarView.layer.shadowColor = UIColor.black.cgColor
        tabBarView.layer.shadowOpacity = 0.15
        tabBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarView.layer.shadowRadius = 15
        tabBarView.addSubview(blurView)
        return tabBarView
    }
    
    /// Creates a blur view for tab bar
    /// - Returns: UIVisualEffectView
    private func getBlurView() -> UIVisualEffectView {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurView.clipsToBounds = false
        blurView.layer.borderWidth = 1
        blurView.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        blurView.layer.cornerRadius = tabBarHeight / 2
        
        blurView.frame = getCustomTabBarFrame()
        
        let gradientLayer = getGradientLayer()
        gradientLayer.frame = blurView.bounds
        blurView.layer.addSublayer(gradientLayer)
        
        blurView.layer.mask = getMaskLayer()
        return blurView
    }
    
    /// Creates a radial gradient layer
    /// - Returns: CAGradientLayer
    private func getGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.colors = [
            UIColor.blue.withAlphaComponent(0.05).cgColor,
            UIColor.white.withAlphaComponent(0.05).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        return gradientLayer
    }
    
    /// Mask layer for blur view
    /// - Returns: CAShapeLayer
    private func getMaskLayer() -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.path = getMaskPath().cgPath
        return maskLayer
    }
    
    /// Creates a bezier path for mask layer
    /// - Returns: UIBezierPath
    private func getMaskPath() -> UIBezierPath {
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: tabBar.bounds.minY,
                width: Utils.getWidth() - horizontalSpacing,
                height: tabBarHeight
            ),
            cornerRadius: customTabBarWidth / 2
        )
        
        return path
    }
    
    /// Creates custom tab bar frame
    /// - Returns: CGRect
    private func getCustomTabBarFrame() -> CGRect {
        return CGRect(
            x: horizontalSpacing / 2,
            y: tabBar.bounds.minY,
            width: Utils.getWidth() - horizontalSpacing,
            height: tabBarHeight
        )
    }
}

// MARK: - UITabBarController Delegate
extension FloatingTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return viewController != tabBarController.selectedViewController
    }
}


#endif
