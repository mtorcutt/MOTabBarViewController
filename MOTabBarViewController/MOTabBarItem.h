//
//  MOTabBarItem.h
//  InstagramLikes
//
//  Created by Michael Orcutt on 1/23/14.
//  Copyright (c) 2014 Michael Orcutt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapBlock)(void);

@interface MOTabBarItem : UIImageView

///------------------------------------------------
/// @name Notification Indicator
///------------------------------------------------

/**
 * notificationIndicatorImageView is used to indicate
 * the tab is highlighted / has a notification.
 *
 * @note by default this view is hidden.
 */
@property (strong, nonatomic) UIImageView *notificationIndicatorImageView;

///------------------------------------------------
/// @name Blocks
///------------------------------------------------

/**
 * tapBlock is a block used to handle tap gesture
 * to the tab.
 */
@property (copy, nonatomic) TapBlock tapBlock;

@end
