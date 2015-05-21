//
//  MOTabBarViewController.m
//  WhatText
//
//  Created by Michael Orcutt on 4/12/14.
//  Copyright (c) 2014 Michael Orcutt. All rights reserved.
//

#import "MOTabBarViewController.h"

#import "MOTabBarItem.h"

@interface MOTabBarViewController ()

///------------------------------------------------
/// @name Tab bar
///------------------------------------------------

/**
 * selectedSegmentLine is the view that indicates the
 * tab is selected.
 */
@property (strong, nonatomic) UIView *selectedSegmentLine;

@end

NSInteger const TabBarItemTagOffset = 9999;

@implementation MOTabBarViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initalize tabBar, set properties, and add subview
    self.tabBar              = [UITabBar new];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent  = YES;
    
    [self.view addSubview:self.tabBar];
    
    // Initalize selectedSegmentLine, set properties, and add subview to tabBar
    self.selectedSegmentLine                    = [UIView new];
    self.selectedSegmentLine.backgroundColor    = [UIColor colorWithRed:155.0/255.0 green:194.0/255.0 blue:34.0/255.0 alpha:1.0];
    
    [self.tabBar addSubview:self.selectedSegmentLine];
    
    // Call reloadTabBar to add child view controllers
    [self reloadTabBar];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    self.tabBar              = nil;
    self.selectedSegmentLine = nil;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Layout setup
    CGRect viewBounds = self.view.bounds;
    
    // tabBar frame setup
    CGRect tabBarFrame;
    tabBarFrame.size   = CGSizeMake(viewBounds.size.width, 49.0); // UI height guidelines for UITabBar state 49.0 pixels
    tabBarFrame.origin = CGPointMake(0.0, (viewBounds.size.height - tabBarFrame.size.height));
    
    // Set tabBar frame as tabBarFrame
    self.tabBar.frame = tabBarFrame;
    
    // Tab bar items setup
    __block CGRect tabBarItemFrame;
    tabBarItemFrame.size = CGSizeMake(floorf(tabBarFrame.size.width / self.viewControllers.count), tabBarFrame.size.height);
    
    // Iterate over tab bar subviews
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        // If the tab bar subview matches MOTabBarItem class,
        // layout using tabBarItemFrame
        if([obj isKindOfClass:[MOTabBarItem class]]) {
            // Set MOTabBarItem frame from tabBarItemFrame
            [obj setFrame:tabBarItemFrame];
            
            // Offset x origin
            tabBarItemFrame.origin.x += tabBarItemFrame.size.width;
        }
        
    }];
    
    // - layoutSelectedSegmentUnderline handles selectedSegmentUnderline layout
    [self layoutSelectedSegmentUnderline];
}

- (void)layoutSelectedSegmentUnderline
{
    CGFloat selectedSegmentLineInset = 4.0;
    
    CGRect tabBarBounds = self.tabBar.bounds;
    
    CGFloat tabBarItemWidth = (tabBarBounds.size.width / self.viewControllers.count);
    
    CGRect selectedSegmentLineFrame;
    selectedSegmentLineFrame.size   = CGSizeMake((tabBarItemWidth - selectedSegmentLineInset * 2.0), 3.0);
    selectedSegmentLineFrame.origin = CGPointMake(((tabBarItemWidth * _selectedIndex) + selectedSegmentLineInset), 0.0);
    
    self.selectedSegmentLine.frame = selectedSegmentLineFrame;
}

#pragma mark - Tab bar

- (void)reloadTabBar
{
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if([obj isKindOfClass:[MOTabBarItem class]]) {
            [obj removeFromSuperview];
        }
        
    }];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        MOTabBarItem *tabBarItem    = [[MOTabBarItem alloc] init];
        tabBarItem.image            = [[obj tabBarItem] image];
        tabBarItem.highlightedImage = [[obj tabBarItem] selectedImage];
        tabBarItem.tag              = (TabBarItemTagOffset + idx);

        if(self.selectedIndex == idx) {
            tabBarItem.highlighted = YES;
        } else {
            tabBarItem.highlighted = NO;
        }
        
        tabBarItem.tapBlock = ^{
            [self setSelectedIndex:idx];
        };
        
        [self.tabBar addSubview:tabBarItem];
        
    }];
    
	NSUInteger lastIndex = _selectedIndex;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}

#pragma mark - View controllers

- (void)setViewControllers:(NSArray *)newViewControllers
{
	UIViewController *oldSelectedViewController = self.selectedViewController;
    
    [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[obj willMoveToParentViewController:nil];
		[obj removeFromParentViewController];
    }];
    
	_viewControllers = [newViewControllers copy];
    
	NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if(newIndex != NSNotFound) {
        _selectedIndex = newIndex;
    } else if(newIndex < [_viewControllers count]) {
        _selectedIndex = newIndex;
    } else {
        _selectedIndex = 0;
    }
    
    [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[self addChildViewController:obj];
		[obj didMoveToParentViewController:self];
    }];

    if ([self isViewLoaded]) {
        [self reloadTabBar];
    }
}

#pragma mark - Tab bar selection methods

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    // If the selected index is out of range, return
    if(selectedIndex > (self.viewControllers.count - 1)) {
        return;
    }
    
	if (![self isViewLoaded]) {
        
        // If the view is not loaded yet, set selectedIndex
		_selectedIndex = selectedIndex;
        
	} else if (_selectedIndex != selectedIndex) {
        
        // Setup for setting selectedIndex
		UIViewController *fromViewController;
		UIViewController *toViewController;
        
		if(_selectedIndex != NSNotFound) {
            
            // Deselect previously selected selectedIndex
			MOTabBarItem *tabBarItem = (MOTabBarItem *)[self.tabBar viewWithTag:(TabBarItemTagOffset + _selectedIndex)];
            tabBarItem.highlighted   = NO;
            
            // set fromViewController from previously selected selectedViewController
			fromViewController = self.selectedViewController;
            
		}
        
        // Set selected index
		_selectedIndex = selectedIndex;
        
		if (_selectedIndex != NSNotFound) {
			MOTabBarItem *tabBarItem = (MOTabBarItem *)[self.tabBar viewWithTag:(TabBarItemTagOffset + _selectedIndex)];
            tabBarItem.highlighted   = YES;

			toViewController = self.selectedViewController;
		}
        
        // Animate change to selectedSegmentUnderline frame
        [UIView animateWithDuration:.20 animations:^{
            [self layoutSelectedSegmentUnderline];
        }];
        
        if(toViewController == nil) {

            // Remove fromViewController
            [fromViewController willMoveToParentViewController:nil];
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];

		} else if(fromViewController == nil) {
            
            // toViewController frame
            toViewController.view.frame = self.view.bounds;
            
            // Add toViewController
            [self.view insertSubview:toViewController.view belowSubview:self.tabBar];
            [self addChildViewController:toViewController];
            [toViewController didMoveToParentViewController:self];
            
        } else {
            
            // Remove fromViewController
            [fromViewController willMoveToParentViewController:nil];
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];
            
            // toViewController frame
            toViewController.view.frame = self.view.bounds;
            
            // Add toViewController
            [self.view insertSubview:toViewController.view belowSubview:self.tabBar];
            [self addChildViewController:toViewController];
            [toViewController didMoveToParentViewController:self];
            
        }
        
        // Send delegate methods for changes
        if([self.delegate respondsToSelector:@selector(MOTabBarViewControllerDidSelectIndex:)]) {
            [self.delegate MOTabBarViewControllerDidSelectIndex:_selectedIndex];
        }
        
	}
}

#pragma mark - Selected view controller methods

- (UIViewController *)selectedViewController
{
	if (self.selectedIndex != NSNotFound) {
        return [self.viewControllers objectAtIndex:self.selectedIndex];
    } else {
        return nil;
    }
}

#pragma mark - Index highlighted

- (BOOL)isTabBarItemHighlightedAtIndex:(NSInteger)index
{
    MOTabBarItem *tabBarItem = (MOTabBarItem *)[self.tabBar viewWithTag:(TabBarItemTagOffset + index)];
    
    BOOL highlighted;
    
    if(tabBarItem.notificationIndicatorImageView.hidden) {
        highlighted = NO;
    } else {
        highlighted = YES;
    }
    
    return highlighted;
}

- (void)setTabBarItemHighlighted:(BOOL)highlighted atIndex:(NSInteger)index
{
    MOTabBarItem *tabBarItem = (MOTabBarItem *)[self.tabBar viewWithTag:(TabBarItemTagOffset + index)];

    if(highlighted) {
        tabBarItem.notificationIndicatorImageView.hidden = NO;
    } else {
        tabBarItem.notificationIndicatorImageView.hidden = YES;
    }
}

@end
