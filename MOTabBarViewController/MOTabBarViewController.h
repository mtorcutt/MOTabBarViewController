//
//  MOTabBarViewController.h
//  WhatText
//
//  Created by Michael Orcutt on 4/12/14.
//  Copyright (c) 2014 Michael Orcutt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOTabBarViewControllerDelegate <NSObject>

@optional

///------------------------------------------------
/// @name Optional delegate methods
///------------------------------------------------

/**
 - MOTabBarViewControllerDidSelectIndex is called when
 view controllers change to a new index.
 */
- (void)MOTabBarViewControllerDidSelectIndex:(NSInteger)index;

@end


@interface MOTabBarViewController : UIViewController

///------------------------------------------------
/// @name Tab bar
///------------------------------------------------

/**
 * tabBar contains the tabs associated with each 
 * view controller. The tab class used is MOTabBarItem.
 */
@property (strong, nonatomic) UITabBar *tabBar;


///------------------------------------------------
/// @name Child view controllers
///------------------------------------------------

/**
 * viewControllers are the tab bar child view controllers
 */
@property (nonatomic, copy) NSArray *viewControllers;

/**
 * selectedViewController is the currently selected tab child view controller
 */
@property (nonatomic, readonly) UIViewController *selectedViewController;

/**
 * selectedIndex is the currently selected tab index
 */
@property (nonatomic, assign) NSUInteger selectedIndex;

///------------------------------------------------
/// @name Highlight
///------------------------------------------------

/**
 - isTabBarItemHighlightedAtIndex: returns YES or NO 
 for the supplied tab bar item index.
 */
- (BOOL)isTabBarItemHighlightedAtIndex:(NSInteger)index;

/**
 - setTabBarItemHighlighted:: highlights the provided index.
 */
- (void)setTabBarItemHighlighted:(BOOL)highlighted atIndex:(NSInteger)index;

///------------------------------------------------
/// @name Select view controllers
///------------------------------------------------

/**
 - setSelectedIndex selects a tab based upon index
 */
- (void)setSelectedIndex:(NSUInteger)index;

///------------------------------------------------
/// @name Delegate
///------------------------------------------------

/**
 * delegate is the tab bars delegate to relay 
 * change messages.
 */
@property (weak, nonatomic) id<MOTabBarViewControllerDelegate> delegate;

@end
