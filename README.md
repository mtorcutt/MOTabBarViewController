# Usage 

## Intialize Tab Bar with View Controllers

```
MOTabBarViewController *tabBarViewController = [MOTabBarViewController new];
tabBarViewController.delegate                = self;

UIViewController *firstViewController = [UIViewController new];

UINavigationController *firstNavigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
firstNavigationController.tabBarItem.image        = [UIImage imageNamed:@"ExampleImageOne"];

UIViewController *secondViewController = [UIViewController new];

UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
secondNavigationController.tabBarItem.image        = [UIImage imageNamed:@"ExampleImageTwo"];

tabBarViewController.viewControllers = @[ firstNavigationController, secondNavigationController ];
```

## Delegate Methods

######```- (void)MOTabBarViewControllerDidSelectIndex:(NSInteger)index;```
Anytime a tab bar is selected, this method will return the selected index.

