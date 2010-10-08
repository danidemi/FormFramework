#import "UIViewUtils.h"


@implementation UIViewUtils

+(UIView*)rootViewOf:(UIView*)aView{
	if(!aView.superview){
		return aView;
	}else{
		return [UIViewUtils rootViewOf:aView.superview];
	}
}

+(void)disableTabBarItems:(UITabBar*)tabBar{
	for (UITabBarItem *tabBarItem in [tabBar items]) {
		[tabBarItem setEnabled:NO];
	}
}

+(void)enableTabBarItems:(UITabBar*)tabBar{
	for (UITabBarItem *tabBarItem in [tabBar items]) {
		[tabBarItem setEnabled:YES];
	}
}

+(void)disableNavigationBarItems:(UINavigationBar*)navigationBar{
	navigationBar.userInteractionEnabled = NO;
}

+(void)enableNavigationBarItems:(UINavigationBar*)navigationBar{
	navigationBar.userInteractionEnabled = YES;
}
@end
