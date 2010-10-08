#import "Example0AppDelegate.h"
#import "Example0.h"
@implementation Example0AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption{
	
	Example0* controller = [[Example0 alloc] initWithNibName:@"Example0" bundle:nil];
	[window addSubview:controller.view];
	[controller release];
	
	[window makeKeyAndVisible];
	
	return YES;
	
}

@end
