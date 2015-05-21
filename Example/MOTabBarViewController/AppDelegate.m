//
//  AppDelegate.m
//  MOTabBarViewController
//
//  Created by Michael Orcutt on 5/4/14.
//  Copyright (c) 2014 Michael Orcutt. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - Application States

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window                 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // -customizeApplicationAppearance sets default apperance properties
    [self customizeApplicationAppearance];
    
    // Initialize tabBarViewController and set properties
    self.tabBarViewController          = [MOTabBarViewController new];
    self.tabBarViewController.delegate = self;
    
    // Initialize standard view controllers for tabBarViewController example purposes
    
    // The first example view controller is chats view controller
    UIViewController *chatsViewController = [UIViewController new];
    chatsViewController.title             = NSLocalizedString(@"Chats", nil);

    UINavigationController *chatsNavigationController = [[UINavigationController alloc] initWithRootViewController:chatsViewController];
    chatsNavigationController.tabBarItem.image        = [UIImage imageNamed:@"Chats"];
    
    // The second example view controller is users view controller
    UIViewController *usersViewController = [UIViewController new];
    usersViewController.title             = NSLocalizedString(@"Users", nil);

    UINavigationController *usersNavigationController = [[UINavigationController alloc] initWithRootViewController:usersViewController];
    usersNavigationController.tabBarItem.image        = [UIImage imageNamed:@"Users"];

    // The third example view controller is settings view controller
    UIViewController *settingsViewController = [UIViewController new];
    settingsViewController.title             = NSLocalizedString(@"Settings", nil);
    
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    settingsNavigationController.tabBarItem.image        = [UIImage imageNamed:@"Settings"];
    
    // Set tabBarViewController view controllers
    self.tabBarViewController.viewControllers = @[ chatsNavigationController, usersNavigationController, settingsNavigationController ];
    
    // Set tabBarViewController' as rootViewController
    self.window.rootViewController = self.tabBarViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Stimulate tab bar item highlighted at second tab
    [self.tabBarViewController setTabBarItemHighlighted:YES atIndex:1];
}

#pragma mark - MOTabBarViewControllerDelegate methods

- (void)MOTabBarViewControllerDidSelectIndex:(NSInteger)index
{
    // Deselect tab bar for example purposes
    if([self.tabBarViewController isTabBarItemHighlightedAtIndex:index]) {
        [self.tabBarViewController setTabBarItemHighlighted:NO atIndex:index];
    }
}

#pragma mark - Customize

- (void)customizeApplicationAppearance
{
    // Set UINavigationBar title text attributes
    NSDictionary *navigationBarTitleTextAttributes = @{ NSFontAttributeName            : [UIFont fontWithName:@"Ubuntu" size:19.0],
                                                        NSForegroundColorAttributeName : [UIColor colorWithWhite:.20 alpha:1.0] };
    
    [[UINavigationBar appearance] setTitleTextAttributes:navigationBarTitleTextAttributes];
}

@end
