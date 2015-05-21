//
//  AppDelegate.h
//  MOTabBarViewController
//
//  Created by Michael Orcutt on 5/4/14.
//  Copyright (c) 2014 Michael Orcutt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MOTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, MOTabBarViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

///------------------------------------------------
/// @name Tab bar
///------------------------------------------------

/**
 * tabBarViewController is the applications custom
 * tab bar.
 */
@property (strong, nonatomic) MOTabBarViewController *tabBarViewController;

@end
