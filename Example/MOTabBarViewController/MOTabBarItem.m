//
//  MOTabBarItem.m
//  InstagramLikes
//
//  Created by Michael Orcutt on 1/23/14.
//  Copyright (c) 2014 Michael Orcutt. All rights reserved.
//

#import "MOTabBarItem.h"

@implementation MOTabBarItem

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // By default, userInteractionEnabled is set to NO on
        // UIImageView. Change this to YES for tapping purposes.
        self.userInteractionEnabled = YES;
        
        // Set contentMode to UIViewContentModeCenter
        self.contentMode = UIViewContentModeCenter;

        // Initialize highlightedIndicatorImageView, set properties, and add to subview
        self.notificationIndicatorImageView             = [[UIImageView alloc] init];
        self.notificationIndicatorImageView.image       = [UIImage imageNamed:@"HighlightIndicator"];
        self.notificationIndicatorImageView.contentMode = UIViewContentModeCenter;
        self.notificationIndicatorImageView.hidden      = YES;
        
        [self addSubview:self.notificationIndicatorImageView];

        // Initialize tapGesture and add as gesture recogonizer
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Layout setup
    CGRect bounds = self.bounds;
    
    // highlightedIndicatorImageView frame setup
    CGRect notificationIndicatorImageViewFrame;
    notificationIndicatorImageViewFrame.size   = CGSizeMake(bounds.size.width, self.notificationIndicatorImageView.image.size.height);
    notificationIndicatorImageViewFrame.origin = CGPointMake(0.0, (bounds.size.height - notificationIndicatorImageViewFrame.size.height));
    
    // Set highlightedIndicatorImageView frame from highlightedIndicatorImageViewFrame
    self.notificationIndicatorImageView.frame = notificationIndicatorImageViewFrame;
}

#pragma mark - Gesture

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    // Return tapBlock
    if(self.tapBlock) {
        self.tapBlock();
    }
}

@end
