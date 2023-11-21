//
//  FloatingTabBarController.swift
//
//
//  Created by Gökhan Mandacı on 20.11.2023.
//

#if canImport(UIKit)
import UIKit

enum FloatingTabBarStackItemPositioning: Int {
    case automatic = 0
    case centered = 1
    case fill = 2
}

enum FloatingTabBarGradientType: Int {
    case axial = 0
    case radial = 1
    case conic = 2
}

class FloatingTabBarController: UITabBarController {
    // MARK: - Parameters
    /// Tab bar view
    private var tabBarView: UIView?
    /// Custom tab bar width
    private var customTabBarWidth: CGFloat = 0
    /// Custom tab bar width default is 49
    private var tabBarHeight: CGFloat = 49
    /// Total left and right horizontal spacing
    private var totalHorizontalSpacing: CGFloat = 0
    /// Total inner left and right horizontal spacing. If item positions are
    /// centered totalInnerHorizontalSpacing is first and last item's min
    /// left and right margin.
    private var totalInnerHorizontalSpacing: CGFloat = 0
    /// Tab bar items count
    private var tabBarItemsCount: Int = 0
    
    // MARK: - Inspectable Parameters
    /// Custom tab bar width default is 15
    @IBInspectable var bottomSpacing: CGFloat = 15
    /// Left and Right spaces default is 15
    @IBInspectable var horizontalSpacing: CGFloat = 15
    /// Left and Right spaces default is 18
    @IBInspectable var innerHorizontalSpacing: CGFloat = 18
    /// Stack item spacing default is 1
    @IBInspectable var itemSpacing: CGFloat = 1
    /// Stack item positioning
    @IBInspectable var positioning: Int = 0
    /// Minimum tab bar item width default is 78
    @IBInspectable var minimumItemWidth: CGFloat = 78
    /// Tab bar corner radius default is -1 means ellipse
    @IBInspectable var cornerRadius: CGFloat = -1
    /// Tab bar border width
    @IBInspectable var borderWidth: CGFloat = -1
    /// Tab bar border color default is white
    @IBInspectable var borderColor: UIColor = .white
    /// Tab bar has background color default is clear
    @IBInspectable var backgroundColor: UIColor = .clear
    /// Checks tab bar has blur background default is true
    @IBInspectable var hasBlurBackground: Bool = true
    /// Shadow color default is black
    @IBInspectable var shadowColor: UIColor = .black
    /// Shadow opacity default is 0.15
    @IBInspectable var shadowOpacity: CGFloat = 0.15
    /// Shadow offset default CGSize(width: 0, height: -3)
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    /// Shadow radius blur radius
    @IBInspectable var shadowRadius: CGFloat = 15
    /// Tab bar gradient background default is false
    @IBInspectable var hasGradientBackground: Bool = false
    /// Gradient type
    @IBInspectable var gradientType: Int = 0
    /// Gradient color start point
    @IBInspectable var gradientStartPoint: CGPoint = CGPoint(x: 0, y: 0)
    /// Gradient color end point
    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 1, y: 1)
    /// Gradient color start location
    @IBInspectable var gradientStartLocation: CGFloat = -1.0
    /// Gradient color end location
    @IBInspectable var gradientEndLocation: CGFloat = -1.0
    /// Gradient start color
    @IBInspectable var gradientStartColor: UIColor = .black
    /// Gradient end color
    @IBInspectable var gradientEndColor: UIColor = .white
    /// Ignores safe area when calculating bottom spacing default false
    @IBInspectable var ignoresSafeAreaBottom: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !(tabBar is FloatingTabBar) {
            setValue(FloatingTabBar(frame: tabBar.frame), forKey: "tabBar")
        }
        
        setConfigModel()
        initTabBarController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if Config.shared.ignoresSafeAreaBottom {
            tabBar.frame.origin.y = view.frame.height - (tabBarHeight + Config.shared.bottomSpacing)
        } else {
            tabBar.frame.origin.y = view.frame.height - (tabBarHeight + Config.shared.bottomSpacing + view.safeAreaInsets.bottom)
        }
        
        setImageInsets()
    }
    
    convenience init(configModel: ConfigModel) {
        self.init()
        
        Config.shared.setConfig(model: configModel)
        initTabBarController()
    }
}

// MARK: - Methods
extension FloatingTabBarController {
    /// Set config model with inspectable parameters
    private func setConfigModel() {
        if let tabBar = tabBar as? FloatingTabBar {
            if tabBar.height != tabBarHeight {
                tabBarHeight = tabBar.height
            }
        }
        
        let configModel = ConfigModel(
            tabBarHeight: tabBarHeight,
            bottomSpacing: bottomSpacing,
            horizontalSpacing: horizontalSpacing,
            innerHorizontalSpacing: innerHorizontalSpacing,
            itemSpacing: itemSpacing,
            positioning: positioning,
            minimumItemWidth: minimumItemWidth,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth,
            borderColor: borderColor,
            backgroundColor: backgroundColor,
            hasBlurBackground: hasBlurBackground,
            shadowColor: shadowColor,
            shadowOpacity: shadowOpacity,
            shadowOffset: shadowOffset,
            shadowRadius: shadowRadius,
            hasGradientBackground: hasGradientBackground,
            gradientType: gradientType,
            gradientStartPoint: gradientStartPoint,
            gradientEndPoint: gradientEndPoint,
            gradientStartLocation: gradientStartLocation,
            gradientEndLocation: gradientEndLocation,
            gradientStartColor: gradientStartColor,
            gradientEndColor: gradientEndColor,
            ignoresSafeAreaBottom: ignoresSafeAreaBottom
        )
        
        Config.shared.setConfig(model: configModel)
    }
    
    /// Initialize tab bar controller
    private func initTabBarController() {
        tabBarHeight = Config.shared.tabBarHeight
        totalHorizontalSpacing = Config.shared.horizontalSpacing * 2
        totalInnerHorizontalSpacing = Config.shared.innerHorizontalSpacing * 2
        tabBarItemsCount = tabBar.items?.count ?? 0
        
        delegate = self
        
        customTabBarWidth = Utils.getWidth() - totalHorizontalSpacing
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundImage = UIImage()
            appearance.backgroundEffect = nil
            
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            
            switch Config.shared.positioning {
            case FloatingTabBarStackItemPositioning.automatic.rawValue:
                appearance.stackedItemPositioning = .automatic
            case FloatingTabBarStackItemPositioning.centered.rawValue:
                appearance.stackedItemPositioning = .centered
            case FloatingTabBarStackItemPositioning.fill.rawValue:
                appearance.stackedItemPositioning = .fill
            default:
                appearance.stackedItemPositioning = .automatic
            }
            appearance.stackedItemPositioning = .centered
            appearance.stackedItemWidth = min(
                Config.shared.minimumItemWidth,
                (customTabBarWidth - totalInnerHorizontalSpacing) / CGFloat(tabBarItemsCount)
            )
            appearance.stackedItemSpacing = Config.shared.itemSpacing
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
            switch Config.shared.positioning {
            case FloatingTabBarStackItemPositioning.automatic.rawValue:
                tabBar.itemPositioning = .automatic
            case FloatingTabBarStackItemPositioning.centered.rawValue:
                tabBar.itemPositioning = .centered
            case FloatingTabBarStackItemPositioning.fill.rawValue:
                tabBar.itemPositioning = .fill
            default:
                tabBar.itemPositioning = .automatic
            }
            tabBar.itemSpacing = Config.shared.itemSpacing
            tabBar.itemWidth = min(
                Config.shared.minimumItemWidth,
                (customTabBarWidth - totalInnerHorizontalSpacing) / CGFloat(tabBarItemsCount)
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
//        guard let customTabBar = tabBar as? FloatingTabBar else { return }
//        if !customTabBar.isDefaultGreater {
//            tabBar.items?.forEach({ item in
//                item.imageInsets = UIEdgeInsets(
//                    top: -(Config.shared.bottomSpacing / 2),
//                    left: 0,
//                    bottom: (Config.shared.bottomSpacing / 2),
//                    right: 0
//                )
//            })
//        }
        
//        tabBar.items?.forEach({ item in
//            item.imageInsets = UIEdgeInsets(
//                top: -Config.shared.tabBarItemYPosition,
//                left: 0,
//                bottom: Config.shared.tabBarItemYPosition,
//                right: 0
//            )
//            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -Config.shared.tabBarItemYPosition)
//        })
    }
    
    /// Set custom tab bar
    private func setTabBar() {
        if tabBarView != nil {
            tabBarView?.removeFromSuperview()
            tabBarView = nil
        }
        tabBarView = getTabBarView()
        tabBar.insertSubview(tabBarView!, at: 0)
    }
    
    /// Creates a custom view for tab bar
    /// - Returns: UIView
    private func getTabBarView() -> UIView {
        let tabCornerRadius = Config.shared.cornerRadius == -1 ? tabBarHeight / 2 : Config.shared.cornerRadius
        let tabBarView = UIView(frame: getCustomTabBarFrame())
        tabBarView.backgroundColor = Config.shared.backgroundColor
        tabBarView.clipsToBounds = false
        tabBarView.layer.borderWidth = Config.shared.borderWidth
        tabBarView.layer.borderColor = Config.shared.borderColor.cgColor
        tabBarView.layer.cornerRadius = tabCornerRadius
        tabBarView.layer.shadowPath = UIBezierPath(
            roundedRect: getShadowFrame(),
            cornerRadius: tabCornerRadius
        ).cgPath
        tabBarView.layer.shadowColor = Config.shared.shadowColor.cgColor
        tabBarView.layer.shadowOpacity = Float(Config.shared.shadowOpacity)
        tabBarView.layer.shadowOffset = Config.shared.shadowOffset
        tabBarView.layer.shadowRadius = Config.shared.shadowRadius
        if Config.shared.hasBlurBackground {
            let blurView = getBlurView(tabBarView.bounds)
            tabBarView.addSubview(blurView)
        } else {
            if Config.shared.hasGradientBackground {
                let gradientLayer = getGradientLayer()
                gradientLayer.frame = tabBarView.bounds
                tabBarView.layer.addSublayer(gradientLayer)
            }
        }
        return tabBarView
    }
    
    /// Creates a blur view for tab bar
    /// - Returns: UIVisualEffectView
    private func getBlurView(_ frame: CGRect) -> UIVisualEffectView {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurView.frame = frame
        
        if Config.shared.hasGradientBackground {
            let gradientLayer = getGradientLayer()
            gradientLayer.frame = blurView.bounds
            blurView.layer.addSublayer(gradientLayer)
        }
        
        blurView.layer.mask = getMaskLayer()
        return blurView
    }
    
    /// Creates a radial gradient layer
    /// - Returns: CAGradientLayer
    private func getGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        switch Config.shared.gradientType {
        case FloatingTabBarGradientType.axial.rawValue:
            gradientLayer.type = .axial
        case FloatingTabBarGradientType.radial.rawValue:
            gradientLayer.type = .radial
        case FloatingTabBarGradientType.conic.rawValue:
            gradientLayer.type = .conic
        default:
            gradientLayer.type = .axial
        }
        gradientLayer.colors = [
            Config.shared.gradientStartColor.cgColor,
            Config.shared.gradientEndColor.cgColor,
        ]
        if Config.shared.gradientStartLocation != -1,
           Config.shared.gradientEndLocation != -1 {
            gradientLayer.locations = [
                NSNumber(value: Float(Config.shared.gradientStartLocation)),
                NSNumber(value: Float(Config.shared.gradientEndLocation))
            ]
        } else {
            gradientLayer.startPoint = Config.shared.gradientStartPoint
            gradientLayer.endPoint = Config.shared.gradientEndPoint
        }
    
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
        let tabCornerRadius = Config.shared.cornerRadius == -1 ? tabBarHeight / 2 : Config.shared.cornerRadius
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: tabBar.bounds.minY,
                width: Utils.getWidth() - totalHorizontalSpacing,
                height: tabBarHeight
            ),
            cornerRadius: tabCornerRadius
        )
        
        return path
    }
    
    /// Creates custom tab bar frame
    /// - Returns: CGRect
    private func getCustomTabBarFrame() -> CGRect {
        return CGRect(
            x: totalHorizontalSpacing / 2,
            y: tabBar.bounds.minY,
            width: Utils.getWidth() - totalHorizontalSpacing,
            height: tabBarHeight
        )
    }
    
    /// Creates shadow frame for tab bar
    /// - Returns: CGRect
    private func getShadowFrame() -> CGRect {
        return CGRect(
            x: 0,
            y: tabBar.bounds.minY,
            width: Utils.getWidth() - totalHorizontalSpacing,
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
