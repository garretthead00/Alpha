//
//  WalkthroughPageController.swift
//  Alpha
//
//  Created by Garrett Head on 9/22/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The WalkthroughPageController is the main controller of Walkthrough module. This controller manages the scenes (pages)
// within the walkthrough process.
//
// The controller consists of an embedded UIPageViewController, which displays the different scenes, and a UIPageControl
// to display the current page within the list of pages in the Walkthrough.
//
// The UIPageViewContoller has an embedded NUINavigationBar with two UIBarButtomItems (left and right) for "prev" and "next" actions.
// These actions control the navigation through the pages of the Walkthrough.
//
// All model data is manage by this controller. Once the walkthrough is completed, the data is recorded in the database and
// the user is transferred to the main view of the application.
//

import UIKit


// MARK: - Walkthrough Delegate
protocol WalkthroughDelegate {
    func setFirstName(firstName: String)
    func setLastName(lastName: String)
    func setDoB(dob: Date)
    func setBiologicalSex(sex: String)
    func setBodyType(bodyType: String)
    func setActivityLevel(activityLevel: String)
    func setUnits(units : PreferredUnits)
    func setTeamColor(color : UIColor)
    func saveBio()
}

class WalkthroughController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    // MARK: - Controller Variables
    var pageContainer: UIPageViewController!
    var currentIndex: Int?
    private var pendingIndex: Int?
    lazy var controllers : [UIViewController] = {
        let sb = UIStoryboard(name: "Walkthrough", bundle: nil)
        let vc1 = sb.instantiateViewController(identifier: "WalkthroughIntroController")
        let vc2 = sb.instantiateViewController(identifier: "WalkthroughIntroController")
        let vc3 = sb.instantiateViewController(identifier: "WalkthroughIntroController")
        let vc4 = sb.instantiateViewController(identifier: "WalkthroughIntroController")
        let vc5 = sb.instantiateViewController(identifier: "WalkthroughBioController")
        let vc6 = sb.instantiateViewController(identifier: "WalkthroughBodyTypeController")
        let vc7 = sb.instantiateViewController(identifier: "WalkthroughActivityLevelController")
        let vc8 = sb.instantiateViewController(identifier: "WalkthroughUnitsController")
        let vc9 = sb.instantiateViewController(identifier: "WalkthroughTeamColorController")
        let vc10 = sb.instantiateViewController(identifier: "WalkthroughFinaleController")
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8, vc9, vc10]
    }()
    var images : [String] = ["alphaKnife", "Fitness","Nutrition", "Hydration"]
    var titles : [String] = ["Alpha", "Fitness", "Nutrition", "Hydration"]
    var captions : [String] = [
        "The swiss army knife for health and wellness.\n\nAlpha is a social fitness application that provides users with the tools needed to lived a healthy life and be just a little bit better every day.",
        "Create custom workouts and exercises.\nShare them with others.\n\nTrack your progress.\n\nGet Moving!",
        "Create a Meal Plan.\n\nSet nutrition goals and track your progress.\n\nFind foods and nutrition facts shared by others.",
        "Hydration is key for a healthy life.\n\nSet a hydration goal and stay on track.\n\nStay hydrated!"
    ]
    
    // MARK: - Bio, Units & TeamColor
    var bio : Bio = Bio()
    var preferredUnits : PreferredUnits = PreferredUnits()
    var teamColor : UIColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the page container.
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        //pageContainer.isPagingEnabled = false
        
        // Set the initial page.
        if let firstController = viewControllerAtIndex(index: 0) {
            pageContainer.setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        }

        // Add the page container to the WalkthroughController view.
        view.addSubview(pageContainer.view)
        
        // Bring the page control items to the front of the view.
        // Configure and set the initial parameters.
        view.bringSubviewToFront(pageControl)
        view.bringSubviewToFront(navBar)
        pageControl.numberOfPages = controllers.count
        pageControl.currentPage = 0
        currentIndex = pageControl.currentPage
        
        updateView()
    }
    
    private func updateView(){
        // Prepare the navigation bar.
        // "prev" button is hidden on the first page.
        // "next" button is hidden on the last page.
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.backgroundColor = .clear
        let prevBtn = UIBarButtonItem(title: "prev", style: .plain, target: nil, action: #selector(prevPage))
        let nextBtn = UIBarButtonItem(title: "next", style: .plain, target: nil, action: #selector(nextPage))
        navItem.leftBarButtonItem = pageControl.currentPage > 0 ? prevBtn : nil
        navItem.rightBarButtonItem = (pageControl.currentPage < controllers.count - 1) ? nextBtn : nil
    }
    
    // MARK: Actions
    
    // Prev action triggered when the "Prev" button on the NavBar is selected.
    @objc func prevPage(){
        guard let currentViewController = self.pageContainer.viewControllers?.first else { return }
        guard let previousViewController = self.pageContainer.dataSource?.pageViewController( self.pageContainer, viewControllerBefore: currentViewController ) else { return }
        let prevIndex = self.pageControl.currentPage - 1
        if prevIndex >= 0 {
            self.pageContainer.setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
            self.pageControl.currentPage = prevIndex
            updateView()
        }
    }
    
    // Next action triggered when the "Next" button on the NavBar is selected.
    @objc func nextPage(){
        guard let currentViewController = self.pageContainer.viewControllers?.first else { return }
        guard let nextViewController = self.pageContainer.dataSource?.pageViewController( self.pageContainer, viewControllerAfter: currentViewController ) else { return }
        let nextIndex = self.pageControl.currentPage + 1
        if  nextIndex < self.controllers.count {
            self.pageContainer.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            self.pageControl.currentPage = nextIndex
            updateView()
        }
    }
    
    // Sets the current view based on the index parameter.
    private func viewControllerAtIndex(index: Int) -> UIViewController? {
        
        if index < 0 || index >= controllers.count {
            return nil
        }
        
        if let introVC = controllers[index] as? WalkthroughIntroController {
            introVC.introImage = images[index]
            introVC.introTitle = titles[index]
            introVC.introCaption = captions[index]
            introVC.index = index
            return introVC
        }
        if let bioVC = controllers[index] as? WalkthroughBioController {
            bioVC.delegate = self
            return bioVC
        }
        if let bodyTypeVC = controllers[index] as? WalkthroughBodyTypeController {
            bodyTypeVC.delegate = self
            return bodyTypeVC
        }
        if let activityLevelVC = controllers[index] as? WalkthroughActivityLevelController {
            activityLevelVC.delegate = self
            return activityLevelVC
        }
        if let unitsVC = controllers[index] as? WalkthroughUnitsController {
            unitsVC.delegate = self
            unitsVC.preferredUnits = self.preferredUnits
            return unitsVC
        }
        if let colorVC = controllers[index] as? WalkthroughTeamColorController {
            colorVC.teamColorSelected = self.teamColor
            colorVC.delegate = self
            return colorVC
        }
        if let finaleVC = controllers[index] as? WalkthroughFinaleController {
            finaleVC.delegate = self
            return finaleVC
        }
        return nil
        
    }


}


// MARK: - UIPageViewControllerDelegate and UIPageViewControllerDataSource
extension WalkthroughController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        let prev = index - 1
        guard prev >= 0 else { return nil }
        guard controllers.count > prev else { return nil }
        return viewControllerAtIndex(index: prev)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        let next = index + 1
        guard controllers.count > next else { return nil }
        guard controllers.count != next else { return nil }
        return viewControllerAtIndex(index: next)
    }

    
    // MARK: - Pagination Functions
    // The functions below are used when the UIPageViewController.isPagingEnabled = true.
    // This attribute is default set to false in the viewDidLoad function of the WalkthroughController, by design.
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = controllers.firstIndex(of: pendingViewControllers.first!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
                updateView()
            }
        }
        
    }
}


// MARK: - WalkthroughDelegate
extension WalkthroughController : WalkthroughDelegate {
    
    func setFirstName(firstName: String) {
        bio.firstName = firstName
    }
    func setLastName(lastName: String) {
        bio.lastName = lastName
    }
    func setDoB(dob: Date) {
        bio.dateOfBirth = dob.timeIntervalSince1970
    }
    func setBiologicalSex(sex: String) {
        bio.biologicalSex = sex
    }
    func setBodyType(bodyType: String) {
        bio.bodyType = bodyType
    }
    func setActivityLevel(activityLevel: String) {
        bio.activityLevel = activityLevel
    }
    func setUnits(units: PreferredUnits) {
        preferredUnits = units
    }
    func setTeamColor(color: UIColor) {
        self.teamColor = color
    }
    func saveBio() {
        // save bio
        let firstName = bio.firstName != nil ? bio.firstName!.trimmingCharacters(in: .whitespacesAndNewlines) : ""
        let lastName = bio.lastName != nil ? bio.lastName!.trimmingCharacters(in: .whitespacesAndNewlines) : ""
        let dob = bio.dateOfBirth != nil ? bio.dateOfBirth! : Date().timeIntervalSince1970
        let sex = bio.biologicalSex != nil ? bio.biologicalSex! : biologicalSexes[0]
        let bodyType = bio.bodyType != nil ? bio.bodyType! : bodyTypes[0]
        let activityLevel = bio.activityLevel != nil ? bio.activityLevel! : activityLevels[0]
        API.Bio.updateBio(firstName: firstName,
                          lastName: lastName,
                          dateOfBirth: dob,
                          biologicalSex: sex,
                          bodyType: bodyType,
                          activityLevel: activityLevel)
        
        // save preferred units
        API.PreferredUnits.updatePreferredUnits(units: preferredUnits)
        
        // save team color
        let defaults = UserDefaults.standard
        defaults.setColor(color: self.teamColor, forKey: "teamColor")
        
        // set the default user targets.
        API.UserTarget.initializeUserTargets()
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}


