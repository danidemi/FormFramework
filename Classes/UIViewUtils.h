#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIViewUtils : NSObject {

}
+(UIView*)rootViewOf:(UIView*)aView;
+(void)disableTabBarItems:(UITabBar*)tabBar;
+(void)enableTabBarItems:(UITabBar*)tabBar;
+(void)disableNavigationBarItems:(UINavigationBar*)navigationBar;
+(void)enableNavigationBarItems:(UINavigationBar*)navigationBar;
@end
