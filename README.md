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

self.tabBarViewController.viewControllers = @[ firstNavigationController, secondNavigationController ];
```
