//
//  MMDrawerController.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/31.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore



/**
 `MMDrawerController` is a side drawer navigation container view controller designed to support the growing number of applications that leverage the side drawer paradigm. This library is designed to exclusively support side drawer navigation in light-weight, focused approach.
 
 ## Creating a MMDrawerController
 `MMDrawerController` is a container view controller, similiar to `UINavigationController` or `UITabBarController`, with up to three child view controllers - Center, LeftDrawer, and RightDrawer. To create a `MMDrawerController`, you must first instantiate the drawer view controllers and the initial center controller, then call one of the init methods listed in this class.
 
 ## Handling a UINavigationController as the centerViewController
 `MMDrawerController` automatically supports handling a `UINavigationController` as the `centerViewController`, and will correctly handle the proper gestures on each view (the navigation bar view as well as the content view for the visible view controller). Note that while this library does support other container view controllers, the open/close gestures are not customized to support them.
 
 ## Accessing MMDrawerController from the Child View Controller
 You can leverage the category class (UIViewController+MMDrawerController) included with this library to access information about the parent `MMDrawerController`. Note that if you are contained within a UINavigationController, the `drawerContainerViewController` will still return the proper reference to the `drawerContainerViewController` parent, even though it is not the direct parent. Refer to the documentation included with the category for more information.
 
 ## How MMDrawerOpenCenterInteractionMode is handled
 `MMDrawerOpenCenterInteractionMode` controls how the user should be able to interact with the center view controller when either drawer is open. By default, this is set to `MMDrawerOpenCenterInteractionModeNavigationBarOnly`, which allows the user to interact with UINavigationBarItems while either drawer is open (typicaly used to click the menu button to close). If you set the interaction mode to `MMDrawerOpenCenterInteractionModeNone`, no items within the center view will be able to be interacted with while a drawer is open. Note that this setting has no effect at all on the `MMCloseDrawerGestureMode`.
 
 ## How Open/Close Gestures are handled
 Two gestures are added to every instance of a drawer controller, one for pan and one for touch. `MMDrawerController` is the delegate for each of the gesture recoginzers, and determines if a touch should be sent to the appropriate gesture when a touch is detected compared with the masks set for open and close gestures and the state of the drawer controller.
 
 ## Integrating with State Restoration
 In order to opt in to state restoration for `MMDrawerController`, you must set the `restorationIdentifier` of your drawer controller. Instances of your centerViewController, leftDrawerViewController and rightDrawerViewController must also be configured with their own `restorationIdentifier` (and optionally a restorationClass) if you intend for those to be restored as well. If your MMDrawerController had an open drawer when your app was sent to the background, that state will also be restored.
 
 ## What this library doesn't do.
 This library is not meant for:
 - Top or bottom drawer views
 - Displaying both drawers at one time
 - Displaying a minimum drawer width
 - Support container view controllers other than `UINavigationController` as the center view controller.
 */
enum MMDrawerSide {
    case none
    case left
    case right
}

struct MMOpenDrawerGestureMode : OptionSetType {
    let rawValue: UInt
    
    //    internal init(rawValue: UInt) //{ self.rawValue = rawValue }
    static let  None       = MMOpenDrawerGestureMode(rawValue: 0)
    static let  PanningNavigationBar        = MMOpenDrawerGestureMode(rawValue: 1 << 1)
    static let  PanningCenterView         = MMOpenDrawerGestureMode(rawValue: 1 << 2)
    static let  BezelPanningCenterView      = MMOpenDrawerGestureMode(rawValue: 1 << 3)
    static let  Custom       = MMOpenDrawerGestureMode(rawValue: 1 << 4)
    static let  All:MMOpenDrawerGestureMode = [PanningNavigationBar, PanningCenterView,BezelPanningCenterView,Custom]
}

struct MMCloseDrawerGestureMode : OptionSetType {
    let rawValue: UInt
    static let  None       = MMCloseDrawerGestureMode(rawValue: 0)
    static let  PanningNavigationBar        = MMCloseDrawerGestureMode(rawValue: 1 << 1)
    static let  PanningCenterView         = MMCloseDrawerGestureMode(rawValue: 1 << 2)
    static let  BezelPanningCenterView      = MMCloseDrawerGestureMode(rawValue: 1 << 3)
    static let  TapNavigationBar      = MMCloseDrawerGestureMode(rawValue: 1 << 4)
    static let  TapCenterView      = MMCloseDrawerGestureMode(rawValue: 1 << 5)
    static let  PanningDrawerView      = MMCloseDrawerGestureMode(rawValue: 1 << 6)
    static let  Custom      = MMCloseDrawerGestureMode(rawValue: 1 << 7)
    static let  All:MMCloseDrawerGestureMode   = [PanningNavigationBar, PanningCenterView,BezelPanningCenterView,TapNavigationBar,TapCenterView,PanningDrawerView,Custom]
    
}

enum MMDrawerOpenCenterInteractionMode {
    case None
    case Full
    case NavigationBarOnly
}


// MARK: - 常量
let MMDrawerDefaultWidth:Float = 280.0;
let MMDrawerDefaultAnimationVelocity:Float = 840.0;

let MMDrawerDefaultFullAnimationDelay:NSTimeInterval = 0.10;

let MMDrawerDefaultBounceDistance:Float = 50.0;

let MMDrawerDefaultBounceAnimationDuration:NSTimeInterval = 0.2;
let MMDrawerDefaultSecondBounceDistancePercentage:Float = 0.25;

let MMDrawerDefaultShadowRadius:Float = 10.0;
let MMDrawerDefaultShadowOpacity:Float = 0.8;

let MMDrawerMinimumAnimationDuration:NSTimeInterval = 0.15;

let MMDrawerBezelRange:Float = 20.0;

let MMDrawerPanVelocityXAnimationThreshold:Float = 200.0;

/** The amount of overshoot that is panned linearly. The remaining percentage nonlinearly asymptotes to the max percentage. */
let MMDrawerOvershootLinearRangePercentage:Float = 0.75;

/** The percent of the possible overshoot width to use as the actual overshoot percentage. */
let MMDrawerOvershootPercentage:Float = 0.1;

let MMDrawerLeftDrawerKey:String = "MMDrawerLeftDrawer"
let MMDrawerRightDrawerKey:String = "MMDrawerRightDrawer"
let MMDrawerCenterKey:String = "MMDrawerCenter"
let MMDrawerOpenSideKey:String = "MMDrawerOpenSide"


func bounceKeyFrameAnimationForDistanceOnView(distance:Float, view:UIView?) -> (CAKeyframeAnimation) {
    let factors:[Float] = [0, 32, 60, 83, 100, 114, 124, 128, 128, 124, 114, 100, 83, 60, 32,
    0, 24, 42, 54, 62, 64, 62, 54, 42, 24, 0, 18, 28, 32, 28, 18, 0]
    
    var values:[Float] = []
    
    for i:Int in 0 ..< 32  {
        
        let positionOffset:Float = factors[i]/128.0 * distance + Float(CGRectGetMaxX(view!.bounds))
        values.append(positionOffset)
    }
    
    let animation:CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "position.x")
    animation.repeatCount = 1;
    animation.duration = 0.8
    animation.fillMode = kCAFillModeForwards
    animation.values = values
    animation.removedOnCompletion = true
    animation.autoreverses = false
    
    return animation
}

// MARK: - 自定义block类型

typealias MMDrawerControllerDrawerVisualStateBlock = ((drawerController:MMDrawerController? , drawerSide:MMDrawerSide , percentVisible:CGFloat ) -> ())?
typealias MMDrawerGestureShouldRecognizeTouchBlock =  ((drawerController:MMDrawerController?, gesture:UIGestureRecognizer?, touch:UITouch?) -> (BooleanType))?
typealias MMDrawerGestureCompletionBlock = ((drawerController:MMDrawerController?, gesture:UIGestureRecognizer?) -> ())?

// MARK: - MMDrawerCenterContainerView
class MMDrawerCenterContainerView:UIView {

    var centerInteractionMode:MMDrawerOpenCenterInteractionMode?
    var openSide:MMDrawerSide?
    
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var hitView:UIView? = super.hitTest(point, withEvent: event)
        if hitView != nil && self.openSide != MMDrawerSide.none {
            let navBar:UINavigationBar? = self.navigationBarContainedWithinSubviewsOfView(self)
            let navBarFrame:CGRect = navBar!.convertRect(navBar!.bounds, toView: self)
            
            if (self.centerInteractionMode == MMDrawerOpenCenterInteractionMode.NavigationBarOnly && CGRectContainsPoint(navBarFrame, point)) ||  self.centerInteractionMode == MMDrawerOpenCenterInteractionMode.None {
                hitView = nil;
            }
        }
        return hitView
    }
    
    func navigationBarContainedWithinSubviewsOfView(view:UIView) ->(UINavigationBar){
        
        var navBar:UINavigationBar?
        for subview in view.subviews {
        
            if view.isKindOfClass(UINavigationBar) {
                navBar = view as? UINavigationBar
                break
            }else {
                
                navBar = self.navigationBarContainedWithinSubviewsOfView(subview)
                if navBar != nil {
                    break;
                }
            }
            
        }
        
        return navBar!
    
    }
}

// MARK: - pulic properties

class MMDrawerController:UIViewController {
    
    
    
    /**
     The center view controller.
     
     This can only be set via the init methods, as well as the `setNewCenterViewController:...` methods. The size of this view controller will automatically be set to the size of the drawer container view controller, and it's position is modified from within this class. Do not modify the frame externally.
     */
    var centerViewController:UIViewController?
    
    /**
     The left drawer view controller.
     
     The size of this view controller is managed within this class, and is automatically set to the appropriate size based on the `maximumLeftDrawerWidth`. Do not modify the frame externally.
     */
    var leftViewController:UIViewController?
    
    /**
     The right drawer view controller.
     
     The size of this view controller is managed within this class, and is automatically set to the appropriate size based on the `maximumRightDrawerWidth`. Do not modify the frame externally.
     */
    var rightViewController:UIViewController?
    
    
    /**
     The maximum width of the `leftDrawerViewController`.
     
     By default, this is set to 280. If the `leftDrawerViewController` is nil, this property will return 0.0;
     */
    var maximumLeftDrawerWidth:Float?
    
    /**
     The maximum width of the `rightDrawerViewController`.
     
     By default, this is set to 280. If the `rightDrawerViewController` is nil, this property will return 0.0;
     
     */
    var maximumRightDrawerWidth:Float?
    
    /**
     The visible width of the `leftDrawerViewController`.
     
     Note this value can be greater than `maximumLeftDrawerWidth` during the full close animation when setting a new center view controller;
     */
    var visibleLeftDrawerWidth:Float?
    
    /**
     The visible width of the `rightDrawerViewController`.
     
     Note this value can be greater than `maximumRightDrawerWidth` during the full close animation when setting a new center view controller;
     */
    var visibleRightDrawerWidth:Float?
    
    /**
     The animation velocity of the open and close methods, measured in points per second.
     
     By default, this is set to 840 points per second (three times the default drawer width), meaning it takes 1/3 of a second for the `centerViewController` to open/close across the default drawer width. Note that there is a minimum .1 second duration for built in animations, to account for small distance animations.
     */
    var animationVelocity:Float?
    
    /**
     A boolean that determines whether or not the panning gesture will "hard-stop" at the maximum width for a given drawer side.
     
     By default, this value is set to YES. Enabling `shouldStretchDrawer` will give the pan a gradual asymptotic stopping point much like `UIScrollView` behaves. Note that if this value is set to YES, the `drawerVisualStateBlock` can be passed a `percentVisible` greater than 1.0, so be sure to handle that case appropriately.
     */
    var shouldStretchDrawer:BooleanType?
    
    /**
     The current open side of the drawer.
     
     Note this value will change as soon as a pan gesture opens a drawer, or when a open/close animation is finished.
     */
//    var openSide:MMDrawerSide?
    
    /**
     How a user is allowed to open a drawer using gestures.
     
     By default, this is set to `MMOpenDrawerGestureModeNone`. Note these gestures may affect user interaction with the `centerViewController`, so be sure to use appropriately.
     */
    var openDrawerGestureModeMask:MMOpenDrawerGestureMode?
    
    /**
     How a user is allowed to close a drawer.
     
     By default, this is set to `MMCloseDrawerGestureModeNone`. Note these gestures may affect user interaction with the `centerViewController`, so be sure to use appropriately.
     */
    var closeDrawerGestureModeMask:MMCloseDrawerGestureMode?
    
    /**
     The value determining if the user can interact with the `centerViewController` when a side drawer is open.
     
     By default, it is `MMDrawerOpenCenterInteractionModeNavigationBarOnly`, meaning that the user can only interact with the buttons on the `UINavigationBar`, if the center view controller is a `UINavigationController`. Otherwise, the user cannot interact with any other center view controller elements.
     */
    var centerHiddenInteractionMode:MMDrawerOpenCenterInteractionMode?
    
    /**
     The flag determining if a shadow should be drawn off of `centerViewController` when a drawer is open.
     
     By default, this is set to YES.
     */
    var showsShadow:BooleanType?
    
    /**
     The shadow radius of `centerViewController` when a drawer is open.
     
     By default, this is set to 10.0f;
     */
    var shadowRadius:Float?
    
    /**
     The shadow opacity of `centerViewController` when a drawer is open.
     
     By default, this is set to 0.8f;
     */
    var shadowOpacity:Float?
    
    /**
     The shadow offset of `centerViewController` when a drawer is open.
     
     By default, this is set to (0, -3);
     */
    var shadowOffset:CGSize?
    
    /**
     The color of the shadow drawn off of 'centerViewController` when a drawer is open.
     
     By default, this is set to the systme default (opaque black).
     */
    var shadowColor:UIColor?
    
    /**
     The flag determining if a custom background view should appear beneath the status bar, forcing the child content to be drawn lower than the status bar.
     
     By default, this is set to NO.
     */
    var showsStatusBarBackgroundView:BooleanType?
    
    /**
     The color of the status bar background view if `showsStatusBarBackgroundView` is set to YES.
     
     By default, this is set `[UIColor blackColor]`.
     */
    var statusBarViewBackgroundColor:UIColor?
    
    /**
     The value determining panning range of centerView's bezel if the user can open drawer with 'MMOpenDrawerGestureModeBezelPanningCenterView' or close drawer with 'MMCloseDrawerGestureModeBezelPanningCenterView' .
     
     By default, this is set 20.0f.
     */
    var bezelPanningCenterViewRange:Float?
    
    /**
     The value determining if the user can open or close drawer with panGesture velocity.
     
     By default, this is set 200.0f.
     */
    var panVelocityXAnimationThreshold:Float?
    
    
    
    // MARK: - internal property
    
    var _maximumRightDrawerWidth:Float?
    var _maximumLeftDrawerWidth:Float?
    var _statusBarViewBackgroundColor:UIColor?
    
    var openSide:MMDrawerSide?
    
     // how to  decalare readwrite property
    
    var childControllerContainerView:UIView?
    var centerContainerView:MMDrawerCenterContainerView?
    var dummyStatusBarView:UIView?
    
    var startingPanRect:CGRect?
    var drawerVisualState:MMDrawerControllerDrawerVisualStateBlock?
    var gestureShouldRecognizeTouch:MMDrawerGestureShouldRecognizeTouchBlock?
    var gestureCompletion:MMDrawerGestureCompletionBlock?
    var animatingDrawer:BooleanType?
    
    // MARK: - init function
    
    ///---------------------------------------
    /// @name Initializing a `MMDrawerController`
    ///---------------------------------------
    
    /**
     Creates and initializes an `MMDrawerController` object with the specified center view controller, left drawer view controller, and right drawer view controller.
     
     @param centerViewController The center view controller. This argument must not be `nil`.
     @param leftDrawerViewController The left drawer view controller.
     @param rightDrawerViewController The right drawer controller.
     
     @return The newly-initialized drawer container view controller.
     */
    
    
    
     convenience init(centerViewcontroller:UIViewController, leftDrawerViewController:UIViewController, rightDrawerViewController:UIViewController) {
        
        self.init()
        
        self.centerViewController = centerViewcontroller
        self.leftViewController =  leftDrawerViewController
        self.rightViewController = rightDrawerViewController
        
    }
   
    /**
     Creates and initializes an `MMDrawerController` object with the specified center view controller, left drawer view controller.
     
     @param centerViewController The center view controller. This argument must not be `nil`.
     @param leftDrawerViewController The left drawer view controller.
     
     @return The newly-initialized drawer container view controller.
     */
    convenience init(centerViewController:UIViewController, leftDrawerViewController:UIViewController) {
        
    }
    
    /**
     Creates and initializes an `MMDrawerController` object with the specified center view controller, right drawer view controller.
     
     @param centerViewController The center view controller. This argument must not be `nil`.
     @param rightDrawerViewController The right drawer controller.
     
     @return The newly-initialized drawer container view controller.
     */
    convenience init(centerViewController:UIViewController, rightDrawerViewController:UIViewController) {
        
    }
    
    // MARK: - public function
    
    ///---------------------------------------
    /// @name Opening and Closing a Drawer
    ///---------------------------------------
    
    /**
     Toggles the drawer open/closed based on the `drawer` passed in.
     
     Note that if you attempt to toggle a drawer closed while the other is open, nothing will happen. For example, if you pass in MMDrawerSideLeft, but the right drawer is open, nothing will happen. In addition, the completion block will be called with the finished flag set to NO.
     
     @param drawerSide The `MMDrawerSide` to toggle. This value cannot be `MMDrawerSideNone`.
     @param animated Determines whether the `drawer` should be toggle animated.
     @param completion The block that is called when the toggle is complete, or if no toggle took place at all.
     */
    func toggleDrawerSide(drawerSide:MMDrawerSide, animated:BooleanType, completion:(finished:BooleanType) ->()) {
        
    }
    
    /**
     Closes the open drawer.
     
     @param animated Determines whether the drawer side should be closed animated
     @param completion The block that is called when the close is complete
     
     */
    func closeDrawerAnimated(animated:BooleanType, completion:(finished:BooleanType) ->()) {
    
    }
    
    /**
     Opens the `drawer` passed in.
     
     @param drawerSide The `MMDrawerSide` to open. This value cannot be `MMDrawerSideNone`.
     @param animated Determines whether the `drawer` should be open animated.
     @param completion The block that is called when the toggle is open.
     
     */
    func openDrawerSide(drawerSide:MMDrawerSide, animated:BooleanType, completion:(finished:BooleanType) ->()? ) {
    
    }
    
    ///---------------------------------------
    /// @name Setting a new Center View Controller
    ///---------------------------------------
    
    /**
     Sets the new `centerViewController`.
     
     This sets the view controller and will automatically adjust the frame based on the current state of the drawer controller. If `closeAnimated` is YES, it will immediately change the center view controller, and close the drawer from its current position.
     
     @param centerViewController The new `centerViewController`.
     @param closeAnimated Determines whether the drawer should be closed with an animation.
     @param completion The block called when the animation is finsihed.
     
     */
    func setCenterViewController(centerViewController:UIViewController?, closeAnimated:BooleanType, completion:(finished:BooleanType) ->()) {
    
    }
    
    /**
     Sets the new `centerViewController`.
     
     This sets the view controller and will automatically adjust the frame based on the current state of the drawer controller. If `closeFullAnimated` is YES, the current center view controller will animate off the screen, the new center view controller will then be set, followed by the drawer closing across the full width of the screen.
     
     @param newCenterViewController The new `centerViewController`.
     @param fullCloseAnimated Determines whether the drawer should be closed with an animation.
     @param completion The block called when the animation is finsihed.
     
     */
    func setCenterViewController(newCenterViewController:UIViewController?, fullCloseAnimated:BooleanType, completion:(finished:BooleanType) ->()) {
    
    }

    
    ///---------------------------------------
    /// @name Animating the Width of a Drawer
    ///---------------------------------------
    
    /**
     Sets the maximum width of the left drawer view controller.
     
     If the drawer is open, and `animated` is YES, it will animate the drawer frame as well as adjust the center view controller. If the drawer is not open, this change will take place immediately.
     
     @param width The new width of left drawer view controller. This must be greater than zero.
     @param animated Determines whether the drawer should be adjusted with an animation.
     @param completion The block called when the animation is finished.
     
     */
    func setMaximumLeftDrawerWidth(width:Float, animated:BooleanType, completion:(finished:BooleanType) ->()) {
    
    }

    
    /**
     Sets the maximum width of the right drawer view controller.
     
     If the drawer is open, and `animated` is YES, it will animate the drawer frame as well as adjust the center view controller. If the drawer is not open, this change will take place immediately.
     
     @param width The new width of right drawer view controller. This must be greater than zero.
     @param animated Determines whether the drawer should be adjusted with an animation.
     @param completion The block called when the animation is finished.
     
     */
    func setMaximumRightDrawerWidth(width:Float, animated:BooleanType, completion:(finished:BooleanType) ->()) {
    
    }
    ///---------------------------------------
    /// @name Previewing a Drawer
    ///---------------------------------------
    
    /**
     Bounce preview for the specified `drawerSide` a distance of 40 points.
     
     @param drawerSide The drawer to preview. This value cannot be `MMDrawerSideNone`.
     @param completion The block called when the animation is finsihed.
     
     */
    func bouncePreviewForDrawerSide(drawerSide:MMDrawerSide, completion:(finished:BooleanType) ->()) {
        
    }

    
    /**
     Bounce preview for the specified `drawerSide`.
     
     @param drawerSide The drawer side to preview. This value cannot be `MMDrawerSideNone`.
     @param distance The distance to bounce.
     @param completion The block called when the animation is finsihed.
     
     */
    func bouncePreviewForDrawerSide(drawerSide:MMDrawerSide, distance:Float, completion:(finished:BooleanType) ->()) {
        
    }

    
    ///---------------------------------------
    /// @name Custom Drawer Animations
    ///---------------------------------------
    
    /**
     Sets a callback to be called when a drawer visual state needs to be updated.
     
     This block is responsible for updating the drawer's view state, and the drawer controller will handle animating to that state from the current state. This block will be called when the drawer is opened or closed, as well when the user is panning the drawer. This block is not responsible for doing animations directly, but instead just updating the state of the properies (such as alpha, anchor point, transform, etc). Note that if `shouldStretchDrawer` is set to YES, it is possible for `percentVisible` to be greater than 1.0. If `shouldStretchDrawer` is set to NO, `percentVisible` will never be greater than 1.0.
     
     Note that when the drawer is finished opening or closing, the side drawer controller view will be reset with the following properies:
     
     - alpha: 1.0
     - transform: CATransform3DIdentity
     - anchorPoint: (0.5,0.5)
     
     @param drawerVisualStateBlock A block object to be called that allows the implementer to update visual state properties on the drawer. `percentVisible` represents the amount of the drawer space that is current visible, with drawer space being defined as the edge of the screen to the maxmimum drawer width. Note that you do have access to the drawerController, which will allow you to update things like the anchor point of the side drawer layer.
     */
    func setDrawerVisualStateBlock(drawerVisualStateBlock: (MMDrawerController,MMDrawerSide,Float) -> ()?) {
    
    }
    
    ///---------------------------------------
    /// @name Gesture Completion Handling
    ///---------------------------------------
    
    /**
     Sets a callback to be called when a gesture has been completed.
     
     This block is called when a gesture action has been completed. You can query the `openSide` of the `drawerController` to determine what the new state of the drawer is.
     
     @param gestureCompletionBlock A block object to be called that allows the implementer be notified when a gesture action has been completed.
     */
    func setGestureCompletionBlock(gestureCompletionBlock: (MMDrawerController,UIGestureRecognizer) -> ()?) {
    
    }
    
    ///---------------------------------------
    /// @name Custom Gesture Handler
    ///---------------------------------------
    
    /**
     Sets a callback to be called to determine if a UIGestureRecognizer should recieve the given UITouch.
     
     This block provides a way to allow a gesture to be recognized with custom logic. For example, you may have a certain part of your view that should accept a pan gesture recognizer to open the drawer, but not another a part. If you return YES, the gesture is recognized and the appropriate action is taken. This provides similar support to how Facebook allows you to pan on the background view of the main table view, but not the content itself. You can inspect the `openSide` property of the `drawerController` to determine the current state of the drawer, and apply the appropriate logic within your block.
     
     Note that either `openDrawerGestureModeMask` must contain `MMOpenDrawerGestureModeCustom`, or `closeDrawerGestureModeMask` must contain `MMCloseDrawerGestureModeCustom` for this block to be consulted.
     
     @param gestureShouldRecognizeTouchBlock A block object to be called to determine if the given `touch` should be recognized by the given gesture.
     */
    func setGestureShouldRecognizeTouchBlock(gestureShouldRecognizeTouchBlock:(MMDrawerController,UIGestureRecognizer,UITouch) -> (BooleanType)) {
    
    }

    
    
    // MARK: -  getter setter 
    func setRightDrawerViewController(rightDrawerViewController:UIViewController) {
    
    }
    
    func setLeftDrawerViewController(leftDrawerViewController:UIViewController) {
        
    }
    
    func setDrawerViewController(viewController:UIViewController?, drawerSide:MMDrawerSide){
        
        let currentSideViewController:UIViewController? = self.sideDrawerViewControllerForSide(drawerSide)
        
        if currentSideViewController == viewController {
            return
        }
        
        if currentSideViewController != nil {
            
            currentSideViewController?.beginAppearanceTransition(false , animated: false)
            currentSideViewController?.view.removeFromSuperview()
            currentSideViewController?.endAppearanceTransition()
            currentSideViewController?.willMoveToParentViewController(nil)
            currentSideViewController?.removeFromParentViewController()
            
        }
        
        var autoResizingMask:UIViewAutoresizing = UIViewAutoresizing.None
        if drawerSide == MMDrawerSide.left {
            self.leftViewController = viewController
            autoResizingMask = [UIViewAutoresizing.FlexibleRightMargin,UIViewAutoresizing.FlexibleHeight]
        }else if drawerSide == MMDrawerSide.right {
            self.leftViewController = viewController
            autoResizingMask = [UIViewAutoresizing.FlexibleLeftMargin,UIViewAutoresizing.FlexibleHeight]
        }
        
        
        if viewController != nil {
            
            self.addChildViewController(viewController!)
            
            if self.openSide == drawerSide && self.chil {
                
            }
        }
    }

   
    func setCenterViewController(centerViewController:UIViewController){
    
         [self setCenterViewController:centerViewController animated:NO];
    }
    

    
    // MARK: - helper
    
    func sideDrawerViewControllerForSide(drawerSide:MMDrawerSide) -> UIViewController {
        var sideDrawerViewController:UIViewController?
        if drawerSide != MMDrawerSide.none {
            sideDrawerViewController = self.childViewControllerForSide(drawerSide)
        }
        
        return sideDrawerViewController!
    }
    
    func childViewControllerForSide(drawerSide:MMDrawerSide) ->UIViewController {
        var childViewController:UIViewController?
        switch  drawerSide {
        case .left:
            childViewController = self.leftViewController
            break
        case .right:
            childViewController = self.rightViewController
            break
        case .none:
            childViewController = self.centerViewController
            break
        }
        return childViewController!
    }
    
    // MARK: - 
    // MARK: - 
    // MARK: - 
    // MARK: - 
    // MARK: - 
    // MARK: - 
    // MARK: - 
    
    
}







