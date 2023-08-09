//
//  BaseViewController.swift
//  House
//
//  Created by Usman Tarar on 24/02/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesLoader
import SmilesUtilities
import SmilesBaseMainRequestManager
import SmilesFontsManager

open class BaseViewController: UIViewController, BaseDataSourceDelegate {
    
    @IBOutlet open weak var view_retry: RetryView!
    @IBOutlet open weak var view_error: NoContentView!
    @IBOutlet open weak var topConstraint: NSLayoutConstraint!
    @IBOutlet open weak var view_holder: UIView!
    
    open var dataSource: BaseTableViewDataSource?
    
    open var shareNavbarButton: UIButton?
    open var backNavbarButton: UIButton?
    open var infoNavbarButton: UIButton?
    open var favouriteNavbarButton: UIButton?
    open var notificationNavbarButton: UIButton?
    
    open var rightSideBarButtons: [NavbarButton]?
    open var leftSideBarButtons: [NavbarButton]?
    
    open var viewResizedForIPhoneX = false
    
    open var notificationBadge: String?
    open var displayNotificationDot: UIView?
    
    open var homeNotificationButton = UIButton()
    let leftSideButtonTag = -85739
    let rightSideButtonTag = -85740
    
    open var currentHeaderMode: SmilesHeaderMode = .withClearHeader
    open var viewHeader: UIView?
    open var viewControllerTitle: String?
    open var viewControllerTitleFont: UIFont?
    open var baseTitleLabel: UILabel?
    open var isFirstTimeLaunch = false
    open var baseLocationButton: UIButton?
    open var showLocations = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Code transferred from SuperViewController
        self.isFirstTimeLaunch = true
        NotificationCenter.default.addObserver(self, selector: #selector(adjustViewContent), name: NSNotification.Name(SharedConstants.menuDidChangeLanguageNotification), object: nil)
        setUpViewContent()

        // Code transferred from MasterViewController
        configureChildViews()
        styleViewUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        //        self.hideHud()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func styleViewUI(){
        // override in child classes
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovingToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovingToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UIApplication.willEnterForegroundNotification.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UIApplication.didEnterBackgroundNotification.rawValue), object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if self.isFirstTimeLaunch {
            AppCommonMethods.adjustSubviewsLanguage(view: self.view, withoutFlipping: AppCommonMethods.languageIsArabic())
            self.isFirstTimeLaunch = false
        }

        if SharedConstants.DeviceType.iPhoneX && !viewResizedForIPhoneX {
            viewResizedForIPhoneX = true
            
            var viewFrame = view_holder?.frame
            if view_holder?.tag == SharedConstants.tagViewResizeOnlyForIPhoneX {
                if !(UIApplication.baseViewController()?.tabBarController?.tabBar.isHidden ?? false) {
                    viewFrame?.size.height -= 0
                } else {
                    viewFrame?.size.height -= 34
                }
            } else if view_holder?.tag == SharedConstants.tagViewShiftOnlyForIPhoneX {
                viewFrame?.origin.y += 24
                viewFrame?.size.height -= 24
            } else if view_holder?.tag == SharedConstants.tagViewShiftOnlyForIPhoneXWithTabbar {
                if !(UIApplication.baseViewController()?.tabBarController?.tabBar.isHidden ?? false) {
                    viewFrame?.size.height -= 0
                } else {
                    viewFrame?.origin.y += 24
                    viewFrame?.size.height -= 58
                }
            } else if view_holder?.tag == SharedConstants.tagViewShiftOnlyForIPhoneXWithModelView {
                if !(UIApplication.baseViewController()?.tabBarController?.tabBar.isHidden ?? false) {
                    viewFrame?.size.height -= 0
                } else {
                    viewFrame?.size.height -= (UIApplication.baseViewController()?.tabBarController?.tabBar.frame.size.height ?? 0.0)
                    UIApplication.shared.pre
                }
            } else if view_holder?.tag == SharedConstants.tagFullViewShiftOnlyForIPhoneX {
                
                if !(UIApplication.baseViewController()?.tabBarController?.tabBar.isHidden ?? false) {
                    viewFrame?.size.height -= 0
                } else {
                    viewFrame?.origin.y += 0
                    viewFrame?.size.height -= 24
                }
            } else {
                if !(UIApplication.baseViewController()?.tabBarController?.tabBar.isHidden ?? false) {
                    viewFrame?.size.height -= 0
                } else {
                    viewFrame?.origin.y += 24
                    viewFrame?.size.height -= 58
                }
            }
            
            view_holder?.frame = viewFrame ?? CGRect()
        }
    }
    
    @objc func appMovingToBackground() {
        print("app did enter background")
        UserDefaults.standard.set(Date(), forKey: "RefreshViewTime")
      }
    
    
    
    @objc func appMovingToForeground() {
        print("app did enter foreground")
        let currentDate = Date()
        let hours   = (Calendar.current.component(.hour, from: currentDate))
        // 3. Show the time
        print("\(hours)")
        
        if let oldTime = UserDefaults.standard.object(forKey: "RefreshViewTime") as? Date{
            print(oldTime)
            
            let diffComponents = Calendar.current.dateComponents([.hour], from: oldTime, to: currentDate)
            let hours = diffComponents.hour
            UserDefaults.standard.removeObject(forKey: "RefreshViewTime")
            
            if let hours = hours, hours >= 3 {
                if let parentnav = (self.navigationController?.presentingViewController as? UINavigationController), self.navigationController?.presentingViewController != nil {
                    self.dismiss(animated: true, completion: {
                        for controller in (parentnav.viewControllers) as Array {
                            if controller.isKind(of: DashboardRevampViewController.self) {
                                parentnav.popToViewController(controller, animated: true)
                                break
                            }
                        }
                    })
                }else{
                    let viewController = self.topmostViewController()
                    
                        if viewController.isModal{
                            dismiss(animated: false, completion: nil)
                        }
                        
                    if let tabbar =  self.tabBarController?.selectedIndex , tabbar != 0{
                            self.tabBarController?.selectedIndex = 0
                        }
                        
                        if (self.isPanModalPresented){
                            self.dismiss(animated: false, completion:nil)
                        }
                        self.navigationController?.popToRootViewController()
                    
                    self.refreshViewWithData()
                }
            }
        }
      }
    
    
    
    // MARK: - data Source
    
    open func setUpTableViewDataSource(dataSource: [BaseRowModel], delegate: BaseDataSourceDelegate?, tableView: UITableView) {
        self.dataSource = BaseTableViewDataSource(dataSource: dataSource, delegate: delegate)
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.reloadData()
    }
    
    open func setUpTableViewSectionsDataSource(dataSource: [BaseSectionModel], delegate: BaseDataSourceDelegate, tableView: UITableView) {
        self.dataSource = BaseTableViewDataSource(dataSourceWithSection: dataSource, delegate: delegate)
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.reloadData()
    }
    
    open func reloadIndividualSectionOfTableViewOnly(dataSource: [BaseSectionModel], delegate: BaseDataSourceDelegate, tableView: UITableView, sectionNumber:Int) {
        self.dataSource?.tableViewSectionItems[sectionNumber] = dataSource[sectionNumber]
        tableView.reloadSections(IndexSet(integersIn: sectionNumber...sectionNumber), with: .none)
    }
    
    open func setUpTableViewDataSourceWithoutscroll(dataSource: [BaseRowModel], delegate: BaseDataSourceDelegate?, tableView: UITableView, offset: CGPoint) {
        self.dataSource = BaseTableViewDataSource(dataSource: dataSource, delegate: delegate)
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
        tableView.layer.removeAllAnimations()
        DispatchQueue.main.async {
            tableView.setContentOffset(offset, animated: false)
        }
    }
    
    
    open func didSelectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath) {
        // override in child classes
        
    }
    
    open func didDeselectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath) {
        // override in child classes
    }
    
    @objc open func scrollViewEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // override in child classes
    }
    
    open func viewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    open func refreshViewWithData(){
        
    }
}

// MARK: - SuperViewController methods
open extension BaseViewController {
    open func setUpViewContent() {
//        UIApplication.delegte().currentPresentedViewController = self
        
        if self.responds(to: #selector(getter: edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = []
            
            switch currentHeaderMode {
            case .withHeader:
                if (SharedConstants.ENABLE_IPHONEX_CHANGES == 1) && (SharedConstants.DeviceType.iPhoneX) {
                    viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 88))
                } else {
                    viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
                }
                
                viewHeader?.autoresizingMask = .flexibleWidth
                viewHeader?.backgroundColor = .appRevampPurpleMainColor
                
                if let viewHeader {
                    self.view.addSubview(viewHeader)
                }
                
            case .withClearHeader:
                if (SharedConstants.ENABLE_IPHONEX_CHANGES == 1) && (SharedConstants.DeviceType.iPhoneX) {
                    viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 88))
                } else {
                    viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
                }
                
                viewHeader?.autoresizingMask = .flexibleWidth
                viewHeader?.theme_backgroundColor = ThemeColorPicker(keyPath: "NavigationBarColor")
                
                if let viewHeader {
                    self.view.addSubview(viewHeader)
                    self.view.bringSubviewToFront(viewHeader)
                }
                
            case .withWhiteBackground:
                if (SharedConstants.ENABLE_IPHONEX_CHANGES == 1) && (SharedConstants.DeviceType.iPhoneX) {
                    viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 88))
                } else {
                    viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
                }
                
                viewHeader?.autoresizingMask = .flexibleWidth
                viewHeader?.theme_backgroundColor = ThemeColorPicker(keyPath: "NavigationBarColor")
                viewHeader?.backgroundColor = .white
                
                if let viewHeader {
                    self.view.addSubview(viewHeader)
                    self.view.bringSubviewToFront(viewHeader)
                }
                
            case .withHeaderAndParallex:
                viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
                viewHeader?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                viewHeader?.theme_backgroundColor = ThemeColorPicker(keyPath: "NavigationBarColor")
                
                let scrollView = UIScrollView(frame: self.view.frame)
                scrollView.parallaxHeader.view = viewHeader
                scrollView.parallaxHeader.height = 64
                scrollView.parallaxHeader.mode = .top
                scrollView.parallaxHeader.minimumHeight = 20
                
            case .withHeaderOverlappingAndParallex:
                viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
                viewHeader?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                viewHeader?.backgroundColor = .appRedColor
                
                let scrollView = UIScrollView(frame: self.view.frame)
                scrollView.parallaxHeader.view = viewHeader
                scrollView.parallaxHeader.height = 64
                scrollView.parallaxHeader.mode = .top
                scrollView.parallaxHeader.minimumHeight = 20
                
            default:
                break
            }
            
            self.setupTitle()
            if showLocations {
                self.setupLocationActions()
            }
        }
    }
    
    open func setupTitle() {
        let viewTitle = UIView(frame: CGRect(x: 50, y: (self.viewHeader?.frame.size.height ?? 0) - 64, width: self.view.frame.size.width - 100, height: 64))
        
        if let viewControllerTitle {
            if baseTitleLabel == nil {
                viewTitle.backgroundColor = .clear
                
                if SharedConstants.DeviceType.iPhoneX {
                    if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                        baseTitleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: viewTitle.frame.size.width, height: 40))
                    } else {
                        baseTitleLabel = UILabel(frame: CGRect(x: 20, y: 26, width: self.view.frame.size.width - 40, height: 40))
                    }
                } else {
                    baseTitleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: viewTitle.frame.size.width, height: 40))
                }
                
                baseTitleLabel?.tag = SharedConstants.baseViewControllerTitleLabelTag
                baseTitleLabel?.fontTextStyle = .smilesTitle1
                baseTitleLabel?.textAlignment = .center
                baseTitleLabel?.textColor = .thm_white()
                baseTitleLabel?.backgroundColor = .clear
                
                let isViewHeaderBackgroundWhite = viewHeader?.backgroundColor?.isEqual(UIColor.white) ?? false
                
                if isViewHeaderBackgroundWhite {
                    baseTitleLabel?.textColor = .appDarkGrayColor
                }
                
                if !AppCommonMethods.languageIsArabic() {
                    let attributedString = NSMutableAttributedString(string: viewControllerTitle.capitalized)
                    attributedString.setAttributes([.foregroundColor: isViewHeaderBackgroundWhite ? UIColor.appDarkGrayColor : UIColor.white, .font: UIFont.TextStyle.smilesTitle1], range: NSMakeRange(0, viewControllerTitle.count))
                    
                    baseTitleLabel?.attributedText = attributedString
                } else {
                    baseTitleLabel?.text = viewControllerTitle.capitalized
                    baseTitleLabel?.textColor = isViewHeaderBackgroundWhite ? UIColor.appDarkGrayColor : UIColor.white
                }
            }
            
            if let baseTitleLabel {
                viewTitle.addSubview(baseTitleLabel)
                viewHeader?.addSubview(viewTitle)
            }
        }
    }
    
    open func setupLocationActions() {
        let locationView = UIView(frame: CGRect(x: ((self.viewHeader?.frame.size.width ?? 0) / 2) - 90, y: (self.viewHeader?.frame.size.height ?? 0) - 64, width: 180, height: 64))
        locationView.backgroundColor = .clear
        
        if SharedConstants.DeviceType.iPhoneX {
            if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                baseLocationButton = UIButton(frame: CGRect(x: 0, y: 20, width: locationView.frame.size.width, height: 44))
            } else {
                baseLocationButton = UIButton(frame: CGRect(x: ((self.viewHeader?.frame.size.width ?? 0) / 2) - 90, y: 26, width: 180, height: 44))
            }
        } else {
            baseLocationButton = UIButton(frame: CGRect(x: 0, y: 20, width: locationView.frame.size.width, height: 44))
        }
        
        baseLocationButton?.setImage(UIImage(named: "location-title-pin"), for: .normal)
        baseLocationButton?.titleLabel?.font = .thm_textStyle1()
        self.setupInsetForButton()
        
        baseLocationButton?.tag = 776
        locationView.removeFromSuperview()
        
        if let baseLocationButton {
            locationView.addSubview(baseLocationButton)
        }
        
        viewHeader?.addSubview(locationView)
    }
    
    open func setupInsetForButton() {
        if !AppCommonMethods.languageIsArabic() {
            baseLocationButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        } else {
            baseLocationButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        }
        
        baseLocationButton?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        baseLocationButton?.addTarget(self, action: #selector(openLocationController), for: .touchUpInside)
    }
    
    open func updateHeader(backgroundColor: UIColor, titleLabelColor: UIColor) {
        self.viewHeader?.backgroundColor = backgroundColor
        self.baseTitleLabel?.textColor = titleLabelColor
    }
    
    open func updateHeaderTitle(fontTextStyle: UIFont.TextStyle, titleLabelColor: UIColor) {
        self.baseTitleLabel?.textColor = titleLabelColor
        self.baseTitleLabel?.fontTextStyle = fontTextStyle
    }
    
    open func setHeaderGradientColor() {
        self.viewHeader?.addGradientColors(UIColor.navigationGradientColorArray(), opacity: 1.0, direction: .diagnolLeftToRight)
    }
    
    open func removeHeaderGradientColor() {
        self.viewHeader?.removeGradientColor()
    }
    
    open func setHeader(withTitle title: String) {
        if !title.isEmpty {
            let isViewHeaderBackgroundWhite = viewHeader?.backgroundColor?.isEqual(UIColor.white) ?? false
            
            if !AppCommonMethods.languageIsArabic() {
                let attributedString = NSMutableAttributedString(string: title.elementsEqual("KFC") ? "KFC" : title.capitalized)
                attributedString.setAttributes([.foregroundColor: isViewHeaderBackgroundWhite ? UIColor.appDarkGrayColor : UIColor.white, .font: UIFont.TextStyle.smilesTitle1], range: NSMakeRange(0, title.count))
                
                (self.viewHeader?.viewWithTag(SharedConstants.baseViewControllerTitleLabelTag) as? UILabel)?.attributedText = attributedString
            } else {
                (self.viewHeader?.viewWithTag(SharedConstants.baseViewControllerTitleLabelTag) as? UILabel)?.text = title.capitalized
                (self.viewHeader?.viewWithTag(SharedConstants.baseViewControllerTitleLabelTag) as? UILabel)?.textColor = isViewHeaderBackgroundWhite ? UIColor.appDarkGrayColor : UIColor.white
                
                if UIApplication.topMostViewController()?.isKind(of: RestaurantDetailRevampViewController.self) ?? false {
                    (self.viewHeader?.viewWithTag(SharedConstants.baseViewControllerTitleLabelTag) as? UILabel)?.transform = CGAffineTransformMakeScale(-1, 1)
                }
            }
        }
    }
    
    open func setHeader(withWhiteTitle title: String) {
        if !title.isEmpty {
            let isViewHeaderBackgroundWhite = viewHeader?.backgroundColor?.isEqual(UIColor.white) ?? false
            
            if !AppCommonMethods.languageIsArabic() {
                let attributedString = NSMutableAttributedString(string: title.elementsEqual("KFC") ? "KFC" : title.capitalized)
                attributedString.setAttributes([.foregroundColor: isViewHeaderBackgroundWhite ? UIColor.white : UIColor.white, .font: UIFont.TextStyle.smilesTitle1], range: NSMakeRange(0, title.count))
                
                (self.viewHeader?.viewWithTag(SharedConstants.baseViewControllerTitleLabelTag) as? UILabel)?.attributedText = attributedString
            } else {
                (self.viewHeader?.viewWithTag(SharedConstants.baseViewControllerTitleLabelTag) as? UILabel)?.text = title.capitalized
                (self.viewHeader?.viewWithTag(SharedConstants.baseViewControllerTitleLabelTag) as? UILabel)?.textColor = isViewHeaderBackgroundWhite ? UIColor.white : UIColor.white
            }
        }
    }
    
    @objc open func openLocationController() {
        
    }
    
    open func setIsFirstTime() {
        self.isFirstTimeLaunch = false
    }
    
    @objc open func adjustViewContent() {
        AppCommonMethods.adjustSubviewsLanguage(view: self.view, withoutFlipping: true)
    }
}

// MARK: - MasterViewController methods

open extension BaseViewController {
    @objc open func menuButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc open func backButtonTapped(_ sender: UIButton) {
        if let navigationController {
            navigationController.popViewController()
        } else {
            dismiss()
        }
    }
    
    @objc open func shareBarButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc open func favouriteButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc open func playAndWinButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc open func nearByButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc open func notificationButtonTapped(_ sender: UIButton) {
        if let notificationVC = CommonMethods.getViewController(fromStoryboardName: "Notifications", andIdentifier: "NotificationInboxViewController") as? NotificationInboxViewController {
            
            notificationVC.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(viewController: notificationVC)
        }
        
    }
    
    @objc open func applyButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc open func searchButtonTapAction(_ sender: UIButton) {
        let globalSearchVC = GlobalSearchRouter.setupModule()
        globalSearchVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController: globalSearchVC)
    }
    
    @objc open func infoButtonTapped() {
        
    }
    
    @objc open func configureChildViews() {
        self.notificationBadge = "no_notification"
        self.displayNotificationDot?.isHidden = true
        
        if (rightSideBarButtons?.count ?? 0) > 0 {
            self.setRightSideBarButtons()
        }
        
        if (leftSideBarButtons?.count ?? 0) > 0 {
            self.setLeftSideBarButtons()
        }
        
        self.updateButtons()
        
//        UIApplication.delegte().currentPresentedViewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveNotification), name: NSNotification.Name("didGetNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchUnreadNotificationCount), name: NSNotification.Name("NotificationCounter"), object: nil)
    }
    
    @objc open func updateButtons() {
        if !AppCommonMethods.languageIsArabic() {
            self.view.subviews.forEach { subview in
                if let button = subview as? UIButton {
                    if (button.accessibilityHint?.count ?? 0) > 0 {
                        if let accessibilityHint = button.accessibilityHint?.localizedString {
                            button.setAttributedTitle(CommonMethods.styleText(withSpacesLetter: accessibilityHint, space: 1.9, font: .thm_textStyle3(), color: .white), for: .normal)
                        }
                    }
                }
            }
        }
    }
    
    @objc open func configureNavigationBar(withTitle title: String?, rightButtons: [String]) {
        self.viewControllerTitle = title ?? ""
        self.currentHeaderMode = .withHeader
        self.leftSideBarButtons = [.backButton]
        self.rightSideBarButtons = rightButtons.map { NavbarButton(rawValue: $0) ?? .empty }
    }
    
    @objc open func configureNavigationBar(withTitle title: String?, rightButtons: [String], leftButtons: [String]) {
        self.viewControllerTitle = title ?? ""
        self.currentHeaderMode = .withHeader
        self.leftSideBarButtons = leftButtons.map { NavbarButton(rawValue: $0) ?? .empty }
        self.rightSideBarButtons = rightButtons.map { NavbarButton(rawValue: $0) ?? .empty }
    }
    
    @objc open func configureNavigationBar(withTitle title: String?, backButtonImg: String?, clearHeader: Bool, rightSideButtons: [String]) {
        self.viewControllerTitle = title ?? ""
        self.currentHeaderMode = clearHeader ? .withClearHeader : .withHeader
        if backButtonImg?.elementsEqual("noBackNeeded") ?? false {
            self.backNavbarButton?.backgroundColor = .white
        } else {
            self.leftSideBarButtons = [.backButton]
        }
        self.rightSideBarButtons = rightSideButtons.map { NavbarButton(rawValue: $0) ?? .empty }
        self.backNavbarButton?.setImage(UIImage(named: backButtonImg ?? ""), for: .normal)
    }
    
    @objc open func setRightSideBarButtons() {
        if let view = self.viewHeader?.viewWithTag(rightSideButtonTag) {
            view.removeFromSuperview()
        }
        
        let rightSideButtonsView = UIView(frame: CGRect(x: self.view.frame.size.width - 100, y: (self.viewHeader?.frame.size.height ?? 0) - 64, width: 100, height: 64))
        rightSideButtonsView.tag = rightSideButtonTag
        
        let currentX = rightSideButtonsView.frame.size.width - 40
        
        if self.rightSideBarButtons?[0] == .shareBarButton {
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    self.shareNavbarButton = UIButton(frame: CGRect(x: currentX - 30, y: 15, width: 70, height: 50))
                } else {
                    self.shareNavbarButton = UIButton(frame: CGRect(x: currentX - 30, y: 20, width: 70, height: 50))
                }
            } else {
                self.shareNavbarButton = UIButton(frame: CGRect(x: currentX - 30, y: 15, width: 70, height: 50))
            }
            
            let icon = self.rightSideBarButtons?[0].rawValue ?? ""
            self.shareNavbarButton?.setImage(UIImage(named: icon), for: .normal)
            self.shareNavbarButton?.addTarget(self, action: #selector(shareBarButtonTapped), for: .touchUpInside)
            if let shareNavbarButton {
                rightSideButtonsView.addSubview(shareNavbarButton)
            }
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if self.rightSideBarButtons?[0] == .notificationButton || self.rightSideBarButtons?[0] == .notificationButtonBlack {
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    self.notificationNavbarButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
                } else {
                    self.notificationNavbarButton = UIButton(frame: CGRect(x: currentX, y: 33, width: 25, height: 25))
                }
            } else {
                self.notificationNavbarButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
            }
            
            let icon = self.rightSideBarButtons?[0].rawValue ?? ""
            self.notificationNavbarButton?.setImage(UIImage(named: icon), for: .normal)
            self.notificationNavbarButton?.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
            if let notificationNavbarButton {
                rightSideButtonsView.addSubview(notificationNavbarButton)
            }
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if self.rightSideBarButtons?[0] == .closeButton {
            var closeButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    closeButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
                } else {
                    closeButton = UIButton(frame: CGRect(x: currentX - 10, y: 30, width: 50, height: 44))
                }
            } else {
                closeButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
            }
            
            closeButton.setImage(UIImage(named: "menuCloseButton"), for: .normal)
            closeButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            rightSideButtonsView.addSubview(closeButton)
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if self.rightSideBarButtons?[0] == .nearByButton {
            var nearByButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    nearByButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
                } else {
                    nearByButton = UIButton(frame: CGRect(x: currentX, y: 33, width: 25, height: 25))
                }
            } else {
                nearByButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
            }
            
            nearByButton.setImage(UIImage(named: "locationTopIcon"), for: .normal)
            nearByButton.addTarget(self, action: #selector(nearByButtonTapped), for: .touchUpInside)
            rightSideButtonsView.addSubview(nearByButton)
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if self.rightSideBarButtons?[0] == .applyButton {
            // Updata apply button with in arabic language.
            var xValue = 20.0
            var wValue = 50.0
            
            if AppCommonMethods.languageIsArabic() {
                xValue = 55.0
                wValue = 85.0
            }
            
            var applyButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    applyButton = UIButton(frame: CGRect(x: currentX - xValue, y: 28, width: wValue, height: 25))
                } else {
                    applyButton = UIButton(frame: CGRect(x: currentX - xValue, y: 33, width: wValue, height: 25))
                }
            } else {
                applyButton = UIButton(frame: CGRect(x: currentX - xValue, y: 28, width: wValue, height: 25))
            }
            
            applyButton.setTitle("ApplyTitle".localizedString, for: .normal)
            applyButton.titleLabel?.font = .thm_textStyle3()
            applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
            rightSideButtonsView.addSubview(applyButton)
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if self.rightSideBarButtons?[0] == .searchButton || self.rightSideBarButtons?[0] == .searchButtonBlack {
            var searchButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    searchButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
                } else {
                    searchButton = UIButton(frame: CGRect(x: currentX, y: 33, width: 25, height: 25))
                }
            } else {
                searchButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
            }
            
            let icon = self.rightSideBarButtons?[0].rawValue ?? ""
            searchButton.setImage(UIImage(named: icon), for: .normal)
            searchButton.addTarget(self, action: #selector(searchButtonTapAction), for: .touchUpInside)
            rightSideButtonsView.addSubview(searchButton)
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if self.rightSideBarButtons?[0] == .playAndWinButton {
            var playAndWinButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    playAndWinButton = UIButton(frame: CGRect(x: currentX - 5, y: 25, width: 30, height: 30))
                } else {
                    playAndWinButton = UIButton(frame: CGRect(x: currentX - 5, y: 30, width: 30, height: 30))
                }
            } else {
                playAndWinButton = UIButton(frame: CGRect(x: currentX - 5, y: 25, width: 30, height: 30))
            }
            
            playAndWinButton.setImage(UIImage(named: "PlayWin"), for: .normal)
            playAndWinButton.addTarget(self, action: #selector(playAndWinButtonTapped), for: .touchUpInside)
            rightSideButtonsView.addSubview(playAndWinButton)
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if self.rightSideBarButtons?[0] == .infoBarButton {
            var infoBarButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    infoBarButton = UIButton(frame: CGRect(x: currentX - 30, y: 15, width: 70, height: 60))
                } else {
                    infoBarButton = UIButton(frame: CGRect(x: currentX - 30, y: 20, width: 70, height: 60))
                }
            } else {
                infoBarButton = UIButton(frame: CGRect(x: currentX - 30, y: 15, width: 70, height: 60))
            }
            
            infoBarButton.setImage(UIImage(named: "detail_info"), for: .normal)
            infoBarButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
            rightSideButtonsView.addSubview(infoBarButton)
            self.viewHeader?.addSubview(rightSideButtonsView)
        }
        
        if (self.rightSideBarButtons?.count ?? 0) > 1 {
            if self.rightSideBarButtons?[1] == .searchButton || self.rightSideBarButtons?[1] == .searchButtonBlack {
                let currentXX = rightSideButtonsView.frame.size.width - 80
                
                var searchButton = UIButton()
                
                if SharedConstants.DeviceType.iPhoneX {
                    if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                        searchButton = UIButton(frame: CGRect(x: currentXX, y: 28, width: 25, height: 25))
                    } else {
                        searchButton = UIButton(frame: CGRect(x: currentXX, y: 33, width: 25, height: 25))
                    }
                } else {
                    searchButton = UIButton(frame: CGRect(x: currentXX, y: 28, width: 25, height: 25))
                }
                
                let icon = self.rightSideBarButtons?[1].rawValue ?? ""
                searchButton.setImage(UIImage(named: icon), for: .normal)
                searchButton.addTarget(self, action: #selector(searchButtonTapAction), for: .touchUpInside)
                rightSideButtonsView.addSubview(searchButton)
                self.viewHeader?.addSubview(rightSideButtonsView)
            }
            
            if self.rightSideBarButtons?[1] == .favouriteBarButton {
                let currentXX = rightSideButtonsView.frame.size.width - 80
                
                if SharedConstants.DeviceType.iPhoneX {
                    if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                        self.favouriteNavbarButton = UIButton(frame: CGRect(x: currentXX - 35, y: 11, width: 70, height: 60))
                    } else {
                        self.favouriteNavbarButton = UIButton(frame: CGRect(x: currentXX - 35, y: 16, width: 70, height: 60))
                    }
                } else {
                    self.favouriteNavbarButton = UIButton(frame: CGRect(x: currentXX - 35, y: 11, width: 70, height: 60))
                }
                
                let icon = self.rightSideBarButtons?[1].rawValue ?? ""
                self.favouriteNavbarButton?.setImage(UIImage(named: icon), for: .normal)
                self.favouriteNavbarButton?.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
                if let favouriteNavbarButton {
                    rightSideButtonsView.addSubview(favouriteNavbarButton)
                }
                self.viewHeader?.addSubview(rightSideButtonsView)
            }
            
            if self.rightSideBarButtons?[1] == .infoBarButton {
                let currentXX = rightSideButtonsView.frame.size.width - 80
                
                if SharedConstants.DeviceType.iPhoneX {
                    if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                        self.infoNavbarButton = UIButton(frame: CGRect(x: currentXX - 35, y: 11, width: 70, height: 60))
                    } else {
                        self.infoNavbarButton = UIButton(frame: CGRect(x: currentXX - 35, y: 16, width: 70, height: 60))
                    }
                } else {
                    self.infoNavbarButton = UIButton(frame: CGRect(x: currentXX - 35, y: 11, width: 70, height: 60))
                }
                
                self.infoNavbarButton?.setImage(UIImage(named: "detail_info"), for: .normal)
                self.infoNavbarButton?.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
                if let infoNavbarButton {
                    rightSideButtonsView.addSubview(infoNavbarButton)
                }
                self.viewHeader?.addSubview(rightSideButtonsView)
            }
        }
    }
    
    @objc open func setLeftSideBarButtons() {
        if let view = self.viewHeader?.viewWithTag(leftSideButtonTag) {
            view.removeFromSuperview()
        }
        
        let leftSideButtonsView = UIView(frame: CGRect(x: 0, y: (self.viewHeader?.frame.size.height ?? 0) - 64, width: 50, height: 64))
        leftSideButtonsView.backgroundColor = .clear
        leftSideButtonsView.tag = leftSideButtonTag
        
        let currentX = 16
        
        if self.leftSideBarButtons?[0] == .menuButton {
            var menuButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    menuButton = UIButton(frame: CGRect(x: currentX - 10, y: 20, width: 50, height: 44))
                } else {
                    menuButton = UIButton(frame: CGRect(x: currentX - 10, y: 26, width: 50, height: 44))
                }
            } else {
                menuButton = UIButton(frame: CGRect(x: currentX - 10, y: 20, width: 50, height: 44))
            }
            
            menuButton.setImage(UIImage(named: "Menu"), for: .normal)
            menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
            leftSideButtonsView.addSubview(menuButton)
        } else if self.leftSideBarButtons?[0] == .backButton {
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    self.backNavbarButton = UIButton(frame: CGRect(x: currentX, y: 20, width: 36, height: 36))
                } else {
                    self.backNavbarButton = UIButton(frame: CGRect(x: currentX, y: 26, width: 36, height: 36))
                }
            } else {
                self.backNavbarButton = UIButton(frame: CGRect(x: currentX, y: 22, width: 36, height: 36))
            }
            
            if AppCommonMethods.languageIsArabic() {
                self.backNavbarButton?.setImage(UIImage(named: "backIcon_Ar"), for: .normal)
            } else {
                self.backNavbarButton?.setImage(UIImage(named: "backIcon"), for: .normal)
            }

            if self.viewHeader?.backgroundColor?.isEqual(UIColor.white) ?? false {
                if AppCommonMethods.languageIsArabic() {
                    self.backNavbarButton?.setImage(UIImage(named: "BackArrow_black_Ar"), for: .normal)
                } else {
                    self.backNavbarButton?.setImage(UIImage(named: "BackArrow_black"), for: .normal)
                }
                
            }
            
            self.backNavbarButton?.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            
            if UIApplication.topMostViewController()?.isKind(of: RestaurantDetailRevampViewController.self) ?? false {
                if AppCommonMethods.languageIsArabic() {
                    self.backNavbarButton?.imageView?.transform = CGAffineTransformMakeScale(-1, 1)
                } else {
                    self.backNavbarButton?.imageView?.transform = .identity
                }
            }
            
            if let backNavbarButton {
                leftSideButtonsView.addSubview(backNavbarButton)
            }
        } else if self.leftSideBarButtons?[0] == .closeButton {
            var closeButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    closeButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
                } else {
                    closeButton = UIButton(frame: CGRect(x: currentX - 10, y: 30, width: 50, height: 44))
                }
            } else {
                closeButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 25, height: 25))
            }
            
            closeButton.setImage(UIImage(named: "menuCloseButton"), for: .normal)
            closeButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            leftSideButtonsView.addSubview(closeButton)
        } else {
            var leftButton = UIButton()
            
            if SharedConstants.DeviceType.iPhoneX {
                if SharedConstants.ENABLE_IPHONEX_CHANGES == 1 {
                    leftButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 45, height: 45))
                } else {
                    leftButton = UIButton(frame: CGRect(x: currentX - 10, y: 30, width: 50, height: 45))
                }
            } else {
                leftButton = UIButton(frame: CGRect(x: currentX, y: 28, width: 45, height: 45))
            }
            
            leftButton.contentMode = .scaleAspectFill
            leftButton.setImage(UIImage(named: self.leftSideBarButtons?[0].rawValue ?? ""), for: .normal)
            leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            leftSideButtonsView.addSubview(leftButton)
        }
        
        self.viewHeader?.addSubview(leftSideButtonsView)
    }
    
    @objc open func registerEventWebService(with eventType: Int, shareType: Int, additionalInfo: [Any]?) {
        let event = EventTypeSwift(rawValue: eventType)
        let _ = ShareTypeSwift(rawValue: shareType)
        
        if getUserProfileResponse.sharedClient().onAppStartObjectResponse?.isGamificationEnabled == "true" {
            let registerEventRequest = registerEventRequest(dictionary: SmilesBaseMainRequestManager.shared.getConfigsAsDictionary())
            registerEventRequest?.eventType = Double(eventType)
            registerEventRequest?.additionalInfo = additionalInfo
            
            GamificationLogic.registerEvents(with: registerEventRequest) { [weak self] statusResponse in
                if statusResponse?.status == 204 {
                    if event == .PUZZLE_PIECE_SHARE_EVENT {
                        if let sharingText = SharingDetails.sharedClient().sharingText, SharingDetails.sharedClient().shareFrom == Double(EventTypeSwift.PUZZLE_PIECE_SHARE_EVENT.rawValue) {
                            
                            self?.navigationController?.popViewController()
                            DispatchQueue.main.async {
                                self?.showShareResultPopup(bonus: sharingText)
                            }
                        }
                    }
                } else {
                    if event == .PUZZLE_PIECE_SHARE_EVENT {
                        if SharingDetails.sharedClient().shareFrom == Double(EventTypeSwift.PUZZLE_PIECE_SHARE_EVENT.rawValue) {
                            self?.navigationController?.popViewController()
                            
                            DispatchQueue.main.async {
                                self?.showShareResultPopup(bonus: nil)
                            }
                        }
                    }
                }
                
                if event == .BADGE_EVENT || event == .PUZZLE_SHARE_EVENT || event == .VIEW_SPEICAL_RAFFLE_EVENT {
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController()
                    }
                }
            } failureBlock: { error, message in
                if (event == .BADGE_EVENT || event == .PUZZLE_SHARE_EVENT) || (event == .VIEW_SPEICAL_RAFFLE_EVENT || event == .PUZZLE_PIECE_SHARE_EVENT) {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController()
                    }
                }
            }
        }
    }
    
    @objc open func showShareResultPopup(bonus: String?) {
        if let gamificationShareResultViewController = CommonMethods.getViewController(fromStoryboardName: "Gamification", andIdentifier: "GamificationShareResultViewController") as? GamificationShareResultViewController {
            
            gamificationShareResultViewController.bonusPoint = bonus ?? nil
            gamificationShareResultViewController.modalPresentationStyle = .overCurrentContext
            UIApplication.baseViewController()?.tabBarController?.present(gamificationShareResultViewController, animated: true)
        }
    }
    
    @objc open func deleteLocalNotification(objectId: String?, type: String) {
        if type.lowercased().elementsEqual("offer") {
//            CommonMethods.fireEvent(withName: SharedConstants.cancelledNotification, parameters: [:])
        } else if type.lowercased().elementsEqual("recharge") {
//            CommonMethods.fireEvent(withName: SharedConstants.cancelledNotificationRecharge, parameters: [:])
        } else {
//            CommonMethods.fireEvent(withName: SharedConstants.cancelledNotificationRecharge, parameters: [:])
        }
        
//        UIApplication.delegte().notificationCenter = UNUserNotificationCenter.current()
        
        if let objectId = objectId {
//            UIApplication.delegte().notificationCenter?.removePendingNotificationRequests(withIdentifiers: [objectId])
        }
    }
    
    @objc open func configureViewContent() {
        AppCommonMethods.adjustSubviewsLanguage(view: self.view, withoutFlipping: true)
    }
    
    @objc open func fetchUnreadNotificationCount() {
        if let notificationBadge = CommonMethods.loadCustomObject(withKey: SharedConstants.notificationBadge) as? String, !notificationBadge.isEmpty {
            notificationNavbarButton?.setImage(UIImage(named: "Notification"), for: .normal)
            homeNotificationButton.setImage(UIImage(named: "Notification"), for: .normal)
            self.displayNotificationDot?.isHidden = false
        } else {
            let applicationBadgeNumber = UIApplication.shared.applicationIconBadgeNumber
            if applicationBadgeNumber >= 1 {
                //This is when app is closed and app revieved a notification
                self.notificationNavbarButton?.setImage(UIImage(named: "Notification"), for: .normal)
                self.homeNotificationButton.setImage(UIImage(named: "Notification"), for: .normal)
                self.displayNotificationDot?.isHidden = false
            } else {
                if let rightSideBarButtons, rightSideBarButtons.count > 0 {
                    let rightSideButtonIcon = rightSideBarButtons[0].rawValue
                    
                    if rightSideButtonIcon.elementsEqual(NavbarButton.notificationButton.rawValue) || rightSideButtonIcon.elementsEqual(NavbarButton.notificationButtonBlack.rawValue) {
                        self.notificationNavbarButton?.setImage(UIImage(named: rightSideButtonIcon), for: .normal)
                    } else {
                        self.notificationNavbarButton?.setImage(UIImage(named: "no_notification-old"), for: .normal)
                    }
                }
            }
            
            self.homeNotificationButton.setImage(UIImage(named: "no_notification"), for: .normal)
            self.displayNotificationDot?.isHidden = true
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
    
    @objc open func didReceiveNotification(notification: Notification) {
        if let notification = notification.object as? [String: Any], !notification.isEmpty {
            CommonMethods.fireEvent(withName: SharedConstants.pushNotificationOpened, parameters: [:])
            
            if let msisdn = CommonMethods.loadCustomObject(withKey: SharedConstants.MSISDN_NUMBER) as? String, !msisdn.isEmpty {
                let payload = NotificationPayloadResponse(dictionary: notification)
                payload?.deeplinkSource = "notification"
                
                CommonMethods.fireEvent(withName: "notification_opened", parameters: [:])
                CommonMethods.fireEvent(withName: String(format: "notification_opened_%d", payload?.notificationType ?? 0), parameters: [:])
                
                appICE.sharedInstance().updateInboxMessage(4, payload?.mId ?? "")
                UIApplication.shared.applicationIconBadgeNumber = 0
                self.fetchUnreadNotificationCount()
                
                let windows = UIApplication.shared.windows
                var keyWindow: UIWindow? = nil
                
                for window in windows {
                    if window.isKeyWindow {
                        keyWindow = window
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    let baseVC = keyWindow?.rootViewController
                    baseVC?.dismiss()
                }
                
                if let navController = UIApplication.getTopViewController() as? UINavigationController {
                    NotificationRedirections.performNavigationBased(onType: payload, with: navController, appWasClosed: false, redirectedFrom: RedirectionType.notification)
                } else {
                    NotificationRedirections.performNavigationBased(onType: payload, with: UIApplication.getTopViewController()?.navigationController, appWasClosed: false, redirectedFrom: RedirectionType.notification)
                }
            }
        } else if let notification = notification.object as? String, !notification.isEmpty {
            if let msisdn = CommonMethods.loadCustomObject(withKey: SharedConstants.MSISDN_NUMBER) as? String, !msisdn.isEmpty {
                
                CommonMethods.removeCustomObject(withKey: "mocaLink")
                
                if let navController = UIApplication.getTopViewController() as? UINavigationController {
                    HouseConfig.handleBannerDeepLinkRedirections(notification, with: navController, additionalInfo: nil)
                } else {
                    HouseConfig.handleBannerDeepLinkRedirections(notification, with: UIApplication.getTopViewController()?.navigationController, additionalInfo: nil)
                }
            }
        }
    }
}

// MARK: - Protocol Loadable

protocol Loadable: AnyObject {
    func showHud()
    func hideHud()
}

extension BaseViewController: Loadable {
    func showHud() {
        SmilesLoader.show(with: "LoadingTitle".localizedString)
    }
    
    func hideHud() {
        SmilesLoader.dismiss()
    }
}



extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}
